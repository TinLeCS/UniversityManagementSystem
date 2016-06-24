/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseController;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
/**
 *
 * @author Leader
 */
@WebServlet(name = "CourseController", urlPatterns = {"/CourseController"})
public class CourseController extends HttpServlet {

    /**
     * Processes requests for both HTTP
     * <code>GET</code> and
     * <code>POST</code> methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try {                      
            String action = request.getParameter("action");
            
            if (action.equals("Edit")){
                update(request);
                response.sendRedirect("ManagerManageCourseIndex.jsp");
//                goToPage(request, response, "ManagerManageCourseIndex.jsp");
            }
                          
            else
                if (action.equals("Delete")){
                    delete(request);
                    response.sendRedirect("ManagerManageCourseIndex.jsp");
//                    goToPage(request, response, "ManagerManageCourseIndex.jsp");
                }
            else
                if (action.equals("Create")){
                    create(request);
                    response.sendRedirect("ManagerManageCourseIndex.jsp");
//                    goToPage(request, response, "ManagerManageCourseIndex.jsp");
                }
            else
                if (action.equals("Remove")){
                    String courseID = request.getParameter("courseID");
                    String studentID = request.getParameter("studentID");
                    remove(courseID, studentID);
                    response.sendRedirect(String.format("ManagerManageCourseView.jsp?ID=%s", courseID));
//                    goToPage(request, response, String.format("ManagerManageCourseView.jsp?ID=%s", courseID));
                }
        }catch (SQLException e){
            goToPage(request, response, "Error.jsp?type=course");
        }
        finally {            
            out.close();
        }
    }
    
    private void remove(String courseID, String studentID) throws ClassNotFoundException, SQLException{
        String sql = String.format("DELETE FROM courseforstudent WHERE "
                + "courseID = '%s' AND studentID = '%s'", courseID, studentID); 
        
        Database.executeUpdate(sql);
        Database.close();
    }
    
    private void create(HttpServletRequest request) throws ClassNotFoundException, SQLException{
        String ID = request.getParameter("ID");
        String type = request.getParameter("type");
        String name = request.getParameter("name");
        int credit = Integer.parseInt(request.getParameter("credit"));
        String description = request.getParameter("description");
        int midterm = Integer.parseInt(request.getParameter("midterm"));
        int assignment = Integer.parseInt(request.getParameter("assignment"));
        int finalTest = 100 - midterm - assignment;
   
        Connection con = Database.getConnection();
        String sql = "INSERT INTO course VALUES(?, ?, ?, ?, ?, ?, ?, ?)";
        PreparedStatement stat = con.prepareStatement(sql);
        
        stat.setString(1, ID);
        stat.setString(2, name);
        stat.setString(3, type);
        stat.setString(4, description);
        stat.setInt(5, credit);
        stat.setInt(6, assignment);
        stat.setInt(7, midterm);
        stat.setInt(8, finalTest);
        
        stat.executeUpdate();
        stat.close();
        con.close();
    }
    
    private void delete(HttpServletRequest request) throws ClassNotFoundException, SQLException{
        String ID = request.getParameter("ID");
        String sql1 = String.format("DELETE FROM courseforstudent WHERE courseID ='%s'", ID);
        String sql2 = String.format("DELETE FROM course WHERE courseID ='%s'", ID);
        
        Database.executeUpdate(sql1);
        Database.executeUpdate(sql2);
        
        Database.close();  
    }
    
    private void update(HttpServletRequest request) throws ClassNotFoundException, SQLException, IOException{
        Connection con = Database.getConnection();
        String sql = "UPDATE course SET courseName = ? , type = ?, description = ?, creditNo = ?, assignmentPercent = ?,"
                + "midtermPercent = ?,finalPercent = ?  WHERE courseID = ?";
        PreparedStatement stat = con.prepareStatement(sql);
        int midterm = Integer.parseInt(request.getParameter("midterm"));
        int assignment = Integer.parseInt(request.getParameter("assignment"));
        
        stat.setString(1, request.getParameter("name"));
        stat.setString(2, request.getParameter("type"));
        stat.setString(3, request.getParameter("description"));
        stat.setInt(4, Integer.parseInt(request.getParameter("credit")));
        stat.setInt(5, assignment);
        stat.setInt(6, midterm);
        stat.setInt(7, 100 - midterm - assignment);
        stat.setString(8, request.getParameter("ID"));

        stat.executeUpdate();
        stat.close();
        con.close();
    }
    
    private void goToPage(HttpServletRequest request, HttpServletResponse response, String URL) throws ServletException, IOException{
        RequestDispatcher dispatcher = request.getRequestDispatcher(URL);
        
        dispatcher.forward(request, response); 
    }
    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP
     * <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourseController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CourseController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Handles the HTTP
     * <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(CourseController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CourseController.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>
}
