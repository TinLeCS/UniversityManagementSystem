/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package DatabaseController;


import java.sql.*;

/**
 *
 * @author Leader
 */
public class Database {
    private static Connection con;
    private static Statement stat;
    private static ResultSet rs;
    
    public static Connection getConnection() throws ClassNotFoundException, SQLException{
        Class.forName("com.mysql.jdbc.Driver");
        con = DriverManager.getConnection("jdbc:mysql://localhost:3306/webproject","root","12345");
        
        return con;
    }
    
    public static void executeUpdate(String sql) throws ClassNotFoundException, SQLException{
        stat = getConnection().createStatement();
        stat.executeUpdate(sql);
    }
    
    public static ResultSet executeQuery(String sql) throws ClassNotFoundException, SQLException{
        stat = getConnection().createStatement();
        rs = stat.executeQuery(sql);
        return rs;
    }
    
    public static void close() throws SQLException{
        if (rs != null)
            rs.close();
        else if (con != null){
            stat.close();
            con.close();
        }
    }
}
