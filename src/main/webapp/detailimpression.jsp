<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes d'impression</title>
</head>
<body>
    <h1>Liste des demandes d'impression</h1>
    <form action="loginController" method="post">
        <input type="submit" name="logout" value="Déconnexion"> <!-- Ajout du paramètre logout -->
    </form>
    
    <form action="DemandeImpression.jsp" method="get"> <!-- Formulaire pour ajouter une demande -->
        <input type="submit" value="Ajouter demande">
    </form>
    <form action="formmatiere.jsp" method="post"> <!-- Formulaire pour ajouter une matière -->
        <input type="submit" value="Ajouter matière">
    </form>
    <form action="matiere.jsp" method="get"> <!-- Formulaire pour voir les matières -->
        <input type="submit" value="Voir matières">
    </form>
    
    <table border="1">
        <thead>
            <tr>
                <th>ID Enseignant</th>
                <th>Matière</th>
                <th>Date d'arrivée</th>
                <th>Heure d'arrivée</th>
                <th>Nombre de copies</th>
                <th>PDF</th>
                <%-- Afficher le nom de l'enseignant seulement pour le rôle "imprimeur" --%>
                <c:if test="${role eq 'imprimeur'}">
                    <th>Nom de l'enseignant</th>
                </c:if>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                String username = (String) session.getAttribute("username"); // Supposons que l'ID de l'utilisateur connecté soit stocké dans une session
                String role = (String) session.getAttribute("role"); // Récupérer le rôle de l'utilisateur depuis la session

                if (username != null && !username.isEmpty()) {
                    String includePath = "/detailimpressionController?username=" + username;
                    request.getRequestDispatcher(includePath).include(request, response);
                    ResultSet rs = (ResultSet) request.getAttribute("resultSet");
                    if (rs == null || !rs.next()) {
            %>
            <tr>
                <td colspan="7">Aucune demande d'impression trouvée.</td>
            </tr>
            <% 
                    } else {
                        do {
            %>
            <tr>
                <td><%= rs.getString("enseignant_id") %></td>
                <td><%= rs.getString("matiere") %></td>
                <td><%= rs.getString("date_arrive") %></td>
                <td><%= rs.getString("heure_arrivee") %></td>
                <td><%= rs.getString("nombre_copies") %></td>
                <td><%= rs.getString("document_pdf") %></td>
                <%-- Afficher le nom de l'enseignant seulement pour le rôle "imprimeur" --%>
                <c:if test="${role eq 'imprimeur'}">
                 <td><%= new controller.detailimpressionController().getNomEnseignant(rs.getInt("enseignant_id")) %></td>


                  

                </c:if>
            </tr>
            <% 
                        } while (rs.next());
                    }
                } else {
            %>
            <tr>
                <td colspan="7">Utilisateur non connecté.</td>
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
