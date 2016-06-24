<%-- 
    Document   : StudentApprove
    Created on : Apr 30, 2012, 12:16:58 AM
    Author     : Leader
--%>

<%@page import="Beans.UserBean, DatabaseController.Database, Servlet.ServletUtilities, java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            #courses{
                font-family:"Trebuchet MS", Arial, Helvetica, sans-serif;
                border-collapse:collapse;
            }
            
            #courses td, #courses th{
                font-size:1.2em;
                border:1px solid #98bf21;
                padding:3px 7px 2px 7px;
            }
            
            #courses th {
                font-size:1.4em;
                text-align:left;
                padding-top:5px;
                padding-bottom:4px;
                background-color:#A7C942;
                color:#fff;
            }
            
            #courses tr.alt td {
                color:#000;
                background-color:#EAF2D3;
            }
        </style>
        <title>Approve</title>
    </head>
    <body align="center">
    <%
        Cookie cookies[] = request.getCookies();
        String studentID = ServletUtilities.getCookieValue(cookies, "register", "");
        
        String sql = String.format("SELECT courseID, courseName FROM course NATURAL JOIN "
            + "courseforstudent WHERE studentID = '%s' AND studied = FALSE", studentID);
        ResultSet rs = Database.executeQuery(sql);
        if (!rs.first())
        out.println("<h2>Your registration has been approved!</h2>"
                + "<h2>Not register any course</h2>");
        else{
            rs.beforeFirst();               
    %>          
            <h2>Your registration has been approved!</h2>
            <hr/>
            <h2>Current-semester Course List</h2>
            <table id="courses" align="center">
            <tr>
                <th>Course ID</th>
                <th width="70%">Course Name</th>
            </tr>
    <%
        while(rs.next()){
            String courseID = rs.getString(1);                               
    %>
            <tr>
                <td><%= courseID%></td>
                <td><%= rs.getString(2)%></td>
            </tr>
    <%
            if (rs.next()){
                courseID = rs.getString(1);     
    %>
            <tr class="alt">
                <td><%= courseID%></td>
                <td><%= rs.getString(2)%></td>
            </tr>
    <%
            }
        }
    %>
        </table>   
    <%
        }
    %>
    </body>
</html>
