<%-- 
    Document   : manageCourse
    Created on : Apr 15, 2012, 8:05:26 PM
    Author     : Leader
--%>
<%@page import="java.sql.*"%>
<%@page import="DatabaseController.Database"%>
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
        <title>Course Management</title>
    </head>
    <body>               
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="ManagerIndex.jsp">
            <img src="Images/Back.png" title="Back"></a>  
        </div>
        <div class="icon" style="left: 1000px">
            <a href="ManagerManageCourseNew.jsp">
                <img src="Images/Create Course.png" title="Create new course">
            </a>  
        </div>
        <div id="body">
            <center>
                <h1>Course List</h1>
                <form>
                    <input type="radio" name="filter" value="General">General&nbsp 
                    <input type="radio" name="filter" value="English">English&nbsp
                    <input type="radio" name="filter" value="Computer Science and Engineering">Computer Science and Engineering&nbsp
                    <input type="radio" name="filter" value="Business Administration">Business Administration&nbsp
                    <input type="radio" name="filter" value="Electrical Engineering">Electrical Engineering&nbsp
                    <input type="radio" name="filter" value="Biology Technology">Biology Technology&nbsp
                    <input type="submit" value="Filter">
                </form>
            </center>
            <br/>
            <hr/>
            <br/>
            <table align="center" border="1" width="50%">
                <tr>
                    <th align="left">Course ID</th>
                    <th>Course Name</th>
                    <th width="15%">Action</th>
                </tr>
        <%
            String filter = request.getParameter("filter");
            Connection con = Database.getConnection();
            String sql;
            ResultSet rs;
            Statement stat = null;      

            if (filter == null){
                sql = "SELECT courseID, courseName FROM course";
                stat = con.createStatement();
                rs = stat.executeQuery(sql);
            }
            else{
                sql = "SELECT courseID, courseName FROM course WHERE type = '" + filter +"'";
                stat = con.createStatement();           
                rs = stat.executeQuery(sql);
            }     
            while (rs.next()){
                String ID = rs.getString(1);
                String name = rs.getString(2);          
        %>
                <tr>
                    <td><%=ID%></td>
                    <td><a href="ManagerManageCourseView.jsp?ID=<%=ID%>"><%=name%></a></td>
                    <td>
                        <table width="100%">
                            <tr align="center">
                                <td>
                                    <a href="ManagerManageCourseEdit.jsp?ID=<%=ID%>">
                                    <img src="Images/Edit Course.png" title="Edit"></a>   
                                </td>
                                <td>
                                    <a href="CourseController?action=Delete&ID=<%=ID%>" 
                                    onclick="return confirm('Do you really want to delete? You cannot undelete after having deleted!');">
                                    <img src="Images/Delete Course.png" title="Delete"></a>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
        <%
            }
        %>     
            </table>
        </div>
    </body>
</html>
<%
    }
%>
