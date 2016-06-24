<%-- 
    Document   : StudentDisapprove
    Created on : Apr 30, 2012, 12:17:18 AM
    Author     : Leader
--%>

<%@page import="Beans.UserBean, DatabaseController.Database, Servlet.ServletUtilities, java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style>
            a{
                text-decoration: none;
                color: black;
            }
            #description
            {
                position: relative;
            }
            #description a span 
            {
                display: none;
            }
            #description a:hover span 
            { 
                display: inline-block;
                position: absolute; 
                width: 295px;
                height: 135px;
                background-color: white;
                left: 220px; 
                top: -10px; 
                color: black; 
                padding: 5px;
                vertical-align: central;
                text-align: left;
                border: 1px solid #666;
            }
        </style>
        <title>Disapprove</title>
    </head>
    <body align="center">
    <%  
        Cookie cookies[] = request.getCookies();
        String studentID = ServletUtilities.getCookieValue(cookies, "register", "");
        String sql = String.format("SELECT courseName FROM course WHERE (type = 'General' "
        + "OR type = 'English' OR type = (SELECT school FROM student WHERE "
        + "studentID = '%s')) AND courseName NOT IN (SELECT courseName "
        + "FROM course NATURAL JOIN courseforstudent NATURAL JOIN student "
        + "WHERE studentID = '%s' AND (studied = FALSE OR passed = TRUE)) "
        + "ORDER BY type DESC", studentID, studentID);
        ResultSet rs = Database.executeQuery(sql);
    %>
        <table width="90%" algin="center">
            <tr>
                <th width="45%"><h2>Course List</h2></th>
                <th><h2>Your Registration</h2></th>
            </tr>
            <tr>
                <td>          
                    <%
                        if (!rs.first())
                            out.println("<h3>You have already resgistered every course!</h3>");
                        else{
                    %>
                    <form action="CourseForStudentController?action=Add&ID=<%= studentID%>" method="post">            
                        <h2>Select Course</h2>
                        <select name="course">
                        <%       
                            rs.beforeFirst();
                            while(rs.next()){          
                        %>
                                <option><%= rs.getString(1)%></option>
                        <%
                            }
                        %>
                        </select>
                        <input type="submit" value="Add"><br/>
                    </form>
                    <%
                        }
                    %> 
                </td>
                <td align="center">
                    <%
                        sql = String.format("SELECT courseID, courseName, description, creditNo FROM course NATURAL JOIN "
                                + "courseforstudent WHERE studentID = '%s' AND studied = FALSE", studentID);
                        rs = Database.executeQuery(sql);
                        if (!rs.first())
                            out.println("<h2>Not register any course</h2>");
                        else{
                            rs.beforeFirst();
                    %>
                            <table algin="center">
                                <tr>
                                    <th><h2>Course ID</h2></th>
                                    <th colspan="2"><h2>Course Name</h2></th>
                                </tr>
                                <%
                                    while(rs.next()){
                                        String courseID = rs.getString(1);                               
                                %>
                                        <tr>
                                            <td><%= courseID%></td>
                                            <td align="left">
                                                <p id="description">
                                                    <a href="#">
                                                        <%= rs.getString(2)%>
                                                        <span>
                                                            <b>Description</b><br/>
                                                            <%= rs.getString(3)%><br/>
                                                            <b>Number of Credit: </b>
                                                            <%= rs.getInt(4)%>
                                                        </span>
                                                    </a>
                                                </p>
                                            </td>
                                            <td><a href="CourseForStudentController?action=Remove&courseID=<%= courseID%>&studentID=<%= studentID%>">
                                                    <input type="button" value="Remove">
                                                </a>
                                            </td>
                                        </tr>
                                <%
                                   }
                                %>
                            </table>
                    <%
                        }
                    %>
                </td>
            </tr>
        </table>
    </body>
</html>
