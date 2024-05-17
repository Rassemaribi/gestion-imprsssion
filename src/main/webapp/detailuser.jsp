<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des utilisateurs</title>
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
   <c:if test="${role == 'admin'}">
    <li><a class="active" href="inscription.jsp">Ajouter un utilisateur</a></li>
</c:if>

    <li style="float:right">
        <form action="loginController" method="post">
            <input type="submit" name="logout" value="Déconnexion" style="margin-top:11px">
        </form>
    </li>
</ul> 

    <h1>Liste des utilisateurs</h1>

    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Rôle</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Username</th>
                <th>Email</th>
                <th>Action</th>
            </tr>
        </thead>
        <tbody>
            <% 
            try {
                Connection conn = common.DB.get_connection(); // Obtenez la connexion à la base de données

                String query = "SELECT id, role, nom, prenom, username, email FROM inscription";
                PreparedStatement pstmt = conn.prepareStatement(query);
                ResultSet rs = pstmt.executeQuery();

                while (rs.next()) {
            %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("role") %></td>
                <td><%= rs.getString("nom") %></td>
                <td><%= rs.getString("prenom") %></td>
                <td><%= rs.getString("username") %></td>
                <td><%= rs.getString("email") %></td>
                 <td>
       <form action="deleteUserController" method="post">
    <input type="hidden" name="idUser" value="<%= rs.getInt("id") %>">
    <input type="submit" value="Supprimer">
</form>

    </td>
            </tr>
            <% 
                }
                rs.close();
                pstmt.close();
                conn.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
            %>
        </tbody>
    </table>
</body>
</html>
