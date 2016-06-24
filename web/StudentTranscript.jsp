<%-- 
    Document   : viewTranscript
    Created on : Apr 13, 2012, 1:06:24 PM
    Author     : Leader
--%>
<%@page import="java.sql.*"%>
<%@page import="DatabaseController.Database"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Student.css" TYPE="text/css">
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <title><jsp:getProperty name="currentUser" property="name"/>'s Transcript</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="StudentIndex.jsp"><img src="Images/Back.png" title="Back"></a>
        </div>
        <div id="body">
            <h1><jsp:getProperty name="currentUser" property="name"/>'s Transcript</h1>
            <b>Name: </b><jsp:getProperty name="currentUser" property="name"/><br/>
            <b>Sex: </b><jsp:getProperty name="currentUser" property="sex"/><br/>
            <b>Student ID: </b><jsp:getProperty name="currentUser" property="ID"/><br/>
            <b>School: </b><jsp:getProperty name="currentUser" property="school"/><br/>
            <b>Phone Number: </b><jsp:getProperty name="currentUser" property="phone"/><br/>
            <b>Email: </b><jsp:getProperty name="currentUser" property="mail"/><br/>
            <b>Address: </b><jsp:getProperty name="currentUser" property="address"/>            
            <table id="transcript" style="margin-left: 35px" width="80%">
                <tr>
                    <td colspan="3">
                        <h2>Failed Course List</h2>
                    </td>
                </tr>
                <tr bgcolor="aquamarine">
                    <th>Course Name</th>
                    <th>Number of Credit</th>
                    <th>Final Grade</th> 
                </tr>           
                <%
                    int totalCredit = 0;
                    double totalGrade = 0;
                    double GPA = 0;
                    String sql = String.format("SELECT courseName, creditNo, finalGrade "
                            + "FROM course NATURAL JOIN courseforstudent "
                            + "WHERE studentID = '%s' AND studied = TRUE AND passed = FALSE", currentUser.getID());
                    ResultSet rs = Database.executeQuery(sql);

                    while(rs.next()){
                %>
                        <tr>
                            <td><%= rs.getString(1)%></td>
                            <td align="center"><%= rs.getInt(2)%></td>
                            <td align="center"><%= rs.getDouble(3)%></td>
                        </tr>
                <%
                        if(rs.next()){
                %>
                        <tr class="alt">
                            <td><%= rs.getString(1)%></td>
                            <td align="center"><%= rs.getInt(2)%></td>
                            <td align="center"><%= rs.getDouble(3)%></td>
                        </tr>
                <%
                        }
                    }
                %>                                              
                <tr>
                    <td colspan="3"><h2>Completed Course List</h2></td>
                </tr>
                <tr bgcolor="aquamarine">
                    <th>Course Name</th>
                    <th>Number of Credit</th>
                    <th>Final Grade</th> 
                </tr>
            <%
                sql = String.format("SELECT courseName, creditNo, finalGrade "
                        + "FROM course NATURAL JOIN courseforstudent "
                        + "WHERE studentID = '%s' AND passed = TRUE", currentUser.getID());
                rs = Database.executeQuery(sql);

                while(rs.next()){
                    int credit = rs.getInt(2);
                    double finalGrade = rs.getDouble(3);
                    totalCredit += credit;
                    totalGrade += finalGrade*credit;

            %>
                    <tr>
                        <td><%= rs.getString(1)%></td>
                        <td align="center"><%= credit%></td>
                        <td align="center"><%= finalGrade%></td>
                    </tr>
            <%
                    if(rs.next()){
            %>
                    <tr class="alt">
                        <td><%= rs.getString(1)%></td>
                        <td align="center"><%= credit%></td>
                        <td align="center"><%= finalGrade%></td>
                    </tr>
            <%
                   }
                }
                GPA = totalGrade/totalCredit;
            %>
                <tr>
                    <td></td>
                    <td align="center"><b>Total credit: </b><%= totalCredit%></td>
                    <td align="center"><b>GPA: </b><%= String.format("%.2f", GPA)%></td>
                </tr>
            </table>
        </div>
    </body>
</html>
