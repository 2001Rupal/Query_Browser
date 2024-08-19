<%-- 
    Document   : login
    Created on : 19-Aug-2024, 4:34:08 pm
    Author     : RUPAL
--%>

<%@page import="DAO.BookDAO"%>
<%@page session="true"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Login</title>
        <style>
            body {
            background-color: #f0f7fa;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            color: #333;
        }
        .container {
                        background-color: #f2faff;
                padding: 0px;
                border-radius: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.2);
        }
        table {
            width: 500px;
                border-collapse: collapse;
        }
        table, th, td {
            padding: 20px;
             text-align: center;
        }
        h2{
            text-align: center;
        }
        th {
            background-color: #1f8aff;
                color: white;
                border: 1px solid #ddd;
        }
        td input[type="user"] {
            width: calc(100% - 22px);
                padding: 10px;
                margin: 5px 0;
                cursor: pointer;
                box-sizing: border-box;
                border: 1px solid #90caf9;
                border-radius: 5px;
        }
        td input[type="password"] {
            width: calc(100% - 22px);
                padding: 10px;
                margin: 5px 0;
                box-sizing: border-box;
                border: 1px solid #90caf9;
                cursor: pointer;
                border-radius: 5px;
        }
         td {
                border: 1px solid #ddd;
            }
        input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="reset"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 10px 20px;
            border-radius: 5px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        </style>
    </head>
    <br><!-- comment -->
    <br>
    <body>
        <div class="container">
    <center>
        <form method="post">
            <table border="1">
                <tr>
                    <td>user name</td>
                    <td><input type="user" name="txtname"></td>
                </tr>
                <tr>
                    <td> password </td>
                    <td><input type="password" name="pass"</td>
                </tr>
                <tr>
                    <td></td>
                    <td colspan="2" style=text-align:center;><input type="submit" name="Login..">
                    <input type="reset" name="Reset"
                    </td>
                </tr>
            </table>
        </form>
        
        <%
            String user=null,pass=null;
            user=request.getParameter("txtname");
            pass=request.getParameter("pass");
            
        if(user!=null && pass!=null)
        {
            BookDAO bd=new BookDAO();
            if(bd.chechLogin(user,pass))
            {
            session.setAttribute("username",user);
            session.setAttribute("password", pass);
                        response.sendRedirect("BB.jsp");
            
        }
        else{
        %>
        <style>
            
        </style>
        <%
         out.println("<font color=red size=6> Invalid User or Password..</font>");
       
        }
            

        }
        %>
    </center>
        </div>
    </body>
</html>

