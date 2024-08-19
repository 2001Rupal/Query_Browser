<%-- 
    Document   : BB
    Created on : 11-Aug-2024, 5:25:38 pm
    Author     : RUPAL
--%>

<%@page import="DAO.MyConnection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
         <style>
        body {
            background-color: #faffdf;
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }
        .container {
            text-align: center;
            padding: 30px;
            background-color: #f0f7fa;
            border-radius: 10px;
            box-shadow: 2px 10px 10px rgba(0, 0, 0, 0.5);
            width: 90%;
            max-width: 1200px;
        }
        h1 {
            color: #28a745;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin: 20px auto;
        }
        table, th, td {
            border: 1px solid #ccc;
            padding: 10px;
            text-align: center;
        }
        th {
            background-color: #28a745;
            color: #fff;
        }
        select, textarea {
            padding: 10px;
            border: 1px solid #90caf9;
            border-radius: 10px;
            margin: 10px 0;
            width: 100%;
             cursor: pointer;
            box-sizing: border-box;
        }
        textarea {
            height: 100px;
            font-size: 16px;
             cursor: pointer;
        }
        input[type="submit"] {
            background-color: #28a745;
            color: #fff;
            border: none;
            padding: 15px 30px;
            border-radius: 6px;
            cursor: pointer;
            transition: background-color 0.3s;
        }
        input[type="submit"]:hover {
            background-color: #218838;
        }
        .error {
            color: #d9534f;
            font-weight: bold;
        }
        .success {
            color: #5bc0de;
            font-weight: bold;
        }
    </style>
     <script>
        function updateForm() {
            document.getElementById('databaseForm').submit();
        }
    </script>
    </head>
    <body>
        <div class="container">
            <header>
                <h1>Data Base And Query Executor..</h1>
            </header>
            <!--Connection Part. -->
            <%
                Connection con=null;
                PreparedStatement ps=null;
                ResultSet rs=null;
                ResultSetMetaData rsmd=null;
                String selectedDB = request.getParameter("dname");
                String sessionDB = (String)session.getAttribute("selectedDB");
                
                if(selectedDB!=null && !selectedDB.trim().isEmpty())
                {
                    session.setAttribute("selectedDB",selectedDB);                 
                }
                else
                {
                    selectedDB=sessionDB;
                }   
                
                try
                {
                
                    con=MyConnection.myGetConnection();
                    if(selectedDB !=null && !selectedDB.trim().isEmpty())
                    {
                        con.setCatalog(selectedDB);
                    }
                    if(request.getMethod().equalsIgnoreCase("get")){
                        DatabaseMetaData dbmd=con.getMetaData();
                        rs=dbmd.getCatalogs();
                    }
                }catch(Exception e)
                {
                out.println(e);
                }
        
            %>
            
            <!-- DATABASE SELECTION FORM -->
            <form id="databaseForm" action="WB.jsp" method="get">
                <h3>Select a database</h3><!-- comment -->
                <label for="database">Choose a database:</label>
                <select name="dbname" id="database" onchange="updateForm()">
                    <option value="">-- select dataBase--</option>
                    <% 
                        try{
                            
                        while(rs!=null && rs.next())
                        {
                            String dbName = rs.getString("Table_cat");
                            String selected = dbName.equals(selectedDB)?"selected":"";
                    %>
                       
                          <option value="<%= dbName %>" <%= selected %>><%= dbName %></option >                   
                      <%
                          session.setAttribute("selectedDB",selectedDB);
                          
                          
                        }
                        }catch(Exception e)
                        {
                            out.println(e.getMessage());
                        }
                    
                    %>
                </select>
                    
                
            </form>
        </div>
       
    </body>
</html>
