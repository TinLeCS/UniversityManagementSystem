<%-- 
    Document   : profile
    Created on : Apr 13, 2012, 1:07:44 PM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <LINK REL=STYLESHEET HREF="CSS/Student.css" TYPE="text/css">
        <script type="text/javascript">              
            function check(){
                var pass = profile.password.value;
                var rePass = profile.rePassword.value;

                if (pass == ""){
                    alert("You can not leave Password empty!");
                    profile.password.focus();
                    return false; 
                }
                else if (rePass == ""){
                    alert("You must fill both Password fields!");
                    profile.rePassword.focus();
                    return false;
                }
                else if (pass != rePass){
                    alert("Your Password is inconsistent!");
                    profile.password.value = "";
                    profile.rePassword.value = "";
                    return false; 
                }
                return true;
            }       
        </script>
        <style type="text/css">
            .edit
            {
                width: 250px;
                border: none;
            }
            
        </style>
        <title>Profile Page</title>
    </head>
    <body>
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="StudentIndex.jsp"><img src="Images/Back.png" title="Back"></a>
        </div>
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
        <jsp:setProperty name="currentUser" property="*"/>
        <div id="body">
            <form name="profile" onsubmit="return check()">
                <table align ="center">
                    <tr>
                        <td bgcolor="grey">
                            <table border="1">
                                <tr>
                                    <td bgcolor="white">
                                        <img src="Images/<%= (currentUser.getSex().equals("Male") ? "Male Profile.png" : "Female Profile.png")%>">
                                    </td>
                                </tr>
                            </table>
                        </td>
                        <td>
                            <table>                
                                <tr>
                                    <td><b>Student ID</b></td>
                                    <td><jsp:getProperty name="currentUser" property="ID"/>
                                </tr>
                                <tr>
                                    <td><b>School</b></td>
                                    <td><jsp:getProperty name="currentUser" property="school"/></td>
                                </tr>
                                <tr>
                                    <td><b>Name</b></td>
                                    <td><input class="edit" type="text" name="name" value="<jsp:getProperty name="currentUser" property="name"/>"></td>
                                </tr>
                                <tr>
                                    <td><b>Password</b></td>
                                    <td><input class="edit" type="password" name="password" value="<jsp:getProperty name="currentUser" property="password"/>"></td>
                                </tr>
                                <tr>
                                    <td><b>Re-enter Password</b></td>
                                    <td><input class="edit" type="password" name="rePassword" value="<jsp:getProperty name="currentUser" property="password"/>"></td>
                                </tr>
                                <tr>
                                    <td><b>Phone Number</b></td>
                                    <td><input class="edit" type="text" name="phone" value="<jsp:getProperty name="currentUser" property="phone"/>"></td>
                                </tr>
                                <tr>
                                    <td><b>Sex</b></td>
                                    <td>
                                        <table width="100%">
                                            <tr align="center">
                                                <%
                                                    if (currentUser.getSex().equals("Male")){
                                                %>
                                                        <td>
                                                            <input type="radio" name="sex" value="Male" checked><img src="Images/Male.png" title="Male">  
                                                        </td>
                                                        <td>
                                                            <input type="radio" name="sex" value="Female"><img src="Images/Female.png" title="Female">   
                                                        </td>
                                                <%
                                                    }
                                                    else{
                                                %>
                                                        <td>
                                                            <input type="radio" name="sex" value="Male"><img src="Images/Male.png" title="Male">  
                                                        </td>
                                                        <td>
                                                            <input type="radio" name="sex" value="Female" checked><img src="Images/Female.png" title="Female">   
                                                        </td>
                                                <%
                                                    }
                                                %>                                                           
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td><b>Email</b></td>
                                    <td><input class="edit" type="email" name="mail" value="<jsp:getProperty name="currentUser" property="mail"/>"></td>
                                </tr>
                                <tr>
                                    <td><b>Address</b></td>
                                    <td><input class="edit" type="text" name="address" value="<jsp:getProperty name="currentUser" property="address"/>"></td>
                                </tr>                      
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2" align="center"><button type="submit" id="update"></button></td>
                    </tr>
                </table>               
            </form> 
        </div>
                     
    </body>
</html>
