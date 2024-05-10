<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Inscription</title>
</head>
<body>
    <h1>Inscription</h1>
    <form action="InscriptionController" method="post">
        <label for="role">Rôle :</label>
        <select name="role" id="role">
            <option value="enseignant">Enseignant</option>
            <option value="imprimeur">Imprimeur</option>
            <option value="admin">Admin</option>
        </select><br>

        <label for="nom">Nom :</label>
        <input type="text" id="nom" name="nom"><br>

        <label for="prenom">Prénom :</label>
        <input type="text" id="prenom" name="prenom"><br>

        <label for="username">Nom d'utilisateur :</label>
        <input type="text" id="username" name="username"><br>

        <label for="email">Email :</label>
        <input type="email" id="email" name="email"><br>

        <label for="pwd">Mot de passe :</label>
        <input type="password" id="pwd" name="pwd"><br>

        <input type="submit" value="S'inscrire">
    </form>
</body>
</html>
