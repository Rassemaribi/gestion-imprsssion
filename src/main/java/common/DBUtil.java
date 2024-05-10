package common;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBUtil {

    public static String getNomEnseignant(int enseignantId) {
        String nomEnseignant = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DB.get_connection();
            String sql = "SELECT nom_enseignant FROM enseignant WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, enseignantId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                nomEnseignant = rs.getString("nom_enseignant");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }

        return nomEnseignant;
    }
}
