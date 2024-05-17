<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des matières</title>
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

        td form {
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
            position: -webkit-sticky; /* Safari */
            position: sticky;
            top: 0;
            width: 100%; /* Étendre la barre de navigation sur toute la largeur */
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
    </style>
</head>
<body>
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
            <input type="submit" name="logout" value="Déconnexion" style="margin-top:11px">
        </form>
    </li>
</ul>


    <h1>Liste des matières</h1>
    
    
    <table>
        <thead>
            <tr>
                <th>ID Matière</th>
                <th>Nom de la matière</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Integer userId = (Integer) session.getAttribute("id");

                if (userId != null) {
                    Connection conn = DB.get_connection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM matiere WHERE id_enseignant = ?");
                    stmt.setInt(1, userId);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.next()) {
            %>
            <tr>
                <td colspan="3" class="message">Aucune matière trouvée pour cet utilisateur.</td>
            </tr>
            <% 
                    } else {
                        do {
            %>
            <tr>
                <td><%= rs.getString("id") %></td>
                <td><%= rs.getString("nommatiere") %></td>
                <td>
                    <form action="deleteMatiereController" method="post">
                        <input type="hidden" name="idMatiere" value="<%= rs.getInt("id") %>">
                        <input type="submit" value="Supprimer">
                    </form>
                    <form action="updateMatiere.jsp" method="get">
        <input type="hidden" name="idMatiere" value="<%= rs.getInt("id") %>">
        <input type="submit" value="Modifier">
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
                <td colspan="3" class="message">Utilisateur non connecté.</td>
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
