<%-- 
    Document   : manageStudent
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
        <LINK REL=STYLESHEET HREF="CSS/ManageStudent.css" TYPE="text/css">
        <script type="text/javascript">
            function createCookie(name, value) {
                document.cookie = name + "=" + value;
            }
        </script>
        <title>Student Management</title>
    </head>
    <body>              
        <div id="top">
            <img src="Images/Bar.png">
        </div>
        <div class="icon" style="left: 225px">
            <a href="ManagerIndex.jsp">
                <img src="Images/Back.png" title="Back">
            </a>
        </div>
        <div class="icon" style="left: 1000px">
            <a href="ManagerManageStudentNew.jsp">
                <img src="Images/Add Student.png" title="Add new student">
            </a> 
        </div>
        <div id="body">
            <center>
            <h1>Student List</h1>
                <form>
                    <input type="search" name="search" placeholder="Enter Student ID Here"><br/>
                    <input type="radio" name="filter" value="Business Administration">Business Administration&nbsp
                    <input type="radio" name="filter" value="Computer Science and Engineering">Computer Science and Engineering&nbsp
                    <input type="radio" name="filter" value="Electrical Engineering">Electrical Engineering&nbsp
                    <input type="radio" name="filter" value="Biology Technology">Biology Technology<br/>
                    <input type="submit" value="Filter">
                </form>
            </center>
            <br/>
            <hr/>
            <br/>
            <table align="center" border="1" width="60%">
                <tr>
                    <th align="left">Student ID</th>
                    <th>Student Name</th>
                    <th width="25%">Action</th>
                    <th>Status</th>
                </tr>
        <%
            String filter = request.getParameter("filter");
            String searchKey = request.getParameter("search");
            String sql;
            ResultSet rs;     
            if (searchKey == null && filter == null){
                sql = "SELECT studentID, name, approved FROM student";
                rs = Database.executeQuery(sql);
            }
            else if (searchKey != null && filter != null){           
                sql = String.format("SELECT studentID, name, approved FROM student WHERE "
                        + "studentID LIKE '%%%s%%' AND school = '%s'", searchKey, filter);
                rs = Database.executeQuery(sql);
                }
            else if (searchKey == null){
                    sql = String.format("SELECT studentID, name, approved FROM student WHERE school = '%s'", filter);         
                    rs = Database.executeQuery(sql);
                }
            else{
                sql = String.format("SELECT studentID, name, approved FROM student WHERE "
                        + "studentID LIKE '%%%s%%'", searchKey); 
                rs = Database.executeQuery(sql);
            } 
            while (rs.next()){
                String ID = rs.getString(1);
                String name = rs.getString(2);
                boolean approved = rs.getBoolean(3);
        %>
                <tr>
                    <td><%=ID%></td>
                    <td><a href="ManagerManageStudentView.jsp?ID=<%=ID%>"><%=name%></a></td>
                    <td>
                        <table width="100%">
                            <tr>
                                <td>
                                    <a href="ManagerManageStudentEdit.jsp?ID=<%=ID%>">
                                    <img src="Images/Edit Student.png" title="Edit"></a>            
                                </td>
                                <td>
                                    <a href="StudentController?action=Delete&ID=<%=ID%>" onclick="return confirm('Do you really want to delete? You cannot undelete after having deleted!');">
                                    <img src="Images/Delete Student.png" title="Delete"></a>       
                                </td>
                                <td>
                                    <a href="StudentRegisterCourse.jsp?ID=<%=ID%>" onclick="createCookie('register','<%=ID%>')">
                                    <img src="Images/Register.png" title="Register"></a>
                                </td>
                            </tr>
                        </table>  
                    </td>
                    <td align="center">
                        <a href="StudentController?action=Approve&ID=<%=ID%>">
                            <%= (approved) ? "<img src='Images/ApproveSmall.png' title='Click here to disapprove'>" : "<img src='Images/Disapprove.png' title='Click here to approve'>"%>
                        </a>
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
