/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

/**
 *
 * @author RUPAL
 */
import Model.Book;

import java.sql.*;

import java.util.ArrayList;
import java.util.List;




public class BookDAO {
    
    
    
    public boolean chechLogin(String user,String pass)throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        String sql="select * from registration where fullname=? and password=?";
        
        con =MyConnection.myGetConnection();
        
         ps=con.prepareStatement(sql);
         
         ps.setString(1, user);
         ps.setString(2, pass);
         ResultSet rs=null;
         
         rs=ps.executeQuery();
         
         if(rs.next())
             return true;
         
     return false;    
         
         
         
    }
    public  int UpdateBookByBid(Book B)throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
         String sql;
        con=MyConnection.myGetConnection();
       
        sql="update Book set BookNAME=?,Writer=?,Edition=?,Price=? where BookId=?";
        ps=con.prepareStatement(sql);
        ps.setString(1, B.getBookName());
        ps.setString(2, B.getBookWriter());
        ps.setString(3, B.getBookEdition());
        ps.setInt(4, B.getBookPrice());
        ps.setInt(5, B.getBookId());
        int n=0;
        n=ps.executeUpdate();
        return n;
        
    }
    
    public int InsertBook(Book B)throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        String sql;
        con=MyConnection.myGetConnection();
        
        sql="insert into Book values(?,?,?,?,?)";
        
        ps=con.prepareStatement(sql);
        
        ps.setInt(1,B.getBookId());
        ps.setString(2, B.getBookName());
        ps.setString(3, B.getBookWriter());
        ps.setString(4, B.getBookEdition());
        ps.setInt(5, B.getBookPrice());
        
        int n=0;
        n=ps.executeUpdate();
        return n;
        
    }
    public int  DeleteBook(int Bid)throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        
        String sql;
        
        con=MyConnection.myGetConnection();
        sql="delete from Book where BookId=?";
        ps=con.prepareStatement(sql);
        
        ps.setInt(1,Bid);
       
        if(ps.executeUpdate()>0)
            return 1;
        
       return 0;
       
    }
    public Book SearchByBId(int Bid)throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        
        String sql;
        con=MyConnection.myGetConnection();
        
        sql="select * from Book where BookId=?";
        
        ps=con.prepareStatement(sql);
        ps.setInt(1, Bid);
        rs=ps.executeQuery();
        Book B= new Book();
                
        if(rs.next()){
            B.setBookId(rs.getInt(1));
            B.setBookName(rs.getString(2));
            B.setBookWriter(rs.getString(3));
            B.setBookEdition(rs.getString(4));
            B.setBookPrice(rs.getInt(5));
            
        }
        else{
            B=null;
        }
        return B;      
             
    }

    public Book SearchByBname(String Bookname)throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        
        String sql;
        con=MyConnection.myGetConnection();
        
        sql="select *from Book where BookNAME=?";
        ps=con.prepareStatement(sql);
        
        ps.setString(1,Bookname);
        
        rs=ps.executeQuery();
        Book B=new Book();
        
        if(rs.next()){
            B.setBookId(rs.getInt(1));
            B.setBookName(rs.getString(2));
            B.setBookWriter(rs.getString(3));
            B.setBookEdition(rs.getString(4));
            B.setBookPrice(rs.getInt(5));
            
        }
        else{
            B=null;
        }
        return B;
    }

    public ArrayList<Book> SearchByBwriter(String Bookwriter) throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        
        String sql;
        con=MyConnection.myGetConnection();
        
        sql="select * from Book where Writer=?";
        
        ps=con.prepareStatement(sql);
        
        ps.setString(1,Bookwriter);
        
        rs=ps.executeQuery();
        
        ArrayList<Book> book=new ArrayList<>();
      
        
        while(rs.next()){
             
            Book B=null;
            B=new Book();
            B.setBookId(rs.getInt(1));
            B.setBookName(rs.getString(2));
            B.setBookWriter(rs.getString(3));
            B.setBookEdition(rs.getString(4));
            B.setBookPrice(rs.getInt(5));
            book.add(B);
            
        }
        return book;
   
    }
    
      public ArrayList<Book> searchAll()throws SQLException
    {
        Connection con=null;
        PreparedStatement ps=null;
        ResultSet rs=null;
        String sql;
        con=MyConnection.myGetConnection();
        sql="select * from Book";
        ps=con.prepareStatement(sql);
        rs=ps.executeQuery();
        
        ArrayList<Book> obj=new ArrayList<>();
        while(rs.next())
        {
            Book b=new Book();
            b.setBookId(rs.getInt(1));
            b.setBookName(rs.getString(2));
            b.setBookWriter(rs.getString(3));
            b.setBookEdition(rs.getString(4));
            b.setBookPrice(rs.getInt(5));
            obj.add(b);
            b=null;
        }
        return obj;
        
        
    }

    
    
    
   

    
}
