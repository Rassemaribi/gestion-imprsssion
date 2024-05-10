<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des groupes</title>
</head>
<body>
    <h1>Liste des groupes</h1>
    <form action="loginController" method="post">
        <input type="submit" name="logout" value="Déconnexion"> <!-- Ajout du paramètre logout -->
    </form>

    <a href="formgroup.jsp">Ajouter un groupe</a> <!-- Lien vers la page de création de groupe -->

    <table border="1">
        <thead>
            <tr>
                <th>ID Groupe</th>
                <th>Nom du groupe</th>
                <th>Nombre de personnes</th>
                <th>Action</th> <!-- Nouvelle colonne pour l'action de suppression -->
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Integer userId = (Integer) session.getAttribute("id"); // Récupérer l'ID de l'utilisateur connecté depuis la session

                if (userId != null) {
                    Connection conn = DB.get_connection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `group` WHERE id_enseignant = ?");
                    stmt.setInt(1, userId);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.next()) {
            %>
            <tr>
                <td colspan="4">Aucun groupe trouvé pour cet utilisateur.</td>
            </tr>
            <% 
                    } else {
                        do {
            %>
            <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("nomgroup") %></td>
                <td><%= rs.getInt("nbpersone") %></td>
                <td>
                    <form action="deleteGroupeController" method="post"> <!-- Formulaire de suppression -->
                        <input type="hidden" name="idGroupe" value="<%= rs.getInt("id") %>"> <!-- Champ caché pour l'ID du groupe -->
                        <input type="submit" value="Supprimer">
                    </form>
                </td>
            </tr>
            <% 
                        } while (rs.next());
                    }
                    rs.close();
                    stmt.close();
                    conn.close();
                } else {
            %>
            <tr>
                <td colspan="4">Utilisateur non connecté.</td>
            </tr>
            <% 
                }
            } catch (Exception e) {
                out.println("Erreur lors de l'affichage : " + e.getMessage());
            }
            %>
        </tbody>
    </table>

</body>
</html>
