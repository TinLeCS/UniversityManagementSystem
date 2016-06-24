<%-- 
    Document   : ProfilePop-Up
    Created on : May 14, 2012, 5:51:45 AM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile</title>
    </head>
    <body>
        <jsp:useBean id="currentUser" class="Beans.UserBean" scope="session"/>
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
                            <td><jsp:getProperty name="currentUser" property="name"/></td>
                        </tr>                        
                        <tr>
                            <td><b>Phone Number</b></td>
                            <td><jsp:getProperty name="currentUser" property="phone"/></td>
                        </tr>
                        <tr>
                            <td><b>Sex</b></td>
                            <td>
                            <%
                                if (currentUser.getSex().equals("Male")){
                            %>
                                    <img src="Images/Male.png" title="Male">                                                  
                            <%
                                }
                                else{
                            %>
                            <img src="Images/Female.png" title="Female">   
                            <%
                                }
                            %>                                                           
                            </td>
                        </tr>
                        <tr>
                            <td><b>Email</b></td>
                            <td><jsp:getProperty name="currentUser" property="mail"/></td>
                        </tr>
                        <tr>
                            <td><b>Address</b></td>
                            <td><jsp:getProperty name="currentUser" property="address"/></td>
                        </tr>                      
                    </table>
                </td>
            </tr>    
        </table>
    </body>
</html>
