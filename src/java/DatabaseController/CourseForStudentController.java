/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseController;
import java.sql.*;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author Leader
 */
@WebServlet(name = "CourseForStudentController", urlPatterns = {"/CourseForStudentController"})
public class CourseForStudentController extends HttpServlet {

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
            
            if (action.equals("Add"))
                add(request, response);
            else if (action.equals("Remove"))
                remove(request, response);
            else if(action.equals("Compute"))
                compute(request, response);            
        }catch (SQLException e){
            out.println(e.getMessage());               
        }   
        finally {            
            out.close();
        }
    }
    
    private void add(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException{
        String studentID = request.getParameter("ID");
        String name = request.getParameter("course");
        String courseID = "";
        String sql = "SELECT courseID FROM course WHERE courseName= '" + name + "'";
        ResultSet rs = Database.executeQuery(sql);
        
        while (rs.next()){
            courseID = rs.getString(1);
        }
        
        sql = String.format("INSERT INTO courseforstudent VALUES('%s', '%s', "
                + "default, default, default, default, default, default)", studentID, courseID);

        Database.executeUpdate(sql);
        
        String URL = "StudentRegisterCourse.jsp?ID=" + studentID;
        goToPage(request, response, URL);
    }
    
    private void remove(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException{
        String studentID = request.getParameter("studentID");
        String courseID = request.getParameter("courseID");
        String sql = String.format("DELETE FROM courseforstudent WHERE studentID='%s' AND courseID='%s'",
                studentID, courseID);
        Database.executeUpdate(sql);
        
        String URL = "StudentRegisterCourse.jsp?ID=" + studentID;
        goToPage(request, response, URL);
//        response.sendRedirect(URL);
    }
    
    private void compute(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, ServletException, IOException{
        int assignment = Integer.parseInt(request.getParameter("assignment"));
        int midterm = Integer.parseInt(request.getParameter("midterm"));
        int finalTest = Integer.parseInt(request.getParameter("final"));
        String studentID = request.getParameter("studentID");
        String courseID = request.getParameter("courseID");
        String sql = String.format("SELECT assignmentPercent, midtermPercent, "
                + "finalPercent FROM course WHERE courseID = '%s'", courseID);
        
        ResultSet rs = Database.executeQuery(sql);
        rs.first();
        
        double assRatio = rs.getDouble(1) / 100;
        double midRatio = rs.getDouble(2) / 100;
        double finalRatio = rs.getDouble(3) / 100;
        double finalGrade = assRatio*assignment + midRatio*midterm + finalRatio*finalTest;
        Boolean pass = (finalGrade >= 50) ? true: false; 
        
        sql = String.format("UPDATE courseforstudent SET assignmentScore = %d, "
                + "midtermTestScore = %d, finalTestScore = %d, finalGrade = %.2f, studied = TRUE, "
                + "passed = %s WHERE studentID = '%s' AND courseID = '%s'", 
                assignment, midterm, finalTest, finalGrade, pass, studentID, courseID);

        Database.executeUpdate(sql);
        
        String URL = "ManagerManageStudentView.jsp?ID=" + studentID;
        goToPage(request, response, URL);
//        response.sendRedirect(URL);       
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
            Logger.getLogger(CourseForStudentController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CourseForStudentController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(CourseForStudentController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(CourseForStudentController.class.getName()).log(Level.SEVERE, null, ex);
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
