package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DB; // Import de votre classe de connexion à la base de données


public class userController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public userController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DB.get_connection(); // Utilisation de la méthode statique pour obtenir la connexion

            String query = "SELECT id, role, nom, prenom, username, email FROM inscription";
            pstmt = conn.prepareStatement(query);
            ResultSet resultSet = pstmt.executeQuery();
            while (resultSet.next()) {
                int id = resultSet.getInt("id");
                String role = resultSet.getString("role");
                String nom = resultSet.getString("nom");
                String prenom = resultSet.getString("prenom");
                String username = resultSet.getString("username");
                String email = resultSet.getString("email");
                // Traiter les données récupérées, par exemple les afficher dans la console
                System.out.println("ID: " + id + ", Role: " + role + ", Nom: " + nom + ", Prénom: " + prenom + ", Username: " + username + ", Email: " + email);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                // Ne pas fermer la connexion principale ici
            } catch (Exception ex) {
                System.out.println("Erreur lors de la fermeture des ressources : " + ex.getMessage());
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }
}
