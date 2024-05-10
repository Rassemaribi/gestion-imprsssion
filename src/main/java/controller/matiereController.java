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

import common.DB;


public class matiereController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public matiereController() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nomMatiere = request.getParameter("nomMatiere");
        int idMatiere = generateRandomId();
        
        Integer userId = (Integer) request.getSession().getAttribute("id");
        System.out.println("ID de l'utilisateur connecté : " + userId);
        
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlAjoutMatiere = "INSERT INTO matiere (id, nommatiere, id_enseignant) VALUES (?, ?, ?)";
            stmt = conn.prepareStatement(sqlAjoutMatiere);
            stmt.setInt(1, idMatiere);
            stmt.setString(2, nomMatiere);
            stmt.setInt(3, userId); // Utilisation de l'ID de l'utilisateur comme ID de l'enseignant

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Matière ajoutée avec succès !");
                response.sendRedirect("matiere.jsp");
            } else {
                response.getWriter().println("Échec de l'ajout de la matière.");
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
    private int generateRandomId() {
        Random random = new Random();
        return random.nextInt(1001); // Génère un nombre aléatoire entre 0 et 1000 inclus
    }
}
