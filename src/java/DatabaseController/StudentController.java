/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseController;

import Beans.UserBean;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
/**
 *
 * @author Leader
 */
@WebServlet(name = "StudentController", urlPatterns = {"/StudentController"})
public class StudentController extends HttpServlet {

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
            HttpSession session = request.getSession(true);
            
            if (action.equals("Logout")){

                session.invalidate();
                response.getWriter().append("Logout");                            
            }
            
            else
                if (action.equals("Edit") || action.equals("Update")){
                    update(request,response);
                    if (action.equals("Update")){
                
                        session.invalidate();
                        response.getWriter().append("Logout");
                    }
                }                                     
            else
                if(action.equals("Delete")){
                    delete(request);
                    
                    response.sendRedirect("ManagerManageStudentIndex.jsp");
                }
            else
                if (action.equals("Add")){
                    add(request);
                    
                    response.sendRedirect("ManagerManageStudentIndex.jsp");
                }
            else
                if (action.equals("Approve"))
                    approve(request,response);

        }catch(Exception e){
            response.sendRedirect("Error.jsp?type=student");
        }
        finally {            
            out.close();
        }
    }
    
    private void approve(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException, ServletException{       
        HttpSession session = request.getSession(true);
        UserBean student = (UserBean) session.getAttribute("currentUser");
        String ID = request.getParameter("ID");
        boolean approved;

        String sql = "SELECT approved FROM Student WHERE studentID ='" + ID + "'";
        ResultSet rs = Database.executeQuery(sql);
        
        rs.first();
        approved = !rs.getBoolean(1);
        sql = String.format("UPDATE student SET approved = %s WHERE studentID = '%s'", approved, ID);
        Database.executeUpdate(sql);
        
        if (student == null)
            response.sendRedirect("ManagerManageStudentIndex.jsp");
        else
            goToPage(request, response, "StudentIndex.jsp");
    }
    
    private void add(HttpServletRequest request) throws ClassNotFoundException, SQLException{
        String ID = request.getParameter("ID");
        String school = request.getParameter("school");
        String name = request.getParameter("name");
        String sex = request.getParameter("sex");
        String pass = request.getParameter("password");
        String mail = request.getParameter("mail");
        String phone = ("".equals(request.getParameter("phone"))) ? "No phone" : request.getParameter("phone");
        String add = request.getParameter("address");
        Connection con = Database.getConnection();
        String sql = "INSERT INTO student VALUES(?, ?, ?, ?, ?, ?, ?, ?, default)";
        PreparedStatement stat = con.prepareStatement(sql);
        
        stat.setString(1, ID);
        stat.setString(2, pass);
        stat.setString(3, name);
        stat.setString(4, sex);
        stat.setString(5, school);
        stat.setString(6, mail);
        stat.setString(7, phone);
        stat.setString(8, add);
        
        stat.executeUpdate();
        Database.close();
    }
    
    private void delete(HttpServletRequest request) throws ClassNotFoundException, SQLException{
        String ID = request.getParameter("ID");
        String sql1 = String.format("DELETE FROM courseforstudent WHERE studentID ='%s'", ID);
        String sql2 = String.format("DELETE FROM student WHERE studentID ='%s'", ID);
        
        Database.executeUpdate(sql1);
        Database.executeUpdate(sql2);
        
        Database.close();
        
    }
    private void update(HttpServletRequest request, HttpServletResponse response) throws ClassNotFoundException, SQLException, IOException, ServletException{
        HttpSession session = request.getSession(true);
        UserBean student = (UserBean) session.getAttribute("currentUser");
        Connection con = Database.getConnection();
        String sql1 = "UPDATE student SET name = ? , password = ?, sex = ?, school = ?, phone = ?, email = ?, address = ?  WHERE studentID = ?";
        String sql2 = "UPDATE student SET name = ? , password = ?, sex = ?, phone = ?, email = ?, address = ?  WHERE studentID = ?";
        PreparedStatement stat1 = con.prepareStatement(sql1);
        PreparedStatement stat2 = con.prepareStatement(sql2);
        
        if (student == null){         
            stat1.setString(1, request.getParameter("name"));
            stat1.setString(2, request.getParameter("password"));
            stat1.setString(3, request.getParameter("sex"));
            stat1.setString(4, request.getParameter("school"));
            stat1.setString(5, request.getParameter("phone"));
            stat1.setString(6, request.getParameter("mail"));
            stat1.setString(7, request.getParameter("address"));
            stat1.setString(8, request.getParameter("ID"));
            
            stat1.executeUpdate();
            stat1.close();
            con.close();

            response.sendRedirect("ManagerManageStudentIndex.jsp");
        }
        else{
            stat2.setString(1, student.getName());
            stat2.setString(2, student.getPassword());
            stat2.setString(3, student.getSex());
            stat2.setString(4, student.getPhone());
            stat2.setString(5, student.getMail());
            stat2.setString(6, student.getAddress());
            stat2.setString(7, student.getID());

            stat2.executeUpdate();
            stat2.close();
            con.close();

        }    
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
            Logger.getLogger(StudentController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StudentController.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(StudentController.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StudentController.class.getName()).log(Level.SEVERE, null, ex);
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
