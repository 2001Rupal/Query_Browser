/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Model;

/**
 *
 * @author RUPAL
 */
public class Book {
    private int BookId;
    private String BookName;
    private String BookWriter;
    private String BookEdition;
    private int BookPrice;
    
    public int getBookId(){
        return BookId;
    }
     public void setBookId(int  BookId) {
        this.BookId = BookId;
    }

    public String getBookName() {
        return BookName;
    }

    public void setBookName(String BookName) {
        this.BookName = BookName;
    }

    public String getBookWriter() {
        return BookWriter;
    }

    public void setBookWriter(String BookWriter) {
        this.BookWriter = BookWriter;
    }

    public String getBookEdition() {
        return BookEdition;
    }

    public void setBookEdition(String BookEdition) {
        this.BookEdition = BookEdition;
    }

    public int getBookPrice() {
        return BookPrice;
    }

    public void setBookPrice(int BookPrice) {
        this.BookPrice = BookPrice;
    }
    
    
    
}
