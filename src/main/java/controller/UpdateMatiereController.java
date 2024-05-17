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


public class UpdateMatiereController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID de la matière à modifier depuis le formulaire
        int idMatiere = Integer.parseInt(request.getParameter("idMatiere"));
        
        // Récupérer les nouvelles données de la matière depuis le formulaire
        String nomMatiere = request.getParameter("nommatiere");
        // Ajoutez ici les autres champs de la matière que vous souhaitez mettre à jour
        
        // Mettre à jour les données dans la base de données
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlUpdateMatiere = "UPDATE matiere SET nommatiere=? WHERE id=?";
            stmt = conn.prepareStatement(sqlUpdateMatiere);
            stmt.setString(1, nomMatiere);
            stmt.setInt(2, idMatiere);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Matière mise à jour avec succès !");
                response.sendRedirect("matiere.jsp");
            } else {
                response.getWriter().println("Échec de la mise à jour de la matière.");
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
