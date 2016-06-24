<%-- 
    Document   : index
    Created on : Apr 12, 2012, 7:08:57 PM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>
    <head id="head">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script type="text/javascript" src="JavaScript.js"></script>
        <LINK REL=STYLESHEET HREF="CSS/ManagerMain.css" TYPE="text/css">   
        <%
            String isManager = (String) session.getAttribute("isManager");
            if (isManager != null){
        %>     
        <title>Manager Page</title>
    </head>
    <body>
        <DIV class="icon" style="top:80px; ">
            <a href="ManagerManageStudentIndex.jsp">
                <img src="Images/Student Management.png" title="Student Management"></a>
        </DIV>
        <DIV class="icon" style="top:210px;">
            <a href="ManagerManageCourseIndex.jsp">
                <img src="Images/Course Management.png" title="Course Management"></a>
        </DIV>
        <DIV class="icon" style="top:350px;">
            <button id="logout" type="button" onclick="postRequest('StudentController?action=Logout')"></button>
        </DIV>        
    </body>
</html>
<%
    }
%>