package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import common.DB;


public class deleteMatiereController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public deleteMatiereController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int idMatiere = Integer.parseInt(request.getParameter("idMatiere"));
        Integer userId = (Integer) request.getSession().getAttribute("id");
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlSupprimerMatiere = "DELETE FROM matiere WHERE id = ? AND id_enseignant = ?";
            stmt = conn.prepareStatement(sqlSupprimerMatiere);
            stmt.setInt(1, idMatiere);
            stmt.setInt(2, userId);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Matière supprimée avec succès !");
                response.sendRedirect("matiere.jsp");
            } else {
                response.getWriter().println("Échec de la suppression de la matière.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Erreur SQL : " + e.getMessage());
        } finally {
            try {
                if (stmt != null)
                    stmt.close();
                if (conn != null)
                    conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    }
}
