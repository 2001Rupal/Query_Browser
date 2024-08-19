<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="DAO.MyConnection" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Database Query Executor</title>
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
</head>
<body>
    <div class="container">
        <!-- Connection Management -->
        <%
            Connection con = null;
            ResultSet rs = null;
            PreparedStatement ps = null;
            ResultSetMetaData rsmd = null;
            String selectedDb = request.getParameter("dbname");
            String sql = request.getParameter("txtsql");
            String sessionDb = (String) session.getAttribute("selectedDb");
            
            if (selectedDb != null && !selectedDb.trim().isEmpty()) {
                session.setAttribute("selectedDb", selectedDb);
            } else {
                selectedDb = sessionDb;  // Use the session database if no new selection
            }

            try {
                con = MyConnection.myGetConnection();
                if (selectedDb != null && !selectedDb.trim().isEmpty()) {
                    con.setCatalog(selectedDb);
                }

                if (request.getMethod().equalsIgnoreCase("GET")) {
                    DatabaseMetaData dbmd = con.getMetaData();
                    rs = dbmd.getTables(selectedDb, null, "%", new String[]{"TABLE"});
                    out.println("<h3>Available tables in " + selectedDb + "</h3>");
                    out.println("<table>");
                    out.println("<tr><th>Table Name</th></tr>");
                    while (rs.next()) {
                        String tableName = rs.getString("TABLE_NAME");
                        out.println("<tr><td>" + tableName + "</td></tr>");
                    }
                    out.println("</table>");
                }
            } catch (SQLException e) {
                out.println("<p class='error'>Database connection error: " + e.getMessage() + "</p>");
            }
        %>

        <!-- SQL Query Form -->
        <form action="" method="post">
            <h3>Enter Your SQL Query</h3>
            <textarea name="txtsql" placeholder="Enter SQL query here..."><%= sql %></textarea>
            <br>
            <input type="submit" value="Execute">
        </form>

        <!-- SQL Query Results -->
        <div>
            <%
                if (sql != null && !sql.trim().isEmpty() && selectedDb != null && !selectedDb.trim().isEmpty()) {
                    try {
                        ps = con.prepareStatement(sql);

                        if (sql.trim().toUpperCase().startsWith("SELECT")) {
                            rs = ps.executeQuery();
                            rsmd = rs.getMetaData();

                            out.println("<h3>Query Results:</h3>");
                            out.println("<table>");
                            out.println("<tr>");
                            for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                                out.println("<th>" + rsmd.getColumnName(i) + "</th>");
                            }
                            out.println("</tr>");
                            while (rs.next()) {
                                out.println("<tr>");
                                for (int i = 1; i <= rsmd.getColumnCount(); i++) {
                                    out.println("<td>" + rs.getString(i) + "</td>");
                                }
                                out.println("</tr>");
                            }
                            out.println("</table>");
                        } else {
                            int n = ps.executeUpdate();
                            out.println("<p class='success'>Query executed successfully: " + n + " row(s) affected.</p>");
                        }
                    } catch (SQLException e) {
                        out.println("<p class='error'>SQL Error: " + e.getMessage() + "</p>");
                    }
                } else if (sql != null && !sql.trim().isEmpty()) {
                    out.println("<p class='error'>No database selected or SQL query is empty.</p>");
                }
            %>
        </div>

        <!-- Cleanup -->
        <%
            try { if (rs != null) rs.close(); } catch (SQLException e) { /* Ignore */ }
            try { if (ps != null) ps.close(); } catch (SQLException e) { /* Ignore */ }
            try { if (con != null) con.close(); } catch (SQLException e) { /* Ignore */ }
        %>
    </div>
</body>
</html>
