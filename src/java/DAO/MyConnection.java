/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;
import java.sql.*;

/**
 *
 * @author RUPAL
 */
public class MyConnection {
    static 
    {
        try
        {
            Class.forName("com.mysql.jdbc.Driver");
            
        }
        catch(Exception e)
        {
            System.out.println(e);
        }
    }
    public static Connection myGetConnection()throws SQLException 
    {
        Connection con=null;
        
        con= DriverManager.getConnection("jdbc:mysql://localhost:3306/bookrecord","root","root");
        
        return con;
    }
    
}
