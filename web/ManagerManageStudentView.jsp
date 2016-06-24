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
        String studentID = request.getParameter("ID");
        String sql = String.format("SELECT * FROM student WHERE studentID = '%s'", studentID);
        ResultSet rs = Database.executeQuery(sql);
        rs.first();
    %>    
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/ManageStudent.css" TYPE="text/css">
        <title>Student's Details </title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="ManagerManageStudentIndex.jsp">
                <img src="Images/Back.png" title="Back">
            </a>              
        </div>
        <div id="body">
            <h2>Student's detail</h2>
        <table>
            <tr>
                <td><b>ID</b></td>
                <td><%= rs.getString(1)%></td>
            </tr>
            <tr>
                <td><b>School</b></td>
                <td><%= rs.getString(5)%></td>
            </tr> 
            <tr>
                <td><b>Name</b></td>
                <td><%= rs.getString(3)%></td>
            </tr>
            <tr>
                <td><b>Sex</b></td>
                <td><img src="Images/<%= rs.getString(4)%>.png" title="<%= rs.getString(4)%>"</td>
            </tr>
            <tr>
                <td><b>Email</b></td>
                <td><%= rs.getString(6)%></td>
            </tr>  
            <tr>
                <td><b>Phone</b></td>
                <td><%= rs.getString(7)%></td>
            </tr>  
            <tr>
                <td><b>Address</b></td>
                <td><%= rs.getString(8)%></td>
            </tr>              
        </table>
            <h2>Already-studied Course List</h2>
            <table width="100%" border="1">
                <tr>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Final Grade</th>
                    <th>Status</th>
                </tr>
            <%
                sql = String.format("SELECT courseID, courseName, finalGrade, passed FROM"
                    + "(student NATURAL JOIN courseforstudent) NATURAL JOIN course WHERE studentID = '%s' AND studied = TRUE", studentID);
                rs = Database.executeQuery(sql);
                while (rs.next()){
            %>
                <tr>
                    <td><%= rs.getString(1)%></td>
                    <td><%= rs.getString(2)%></td>
                    <td align="center"><%= rs.getDouble(3)%></td>
                    <td align="center"><%= (rs.getBoolean(4)== true) ? "<img src='Images/Completed.png' title='Completed'>" : "<img src='Images/Failed.png' title='Failed'>"%></td>
                </tr>
            <%
                }
            %>   
            </table>
            <h2>Current-semester Course List</h2>
            <table width="100%" border="1">
                <tr>
                    <th>Course ID</th>
                    <th>Course Name</th>
                    <th>Action</th>
                </tr>
            <%
                sql = String.format("SELECT courseID, courseName FROM"
                    + "(student NATURAL JOIN courseforstudent) NATURAL JOIN course WHERE studentID = '%s' AND studied = FALSE", studentID);
                rs = Database.executeQuery(sql);
                while (rs.next()){
                    String courseID = rs.getString(1);
            %>
                <tr>
                    <td><%= courseID%></td>
                    <td><%= rs.getString(2)%></td>
                    <td align="center">
                        <a href="ManagerManageStudentInputScore.jsp?studentID=<%= studentID%>&courseID=<%= courseID%>">Complete</a>
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
