<%-- 
    Document   : registerCourses
    Created on : Apr 13, 2012, 1:06:52 PM
    Author     : Leader
--%>

<%@page import="Beans.UserBean"%>
<%@page import="DatabaseController.Database"%>
<%@page import="java.sql.*"%> 
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Student.css" TYPE="text/css">
        <title>Registration Page</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div id="body">
            <%
                UserBean student = (UserBean) session.getAttribute("currentUser");              
                String studentID = request.getParameter("ID");
                String sql = "SELECT approved FROM Student WHERE studentID ='" + studentID + "'";
                ResultSet rs = Database.executeQuery(sql);
                rs.first();
                boolean approved = rs.getBoolean(1);
                if (!approved){

            %>
                    <jsp:include page='StudentDisapproveRegisterCourse.jsp' flush='true'/>
                    <%
                        if(student == null){
                    %>
                            <div class="icon2" style="left: 54px">
                                <a href="ManagerManageStudentIndex.jsp"><img src="Images/Back.png" title="Back"></a>
                            </div>
                            <div class="icon2" style="left: 825px">
                                <a href="StudentController?action=Approve&ID=<%= studentID%>" onclick=
                                    "return confirm('Do you really want to approve? You cannot register anymore after having approved');">
                                    <img src="Images/Approve.png" title="Approve">
                                </a> 
                            </div>
                    <%
                        }
                        else{
                    %>
                            <div class="icon2" style="left: 54px">
                                <a href="StudentIndex.jsp"><img src="Images/Back.png" title="Back"></a>
                            </div>
                            <div class="icon2" style="left: 825px">
                                <a href="StudentController?action=Approve&ID=<%= studentID%>" onclick=
                                    "return confirm('Do you really want to approve? You cannot register anymore after having approved');">
                                    <img src="Images/Approve.png" title="Approve">
                                </a> 
                            </div>                            
            <%
                        }    
                }
                else{
            %>
                    <jsp:include page='StudentApproveRegisterCourse.jsp' flush='true'/>
                    <%
                        if(student == null){
                    %>
                            <div class="icon2" style="left: 54px">
                                <a href="ManagerManageStudentIndex.jsp"><img src="Images/Back.png" title="Back"></a>
                            </div>                  
                    <%
                        }
                        else{
                    %>
                            <div class="icon2" style="left: 54px">
                                <a href="StudentIndex.jsp"><img src="Images/Back.png" title="Back"></a>
                            </div>            
            <%
                        }    
                }
            %> 
        </div>                                                
    </body>
</html>
