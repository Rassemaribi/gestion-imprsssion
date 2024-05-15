<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cr�er une mati�re</title>
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
     ul {
            list-style-type: none;
            margin: 0;
            padding: 0;
            overflow: hidden;
            background-color: #333;
            position: -webkit-sticky; /* Safari */
            position: sticky;
            top: 0;
            width: 100%; /* �tendre la barre de navigation sur toute la largeur */
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
</style>
</head>
<body>

   <ul>
    <li><a class="active" href="detailimpression.jsp">Accueil</a></li>
    <li><a href="DemandeImpression.jsp">Ajouter demande</a></li>
    <li><a href="formmatiere.jsp">Ajouter mati�re</a></li>
    <li><a href="matiere.jsp">Voir mati�res</a></li>
    <li style="float:right"><a href="loginController?logout=true">D�connexion</a></li>
</ul>

<h1>Cr�er une mati�re</h1>

<form action="matiereController" method="post">
    <label for="nomMatiere">Nom de la mati�re :</label>
    <input type="text" id="nomMatiere" name="nomMatiere" required>
    <br><br>
    <input type="submit" value="Cr�er">
</form>

</body>
</html>
