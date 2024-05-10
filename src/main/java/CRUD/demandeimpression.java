package CRUD;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import common.DB;

public class demandeimpression {
	  public void insererDemandeImpression(String idEnseignant, String matiere, String documentPDF, String dateArrive, String heureArrivee, int nombreCopies) {
	        DB objDBConnection = new DB();
	        Connection connection = objDBConnection.get_connection();
	        PreparedStatement ps = null;
	        try {
	            String query = "INSERT INTO DemandeImpression(enseignant_id, matiere, document_pdf, date_arrive, heure_arrivee, nombre_copies) VALUES (?, ?, ?, ?, ?, ?)";
	            ps = connection.prepareStatement(query);
	            ps.setString(1, idEnseignant);
	            ps.setString(2, matiere);
	            ps.setString(3, documentPDF);
	            ps.setString(4, dateArrive);
	            ps.setString(5, heureArrivee);
	            ps.setInt(6, nombreCopies);
	            ps.executeUpdate();
	            System.out.println("Demande d'impression insérée avec succès dans la base de données.");
	        } catch (Exception e) {
	            e.printStackTrace();
	        } finally {
	            // Fermer la PreparedStatement et la connexion
	            try {
	                if (ps != null) {
	                    ps.close();
	                }
	                if (connection != null) {
	                    connection.close();
	                }
	            } catch (SQLException e) {
	                e.printStackTrace();
	            }
	        }
	    }
	}

