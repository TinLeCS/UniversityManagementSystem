<%-- 
    Document   : new
    Created on : Apr 16, 2012, 11:56:29 AM
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
        <LINK REL=STYLESHEET HREF="CSS/ManageCourse.css" TYPE="text/css">
        <script type="text/javascript">
            function checkEmpty(){
                var ID = create.ID.value;
                var name = create.name.value;

                if (ID == ""){
                    alert("You can not create a course without Course ID!");
                    create.ID.focus();
                    return false; 
                }
                else if (name == ""){
                    alert("You can not create a course without Name!");
                    create.name.focus();
                    return false; 
                }
                return true;
            }
        </script>
        <title>Course Information Page</title>
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
            <form name="create" action="CourseController?action=Create" method="post" onsubmit="return checkEmpty()">
                <table align="center">                
                    <tr>
                        <td><b>Course ID</b></td>
                        <td><input class="edit" type="text" name="ID"></td>
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
                        <td><input class="edit" type="text" name="name"></td>
                    </tr>
                    <tr>
                        <td><b>Credit</b></td>
                        <td><input class="num" min="1" max="10" type="number" name="credit" value="1"></td>
                    </tr>                
                    <tr>
                        <td><b>Description</b></td>
                        <td><textarea name="description" cols="29" rows="8" ></textarea></td>
                    </tr>
                    <tr>
                        <td><b>Assignment</b></td>
                        <td><input class="num" min="0" max="50" type="number" name="assignment" value="0"> %</td>
                    </tr>
                    <tr>
                        <td><b>Midterm Test</b></td>
                        <td><input class="num" min="0" max="40" type="number" name="midterm" value="0"> %</td>
                    </tr>
                    <tr>
                        <td><b>Final Test</b></td>
                        <td><i>Auto-Computed</i> %</td>
                    </tr>
                    <tr align="center">
                        <td colspan="2"><button type="submit" id="createButton"></button></td>
                    </tr>
                </table>
            </form>
        </div>      
    </body>
</html>
<%
    }
%>
