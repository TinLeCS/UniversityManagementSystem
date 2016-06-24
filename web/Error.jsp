<%-- 
    Document   : Error
    Created on : Apr 26, 2012, 9:37:06 PM
    Author     : Leader
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%
            String type = request.getParameter("type");
            if (type.equals("student"))
                out.println("<meta http-equiv=refresh content=3;URL=ManagerManageStudentNew.jsp>");
            else
                out.println("<meta http-equiv=refresh content=3;URL=ManagerManageCourseNew.jsp>");               
        %>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <style type="text/css">
            body{
                background: url('Images/Error.jpg') no-repeat center top;
            }
        </style>
        <title>Error!</title>
    </head>
    <body>
        <DIV align="center" style="position: absolute; top:83px; left:610px; width:450px; height:30px">
            <p>
                <span style="font-size: 30px">
                    <font color="red" face="Arial Black, Gadget, sans-serif">
                        <%
                            if (type.equals("student"))
                                out.println("This student ID has existed. Please, try again!");
                            else
                                out.println("This course ID has existed. Please, try again!");
                        %>
                    </font>
                </span>
            </p>
        </DIV>
    </body>
</html>
