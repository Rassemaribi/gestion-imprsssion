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

public class groupController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public groupController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String nomGroup = request.getParameter("nomgroup");
        int nbPersonne = Integer.parseInt(request.getParameter("nbPersone"));
        Integer idUser = (Integer) request.getSession().getAttribute("id"); // Récupérer l'ID de l'utilisateur connecté
        
        if (idUser == null) {
            response.getWriter().println("Erreur : ID de l'utilisateur non disponible.");
            return;
        }

        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlAjoutGroup = "INSERT INTO `groupe` (id, nomgroup, nbpersone, id_enseignant) VALUES (?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlAjoutGroup);
            stmt.setInt(1, generateRandomId());
            stmt.setString(2, nomGroup);
            stmt.setInt(3, nbPersonne);
            stmt.setInt(4, idUser); // Utilisation de l'ID de l'utilisateur comme ID de l'enseignant

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Groupe créé avec succès !");
                response.sendRedirect("confirmation.jsp");
            } else {
                response.getWriter().println("Échec de la création du groupe.");
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
