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

import common.DB;


public class UpdateGroupController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID du groupe à modifier depuis le formulaire
        int idGroupe = Integer.parseInt(request.getParameter("idGroupe"));
        
        // Récupérer les nouvelles données du groupe depuis le formulaire
        String nomGroup = request.getParameter("nomgroup");
        int nbPersonne = Integer.parseInt(request.getParameter("nbpersone"));
        
        // Mettre à jour les données dans la base de données
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlUpdateGroup = "UPDATE groupe SET nomgroup=?, nbpersone=? WHERE id=?";
            stmt = conn.prepareStatement(sqlUpdateGroup);
            stmt.setString(1, nomGroup);
            stmt.setInt(2, nbPersonne);
            stmt.setInt(3, idGroupe);

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Groupe mis à jour avec succès !");
                response.sendRedirect("group.jsp");
            } else {
                response.getWriter().println("Échec de la mise à jour du groupe.");
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

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Récupérer l'ID du groupe à modifier depuis l'URL
        String idGroupeParam = request.getParameter("idGroupe");
        
        // Vérifier si l'ID du groupe est présent et non vide
        if (idGroupeParam != null && !idGroupeParam.isEmpty()) {
            try {
                int idGroupe = Integer.parseInt(idGroupeParam);
                Connection conn = DB.get_connection();
                PreparedStatement stmt = conn.prepareStatement("SELECT * FROM groupe WHERE id=?");
                stmt.setInt(1, idGroupe);
                ResultSet rs = stmt.executeQuery();

                if (rs.next()) {
                    String nomGroup = rs.getString("nomgroup");
                    int nbPersonne = rs.getInt("nbpersone");

                    // Rediriger vers la page de modification avec les données pré-remplies
                    request.setAttribute("idGroupe", idGroupe);
                    request.setAttribute("nomgroup", nomGroup);
                    request.setAttribute("nbpersone", nbPersonne);
                    request.getRequestDispatcher("updategroup.jsp").forward(request, response);
                } else {
                    response.getWriter().println("Aucun groupe trouvé avec l'ID spécifié.");
                }

                rs.close();
                stmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
                response.getWriter().println("Erreur SQL : " + e.getMessage());
            }
        } else {
            response.getWriter().println("Aucun ID de groupe spécifié.");
        }
    }
}
