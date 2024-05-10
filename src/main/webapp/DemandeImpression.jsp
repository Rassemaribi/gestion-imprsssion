<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes d'impression</title>
</head>
<body>
  <form action="DemandeImpression" method="post">
    <% 
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DB.get_connection();
            stmt = conn.createStatement();
            String sqlMatiere = "SELECT nommatiere FROM matiere";
            rs = stmt.executeQuery(sqlMatiere);
    %>
    
    
    <label for="matiere">Matière :</label>
    <select id="matiere" name="matiere">
        <!-- Boucle pour afficher les options de la liste déroulante -->
        <% while (rs.next()) { %>
            <option value="<%= rs.getString("nommatiere") %>"><%= rs.getString("nommatiere") %></option>
        <% } %>
    </select><br>
    
    <!-- Fermeture des ressources -->
    <% 
        } catch (SQLException e) {
            e.printStackTrace();
        } finally {
            try {
                if (rs != null) rs.close();
                if (stmt != null) stmt.close();
                if (conn != null) conn.close();
            } catch (SQLException ex) {
                ex.printStackTrace();
            }
        }
    %>
    
 
    
    <label for="date_arrivee">Date d'arrivée :</label>
    <input type="date" id="date_arrivee" name="date_arrivee"><br>
    
    <label for="heure_arrivee">Heure d'arrivée :</label>
    <input type="time" id="heure_arrivee" name="heure_arrivee"><br>
    
    <label for="nombre_copies">Nombre de copies :</label>
    <input type="number" id="nombre_copies" name="nombre_copies" min="1"><br>
    
    <input type="submit" value="Soumettre la demande">
</form>

</body>
</html>
