<%-- 
    Document   : index
    Created on : Mar 29, 2012, 5:16:06 AM
    Author     : Leader
--%>



<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head id="head">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/StudentMain.css" TYPE="text/css">
        <script type="text/javascript" src="JavaScript.js"></script> 
        <title>Student Manager</title>
    </head>
    <body>
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <div class="icon" style="left: 490px; top: 75px">           
            <a href="StudentProfile.jsp" onmouseover="postRequest('ProfilePop-Up.jsp')" onmouseout="closePopUp()"><img src="Images/Profile.png" title="Profile"></a> 
        </div>
        <div class="icon" style="left: 285px; top: 300px">
            <a href="StudentTranscript.jsp"><img src="Images/Transcript.png" title="Transcript"></a>
        </div>
        <div class="icon" style="left: 740px; top: 290px">
            <a href="StudentRegisterCourse.jsp?ID=<jsp:getProperty name="currentUser" property="ID"/>" 
               onclick="createCookie('register', '<jsp:getProperty name="currentUser" property="ID"/>')">
                <img src="Images/Student Register.png" title="Course Registration"></a>
        </div>
        <div class="icon" style="left: 545px; top: 515px">
            <button id="logout" type="button" onclick="postRequest('StudentController?action=Update')"></button>          
        </div>                
        <div align="center" id="message">
            <h1><font style="font-size: 22px" face="Segoe Script"><b>Welcome, <jsp:getProperty name="currentUser" property="name"/>!</b></font></h1>
        </div>
    </body>
</html>
