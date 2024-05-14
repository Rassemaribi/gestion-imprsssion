<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Créer un groupe</title>
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

        form {
            width: 50%;
            margin: 20px auto;
            padding: 20px;
            border: 1px solid #ccc;
            border-radius: 5px;
            background-color: #f2f2f2;
        }

        label {
            display: block;
            margin-bottom: 10px;
        }

        input[type="text"],
        input[type="number"],
        input[type="submit"] {
            width: 100%;
            padding: 8px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }

        input[type="submit"] {
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
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

    <h1>Créer un groupe</h1>

    <form action="groupController" method="post">
        <label for="nomGroup">Nom du groupe :</label>
        <input type="text" id="nomGroup" name="nomGroup" required>
        <br><br>
        <label for="nbPersonne">Nombre de personnes :</label>
        <input type="number" id="nbPersonne" name="nbPersonne" required>
        <br><br>
        <input type="submit" value="Créer">
    </form>

</body>
</html>
