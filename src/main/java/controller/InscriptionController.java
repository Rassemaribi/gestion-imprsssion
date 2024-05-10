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
import java.util.Random;

import common.DB; // Importer la classe DB pour la connexion à la base de données

public class InscriptionController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public InscriptionController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer les données du formulaire
        String role = request.getParameter("role");
        String nom = request.getParameter("nom");
        String prenom = request.getParameter("prenom");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String pwd = request.getParameter("pwd");

        // Générer un identifiant aléatoire entre 0 et 1000
        Random random = new Random();
        int id = random.nextInt(1001); // Le maximum est exclus, donc cela générera des valeurs entre 0 et 1000

        // Connexion à la base de données
        Connection conn = null;
        PreparedStatement pstmt = null;

        try {
            conn = DB.get_connection();
            String sql = "INSERT INTO inscription (id, role, nom, prenom, username, email, pwd) VALUES (?, ?, ?, ?, ?, ?, ?)";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, id);
            pstmt.setString(2, role);
            pstmt.setString(3, nom);
            pstmt.setString(4, prenom);
            pstmt.setString(5, username);
            pstmt.setString(6, email);
            pstmt.setString(7, pwd);

            int rowsAffected = pstmt.executeUpdate();
            if (rowsAffected > 0) {
                // Insertion réussie, rediriger vers une page de succès
                response.sendRedirect("detailimpression.jsp");
            } else {
                // Échec de l'insertion, afficher un message d'erreur dans la console
                System.out.println("Erreur lors de l'inscription : Aucune ligne n'a été insérée dans la base de données.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Afficher l'erreur SQL dans la console
            System.out.println("Erreur SQL : " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            // Afficher l'erreur générique dans la console
            System.out.println("Erreur : " + e.getMessage());
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
