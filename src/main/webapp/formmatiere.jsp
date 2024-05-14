<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Créer une matière</title>
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
        margin: auto;
        padding: 20px;
        border: 1px solid #ccc;
        border-radius: 5px;
        background-color: #f2f2f2;
    }

    label {
        font-weight: bold;
    }

    input[type="text"] {
        width: 100%;
        padding: 8px;
        margin: 5px 0 15px 0;
        box-sizing: border-box;
        border: 1px solid #ccc;
        border-radius: 4px;
    }

    input[type="submit"] {
        background-color: #4CAF50;
        color: white;
        padding: 10px 20px;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        float: right;
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

<h1>Créer une matière</h1>

<form action="matiereController" method="post">
    <label for="nomMatiere">Nom de la matière :</label>
    <input type="text" id="nomMatiere" name="nomMatiere" required>
    <br><br>
    <input type="submit" value="Créer">
</form>

</body>
</html>
