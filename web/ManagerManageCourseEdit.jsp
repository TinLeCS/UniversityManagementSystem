<%-- 
    Document   : edit
    Created on : Apr 16, 2012, 11:34:52 AM
    Author     : Leader
--%>
<%@page import="java.sql.*"%>
<%@page import="DatabaseController.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String isManager = (String) session.getAttribute("isManager");
    if (isManager != null){
%>
<html>
    <%
        String sql = "SELECT * FROM course WHERE courseID='" + request.getParameter("ID") + "'";
        ResultSet rs = Database.executeQuery(sql);
        
        rs.first();
    %> 
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/ManageCourse.css" TYPE="text/css">
        <title>Edit <%= rs.getString(2)%> Course</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="ManagerManageCourseIndex.jsp">
            <img src="Images/Back.png" title="Back"></a>  
        </div>
        <div id="body" style="top: 225px">
            <form action="CourseController?action=Edit&ID=<%= rs.getString(1)%>" method="post">
                <table align="center">                
                    <tr>
                        <td><b>Course ID</b></td>
                        <td><%= rs.getString(1)%></td>
                    </tr>
                    <tr>
                        <td><b>Type</b></td>
                        <td><select class="edit" name="type">
                                <option>General</option>
                                <option>English</option>
                                <option>Computer Science and Engineering</option>
                                <option>Business Administration</option>
                                <option>Electrical Engineering</option>
                                <option>Biology Technology</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Course Name</b></td>
                        <td><input class="edit" type="text" name="name" value="<%= rs.getString(2)%>" required></td>
                    </tr>
                    <tr>
                        <td><b>Credit</b></td>
                        <td><input class="num" min="1" max="10" type="number" name="credit" value="<%= rs.getString(5)%>"></td>
                    </tr>                
                    <tr>
                        <td><b>Description</b></td>
                        <td><textarea name="description" cols="29" rows="8" ><%= rs.getString(4)%></textarea></td>
                    </tr>
                    <tr>
                        <td><b>Assignment</b></td>
                        <td><input class="num" type="number" min="0" max="50" name="assignment" value="<%= rs.getString(6)%>"> %</td>
                    </tr>
                    <tr>
                        <td><b>Midterm Test</b></td>
                        <td><input class="num" type="number" min="0" max="40" name="midterm" value="<%= rs.getString(7)%>"> %</td>
                    </tr>
                    <tr>
                        <td><b>Final Test</b></td>
                        <td><%= rs.getString(8)%> %</td>
                    </tr>
                    <tr align="center">
                        <td colspan="2"><button type="submit" id="update"></button></td>
                    </tr>
                </table>
            </form>
        </div>            
    </body>
</html>
<%
    }
%>