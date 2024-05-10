package common;

import java.sql.Connection;
import java.sql.DriverManager;

public class DB {
    public static Connection get_connection() {
        Connection connection = null;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/jeeproject", "root", "admin");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return connection;
    }
}
