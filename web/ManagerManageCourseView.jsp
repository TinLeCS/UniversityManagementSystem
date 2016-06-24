<%-- 
    Document   : view
    Created on : Apr 16, 2012, 8:13:56 PM
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
        String courseID = request.getParameter("ID");
        String sql = String.format("SELECT * FROM course WHERE courseID = '%s'", courseID);
        ResultSet rs = Database.executeQuery(sql);
        
        rs.first();
    %>    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/ManageCourse.css" TYPE="text/css">
        <title><%= rs.getString(2)%> Course's Details </title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="ManagerManageCourseIndex.jsp">
            <img src="Images/Back.png" title="Back"></a>  
        </div>
        <div id="body">
            <h2>Course's detail</h2>
            <table>
                <tr>
                    <td><b>ID</b></td>
                    <td><%= rs.getString(1)%></td>
                </tr>
                <tr>
                    <td><b>Name</b></td>
                    <td><%= rs.getString(2)%></td>
                </tr>  
                <tr>
                    <td><b>Type</b></td>
                    <td><%= rs.getString(3)%></td>
                </tr>  
                <tr>
                    <td><b>Credit</b></td>
                    <td><%= rs.getString(5)%></td>
                </tr>  
                <tr>
                    <td><b>Assignment Percentage</b></td>
                    <td><%= rs.getString(6)%> %</td>
                </tr>  
                <tr>
                    <td><b>Midterm Percentage</b></td>
                    <td><%= rs.getString(7)%> %</td>
                </tr>  
                <tr>
                    <td><b>Final Percentage</b></td>
                    <td><%= rs.getString(8)%> %</td>
                </tr>
                <tr>
                    <td><b>Description</b></td>
                    <td><%= rs.getString(4)%></td>
                </tr> 
            </table>
            <h2>Student List</h2>
            <table width="100%" border="1">
                <tr>
                    <th>Student ID</th>
                    <th>Student Name</th>
                    <th>Action</th>
                </tr>

            <%
                sql = String.format("SELECT studentID, name FROM"
                    + "(student NATURAL JOIN courseforstudent) WHERE courseID = '%s'", courseID);
                rs = Database.executeQuery(sql);
                while (rs.next()){
            %>
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td align="center">
                        <a href="CourseController?action=Remove&courseID=<%= courseID%>&studentID=<%= rs.getString(1)%>" 
                                        onclick="return confirm('Do you really want to remove this student?');">Remove
                        </a>
                    </td>
                </tr>
            <%
                }
            %>   
            </table>
        </div>          
    </body>
</html>
<%
    }
%>    