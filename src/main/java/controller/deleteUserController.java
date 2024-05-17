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


public class deleteUserController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Vérifier si l'utilisateur est connecté en tant qu'admin
        String role = (String) request.getSession().getAttribute("role");
        if (role == null || !"admin".equals(role)) {
            // Rediriger vers une page non autorisée si l'utilisateur n'est pas admin
            response.sendRedirect("unauthorized.jsp");
            return;
        }

        // Récupérer l'ID de l'utilisateur à supprimer
        int userIdToDelete = Integer.parseInt(request.getParameter("idUser"));

        // Connexion à la base de données
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DB.get_connection();
            String sql = "DELETE FROM inscription WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, userIdToDelete);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Suppression réussie, rediriger vers une page de succès ou autre page
                response.sendRedirect("detailuser.jsp");
            } else {
                // Aucun utilisateur trouvé avec cet ID, rediriger vers une page d'erreur ou autre page
                response.sendRedirect("errorDelete.jsp");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Afficher l'erreur SQL
            request.setAttribute("erreur", "Erreur SQL : " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Afficher l'erreur générique
            request.setAttribute("erreur", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } finally {
            // Fermeture des ressources
            try {
                if (pstmt != null)
                    pstmt.close();
                if (conn != null)
                    conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }
    }
}
