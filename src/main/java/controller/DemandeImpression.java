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


public class DemandeImpression extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public DemandeImpression() {
        super();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Récupérer les données du formulaire POST
        Integer userId = (Integer) request.getSession().getAttribute("id");
        System.out.println("ID de l'utilisateur connecté : " + userId);
        String matiere = request.getParameter("matiere");
        String dateArrivee = request.getParameter("date_arrivee");
        String heureArrivee = request.getParameter("heure_arrivee");
        String nombreCopies = request.getParameter("nombre_copies");

        // Vérifier si le champ nombre_copies n'est pas vide
        if (nombreCopies == null || nombreCopies.isEmpty()) {
            response.getWriter().println("Le champ Nombre de copies est requis.");
            return; // Arrêter l'exécution si le champ est vide
        }

        // Connexion à la base de données et insertion de la demande d'impression
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlAjoutDemande = "INSERT INTO demandeimpression (enseignant_id, matiere, date_arrive, heure_arrivee, nombre_copies) " +
                    "VALUES (?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlAjoutDemande);
            stmt.setLong(1, userId);
            stmt.setString(2, matiere);
            stmt.setString(3, dateArrivee);
            stmt.setString(4, heureArrivee);
            stmt.setString(5, nombreCopies);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Demande d'impression enregistrée avec succès !");
                response.sendRedirect("detailimpression.jsp");
            } else {
                response.getWriter().println("Échec de l'enregistrement de la demande d'impression.");
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
