<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Traitement de la demande d'impression</title>
</head>
<body>
    <h2>Traitement de la demande d'impression</h2>
    <%-- R�cup�ration des donn�es du formulaire --%>
    <% 
        String enseignantId = request.getParameter("enseignant_id");
        String matiere = request.getParameter("matiere");
        String dateArrivee = request.getParameter("date_arrive");
        String heureArrivee = request.getParameter("heure_arrivee");
        String nombreCopies = request.getParameter("nombre_copies");
        
        // V�rification des valeurs null et affichage conditionnel
        enseignantId = (enseignantId != null) ? enseignantId : "";
        matiere = (matiere != null) ? matiere : "";
        dateArrivee = (dateArrivee != null) ? dateArrivee : "";
        heureArrivee = (heureArrivee != null) ? heureArrivee : "";
        nombreCopies = (nombreCopies != null) ? nombreCopies : "";
    %>
    
    <%-- Affichage des donn�es r�cup�r�es --%>
    <p>ID de l'enseignant : <%= enseignantId %></p>
    <p>Mati�re : <%= matiere %></p>
    <p>Date d'arriv�e : <%= dateArrivee %></p>
    <p>Heure d'arriv�e : <%= heureArrivee %></p>
    <p>Nombre de copies : <%= nombreCopies %></p>
</body>
</html>
