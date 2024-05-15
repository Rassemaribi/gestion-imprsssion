<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes d'impression</title>
    <style>
        body {
            font-size: 14px;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
            position: -webkit-sticky; /* Safari */
            position: sticky;
            top: 0;
        }

        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none.
        }

        li a:hover {
            background-color: #111;
        }

        .active {
            background-color: #4CAF50;
        }

        h1 {
            font-size: 24px; /* Taille de la police réduite pour le titre */
        }
    </style>
</head>
<body>

<div class="header">
    <% 
        String prenom = (String) session.getAttribute("username");
     
    %>
    <h2>Bienvenue, <%= prenom %></h2>
</div>

<ul>
    <li><a class="active" href="detailimpression.jsp">Accueil</a></li>
    <c:if test="${role != 'imprimeur'}">
        <li><a href="DemandeImpression.jsp">Ajouter demande</a></li>
        <li><a href="formmatiere.jsp">Ajouter matière</a></li>
        <li><a href="matiere.jsp">Voir matières</a></li>
        <li><a href="group.jsp">Voir groupes</a></li>
        <li><a href="formgroup.jsp">Ajouter groupe</a></li>
    </c:if>
    <li style="float:right">
        <form action="loginController" method="post">
            <input type="submit" name="logout" value="Déconnexion" style="margin-top:14px">
        </form>
    </li>
</ul>

<title>Liste des demandes d'impression</title>
<script>
    function telechargerPDF(nomFichier) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'pdf/' + nomFichier, true); // Chemin vers le dossier PDF spécifié
        xhr.responseType = 'blob';

        xhr.onload = function () {
            var blob = xhr.response;
            var link = document.createElement('a');
            link.href = window.URL.createObjectURL(blob);
            link.download = nomFichier;
            link.click();
        };

        xhr.send();
    }
</script>
</head>
<body>
    <h1>Liste des demandes d'impression</h1>
    
    
    <table class="w3-table-all w3-hoverable"> <!-- Utilisation de la classe CSS pour le tableau -->
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
                    <th>Action</th> <!-- Ajout de la colonne Action pour les imprimeurs -->
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
                    <td>
                        <button type="button" onclick="telechargerPDF('<%= rs.getString("document_pdf") %>')">Imprimer</button>
                    </td>
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
