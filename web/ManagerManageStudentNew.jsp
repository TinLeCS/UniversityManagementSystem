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
        <LINK REL=STYLESHEET HREF="CSS/ManageStudent.css" TYPE="text/css">
        <script type="text/javascript">
            function checkEmpty(){
                var ID = add.ID.value;
                var name = add.name.value;
                var pass = add.password.value;
                var rePass = add.rePassword.value;

                if (ID == ""){
                    alert("You can not add a student without Student ID!");
                    add.ID.focus();
                    return false; 
                }
                else if (name == ""){
                    alert("You can not create a student without Name!");
                    add.name.focus();
                    return false; 
                }
                else if (pass == ""){
                    alert("You can not create a student without Password!");
                    add.password.focus();
                    return false; 
                }
                else if (rePass == ""){
                    alert("You must fill both Password fields!");
                    add.rePassword.focus();
                    return false;
                }
                else if (pass != rePass){
                    alert("Your Password is inconsistent!");
                    add.password.value = "";
                    add.rePassword.value = "";
                    return false; 
                }
                return true;
            }
        </script>
        <title>Student Information Page</title>
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
        <div id="body" style="top:250px">
            <form  name="add" action="StudentController?action=Add" method="post" onsubmit="return checkEmpty()">
                <table align="center">                
                    <tr>
                        <td><b>Student ID</b></td>
                        <td><input class="edit" type="text" name="ID"></td>
                    </tr>
                    <tr>
                        <td><b>School</b></td>
                        <td><select name="school">
                                <option>Computer Science and Engineering</option>
                                <option>Business Administration</option>
                                <option>Electrical Engineering</option>
                                <option>Biology Technology</option>
                            </select>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Name</b></td>
                        <td><input class="edit" type="text" name="name"></td>
                    </tr>
                    <tr>
                        <td><b>Password</b></td>
                        <td><input class="edit" type="password" name="password"></td>
                    </tr>
                    <tr>
                        <td><b>Re-enter Password</b></td>
                        <td><input class="edit" type="password" name="rePassword"></td>
                    </tr>
                    <tr>
                        <td><b>Sex</b></td>
                        <td>
                            <table width="100%">
                                <tr align="center">
                                    <td>
                                        <input type="radio" name="sex" value="Male" checked><img src="Images/Male.png" title="Male">  
                                    </td>
                                    <td>
                                        <input type="radio" name="sex" value="Female"><img src="Images/Female.png" title="Female">   
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td><b>Phone Number</b></td>
                        <td><input class="edit" type="text" name="phone"></td>
                    </tr>
                    <tr>
                        <td><b>Email</b></td>
                        <td><input class="edit" type="email" name="mail"></td>
                    </tr>
                    <tr>
                        <td><b>Address</b></td>
                        <td><input class="edit" type="text" name="address"></td>
                    </tr>
                    <tr align="center">                 
                        <td colspan="2"><button type="submit" id="addButton"></button></td>
                    </tr>
                </table>
            </form>
        </div>       
    </body>
</html>
<%
    }
%>
