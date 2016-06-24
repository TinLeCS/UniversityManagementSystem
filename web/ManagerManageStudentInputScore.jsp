<%-- 
    Document   : inputScore
    Created on : Apr 17, 2012, 5:33:19 AM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%
    String isManager = (String) session.getAttribute("isManager");
    if (isManager != null){
%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/ManageStudent.css" TYPE="text/css">
        <style type="text/css">
            .num
            {
                width: 45px;

            }
        </style>
        <title>Input Score Page</title>
    </head>
    <body>
        <% 
                String studentID = request.getParameter("studentID");
                String courseID = request.getParameter("courseID");
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
            <form action="CourseForStudentController?action=Compute&studentID=<%= studentID%>&courseID=<%= courseID%>" method="post">
                <table align="center" width="25%">
                    <tr>
                        <td colspan="2" align="center"><h2>Score's Detail</h2></td>
                    </tr>
                    <tr>
                        <td><b>Assignment</b></td>
                        <td><input class="num" type="number" min="0" max="100" value="0" name="assignment"></td>
                    </tr>
                    <tr>
                        <td><b>Midterm Test</b></td>
                        <td><input class="num" type="number" min="0" max="100" value="0" name="midterm"></td>
                    </tr>
                    <tr>
                        <td><b>Final Test</b></td>
                        <td><input class="num" type="number" min="0" max="100" value="0" name="final"></td>
                    </tr>
                    <tr align="center">
                        <td colspan="2"><button type="submit" id="submit"></button></td>
                    </tr>
                </table>   
            </form>
        </div>               
    </body>
</html>
<%
    }
%>
