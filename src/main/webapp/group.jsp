<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des groupes</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

        .navbar {
            overflow: hidden;
            background-color: #333;
        }

        .navbar a {
            float: left;
            display: block;
            color: white;
            text-align: center;
            padding: 14px 16px;
            text-decoration: none;
        }

        .navbar a:hover {
            background-color: #ddd;
            color: black;
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
    </style>
</head>
<body>
    <div class="navbar">
          <a href="detailimpression.jsp">Accueil</a>
        <a href="DemandeImpression.jsp">Ajouter demande</a>
        <a href="formmatiere.jsp">Ajouter matière</a>
        <a href="matiere.jsp">Voir matières</a>
        <a style="float:right" href="loginController?logout=true">Déconnexion</a>
    </div>

    <h1>Liste des groupes</h1>
    <form action="loginController" method="post">
        <input type="submit" name="logout" value="Déconnexion">
    </form>

    <a href="formgroup.jsp">Ajouter un groupe</a>

    <table>
        <thead>
            <tr>
                <th>ID Groupe</th>
                <th>Nom du groupe</th>
                <th>Nombre de personnes</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Integer userId = (Integer) session.getAttribute("id");

                if (userId != null) {
                    Connection conn = DB.get_connection();
                    PreparedStatement stmt = conn.prepareStatement("SELECT * FROM `groupe` WHERE id_enseignant = ?");
                    stmt.setInt(1, userId);
                    ResultSet rs = stmt.executeQuery();

                    if (!rs.next()) {
            %>
            <tr>
                <td colspan="4" class="message">Aucun groupe trouvé pour cet utilisateur.</td>
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
                    <form action="deleteGroupeController" method="post">
                        <input type="hidden" name="idGroupe" value="<%= rs.getInt("id") %>">
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
                <td colspan="4" class="message">Utilisateur non connecté.</td>
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
