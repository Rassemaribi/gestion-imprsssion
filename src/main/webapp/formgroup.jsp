<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
           padding: 5px 10px;
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
            <formE action="loginController" method="post">
                <input type="submit" name="logout" value="Déconnexion" style="margin-top:11px" >
            </formE>
        </li>
    </ul>

    <h1>Créer un groupe</h1>

    <form action="groupController" method="post">
        <label for="nomgroup">Nom du groupe :</label>
        <input type="text" id="nomgroup" name="nomgroup" required>
        <br><br>
        <label for="nbPersone">Nombre de personnes :</label>
        <input type="number" id="nbPersone" name="nbPersone" required>
        <br><br>
        <input type="submit" value="Créer">
    </form>
</body>
</html>
