<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.util.Calendar" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes d'impression</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        h1 {
            text-align: center;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        td {
            display: inline;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            padding: 5px 10px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }

        .message {
            text-align: center;
            margin-top: 20px;
        }

        ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
            position: -webkit-sticky;
            position: sticky;
            top: 0;
            width: 100%;
        }

        li {
            float: left;
        }

        li a {
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        li a:hover {
            background-color: #111;
        }

        .active {
            background-color: #4CAF50;
        }

        .expired {
            background-color: #f8d7da;
            color: #721c24;
        }

        .printed {
            background-color: #d4edda;
            color: #155724;
        }
    </style>
<script>
    function telechargerPDF(nomFichier, id) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', 'pdf/' + nomFichier, true);
        xhr.responseType = 'blob';

        xhr.onload = function () {
            if (xhr.status === 200) {
                var blob = xhr.response;
                var link = document.createElement('a');
                link.href = window.URL.createObjectURL(blob);
                link.download = nomFichier;
                link.click();
                
                // Mettre à jour l'état de la demande après le téléchargement
                var updateXhr = new XMLHttpRequest();
                updateXhr.open('POST', 'updateStatus.jsp', true);
                updateXhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');

                updateXhr.onreadystatechange = function () {
                    if (updateXhr.readyState === 4 && updateXhr.status === 200) {
                        location.reload(); // Rafraîchir la page après la mise à jour
                    }
                };

                updateXhr.send('id=' + id);
            }
        };

        xhr.send();
    }
</script>


</head>
<body>

<div class="header" style="background-color: #4CAF50; text-align: center; color: white;">
    <% 
        String prenom = (String) session.getAttribute("username");
    %>
    <h2>Bienvenue, <%= prenom %></h2>
     <form action="loginController" method="post">
            <input type="submit" name="logout" value="Déconnexion" style="margin-top:5px">
        </form>
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
       
    </li>
</ul>

<h1>Liste des demandes d'impression</h1>

<table class="w3-table-all w3-hoverable">
    <thead>
        <tr>
            <th>ID Enseignant</th>
            <th>Matière</th>
            <th>Date d'arrivée</th>
            <th>Heure d'arrivée</th>
            <th>Nombre de copies</th>
            <th>PDF</th>
            <c:if test="${role eq 'imprimeur'}">
                <th>Nom de l'enseignant</th>
                <th>Action</th>
            </c:if>
        </tr>
    </thead>
    <tbody>
        <%
        try {
            String username = (String) session.getAttribute("username");
            String role = (String) session.getAttribute("role");

            if (username != null && !username.isEmpty()) {
                String includePath = "/detailimpressionController?username=" + username;
                request.getRequestDispatcher(includePath).include(request, response);
                ResultSet rs = (ResultSet) request.getAttribute("resultSet");

                if (rs == null || !rs.next()) {
        %>
        <tr>
            <td colspan="8">Aucune demande d'impression trouvée.</td>
        </tr>
        <%
                } else {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    Date currentDate = new Date();

                    do {
                        Date dateArrivee = sdf.parse(rs.getString("date_arrive"));
                        boolean isExpired = dateArrivee.before(currentDate);
                        boolean isPrinted = rs.getBoolean("is_printed"); // Ajouté : vérifier si la demande est déjà imprimée
        %>
        <tr class="<%= isExpired ? "expired" : (isPrinted ? "printed" : "") %>">
            <td><%= rs.getString("enseignant_id") %></td>
            <td><%= rs.getString("matiere") %></td>
            <td><%= rs.getString("date_arrive") %></td>
            <td><%= rs.getString("heure_arrivee") %></td>
            <td><%= rs.getString("nombre_copies") %></td>
            <td><%= rs.getString("document_pdf") %></td>
            <c:if test="${role eq 'imprimeur'}">
                <td><%= new controller.detailimpressionController().getNomEnseignant(rs.getInt("enseignant_id")) %></td>
                <% if (!isExpired && !isPrinted) { %>
                <td>
                   <button type="button" onclick="telechargerPDF('<%= rs.getString("document_pdf") %>', '<%= rs.getInt("id") %>')">Imprimer</button>
                </td>
                <% } else if (isPrinted) { %>
                <td>Déjà imprimé</td>
                <% } %>
            </c:if>
        </tr>
        <%
                    } while (rs.next());
                }
            } else {
        %>
        <tr>
            <td colspan="8">Utilisateur non connecté.</td>
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
