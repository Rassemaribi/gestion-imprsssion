package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.http.Part;
import common.DB;

@MultipartConfig(fileSizeThreshold = 1024 * 1024 * 2, // 2 MB
maxFileSize = 1024 * 1024 * 10, // 10 MB
maxRequestSize = 1024 * 1024 * 50) // 50 MB

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

      

        // Récupérer le fichier PDF téléchargé
        Part filePart = request.getPart("document_pdf");
        String fileName = extractFileName(filePart);

        // Connexion à la base de données et insertion de la demande d'impression
        Connection conn = null;
        PreparedStatement stmt = null;

        try {
            conn = DB.get_connection();
            String sqlAjoutDemande = "INSERT INTO demandeimpression (enseignant_id, matiere, date_arrive, heure_arrivee, nombre_copies, document_pdf) " +
                    "VALUES (?, ?, ?, ?, ?, ?)";
            stmt = conn.prepareStatement(sqlAjoutDemande);
            stmt.setLong(1, userId);
            stmt.setString(2, matiere);
            stmt.setString(3, dateArrivee);
            stmt.setString(4, heureArrivee);
            stmt.setString(5, nombreCopies);
            stmt.setString(6, fileName); // Enregistrer le nom du fichier PDF dans la base de données

            int rowsAffected = stmt.executeUpdate();
            if (rowsAffected > 0) {
                response.getWriter().println("Demande d'impression enregistrée avec succès !");
                
                // Enregistrer le fichier PDF localement
                String savePath = "C:/Users/RACEM/eclipse-workspace/gestion d'impression/src/main/webapp/pdf"; // Spécifiez le chemin où vous souhaitez enregistrer le fichier PDF
                filePart.write(savePath + File.separator + fileName);
                
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

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] tokens = contentDisp.split(";");
        for (String token : tokens) {
            if (token.trim().startsWith("filename")) {
                return token.substring(token.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return "";
    }
}
