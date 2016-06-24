package DatabaseController;

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

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
import Beans.UserBean;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;
/**
 *
 * @author Leader
 */
@WebServlet(name = "LoginCheck", urlPatterns = {"/LoginCheck"})
public class LoginCheck extends HttpServlet {

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
            throws ServletException, IOException, ClassNotFoundException, SQLException, InstantiationException, IllegalAccessException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        try {
            HttpSession session = request.getSession();
            String user = request.getParameter("user");
            String pass = request.getParameter("pass");
                 
            if(user.equalsIgnoreCase("manager") && pass.equals("123")){
                String isManager = "true";
                session.setAttribute("isManager", isManager);
                
                response.getWriter().append("Manager");
            }
                
            else{
                String sql = String.format("SELECT * FROM student WHERE "
                        + "studentID = '%s' AND password = '%s'", user, pass );
                ResultSet rs = DatabaseController.Database.executeQuery(sql);
                if(rs.first()){
                    UserBean currentUser = new UserBean();

                    currentUser.setID(rs.getString(1));
                    currentUser.setPassword(rs.getString(2));
                    currentUser.setName(rs.getString(3));
                    currentUser.setSex(rs.getString(4));
                    currentUser.setSchool(rs.getString(5));
                    currentUser.setMail(rs.getString(6));
                    currentUser.setPhone(rs.getString(7));
                    currentUser.setAdress(rs.getString(8));

                    session.setAttribute("currentUser", currentUser);
                    response.getWriter().append("Student");
//                    response.getWriter().append("<html><head><meta http-equiv=refresh content=0;URL=StudentIndex.jsp></head></html>");
//                    goToPage(request, response, "StudentIndex.jsp");
                }
                else                       
//                    goToPage(request, response, "index.jsp");                    
                    response.getWriter().append("Invalid");
            }           
        }catch (Exception e){
            out.println("<html><head><title></title></head><body>" + e.getMessage() + "</body></html>");
        }finally {       
            out.close();
        }
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
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
        } catch (InstantiationException ex) {
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
        } catch (IllegalAccessException ex) {
            Logger.getLogger(LoginCheck.class.getName()).log(Level.SEVERE, null, ex);
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
