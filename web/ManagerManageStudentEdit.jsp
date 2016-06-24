<%-- 
    Document   : edit
    Created on : Apr 16, 2012, 11:56:38 AM
    Author     : Leader
--%>
<%@page import="java.sql.*"%>
<%@page import="DatabaseController.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <%
        String sql = "SELECT * FROM student WHERE studentID='" + request.getParameter("ID") + "'";
        ResultSet rs = Database.executeQuery(sql);
        rs.first();
    %>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/ManageStudent.css" TYPE="text/css">
        <script type="text/javascript">
            function checkMatch(){
                var pass = profile.password.value;
                var rePass = profile.rePassword.value;
                if (pass != rePass){
                    alert("Your Password is inconsistent!");
                    profile.password.value = "";
                    profile.rePassword.value = "";
                    return false; 
                }
                return true;
            }
        </script>
        <title>Edit Student with ID <%= rs.getString(1)%></title>
    </head>
    <body>
        <%
            String isManager = (String) session.getAttribute("isManager");
            if (isManager != null){
        %>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="ManagerManageStudentIndex.jsp">
                <img src="Images/Back.png" title="Back">
            </a>              
        </div>
        <div id="body" style="top:250px">
            <form name ="profile" action="StudentController?action=Edit&ID=<%= rs.getString(1)%>" method="post" onsubmit="return checkMatch()">
                <table align="center">                
                    <tr>
                        <td><b>Student ID</b></td>
                        <td><%= rs.getString(1)%></td>
                    </tr>
                    <tr>
                        <td><b>School</b></td>
                        <td><select name="school">
                                <option>Computer Science and Engineering</option>
                                <option>Business Administration</option>
                                <option>Electrical Engineering</option>
                                <option>Biology Technology</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Name</b></td>
                        <td><input class="edit" type="text" name="name" value="<%= rs.getString(3)%>" required></td>
                    </tr>
                    <tr>
                        <td><b>Password</b></td>
                        <td><input class="edit" type="password" name="password" value="<%= rs.getString(2)%>" required></td>
                    </tr>
                    <tr>
                        <td><b>Re-enter Password</b></td>
                        <td><input class="edit" type="password" name="rePassword" value="<%= rs.getString(2)%>" required></td>
                    </tr>
                    <tr>
                        <td><b>Sex</b></td>
                        <td>
                            <table width="100%">
                                <tr align="center">
                                    <%
                                        if (rs.getString(4).equals("Male")){
                                    %>
                                            <td>
                                                <input type="radio" name="sex" value="Male" checked><img src="Images/Male.png" title="Male">  
                                            </td>
                                            <td>
                                                <input type="radio" name="sex" value="Female"><img src="Images/Female.png" title="Female">   
                                            </td>
                                    <%
                                        }
                                        else{
                                    %>
                                                <td>
                                                    <input type="radio" name="sex" value="Male"><img src="Images/Male.png" title="Male">  
                                                </td>
                                                <td>
                                                    <input type="radio" name="sex" value="Female" checked><img src="Images/Female.png" title="Female">   
                                                </td>
                                    <%
                                        }
                                    %>                                                           
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Phone Number</b></td>
                        <td><input class="edit" type="text" name="phone" value="<%= rs.getString(7)%>"></td>
                    </tr>
                    <tr>
                        <td><b>Email</b></td>
                        <td><input class="edit" type="email" name="mail" value="<%= rs.getString(6)%>"></td>
                    </tr>
                    <tr>
                        <td><b>Address</b></td>
                        <td><input class="edit" type="text" name="address" value="<%= rs.getString(8)%>"></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2"><button type="submit" id="update"></button></td>
                    </tr>
                </table>   
            </form>
        </div>
        
        <%
            }
        %>        
    </body>
</html>
