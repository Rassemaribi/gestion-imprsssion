<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Connexion</title>
</head>
<body>
    <h1>Connexion Utilisateur</h1>
    <form action="loginController" method="post">
        <label for="username">Nom d'utilisateur :</label>
        <input type="text" id="username" name="username" required><br>
        <label for="pwd">Mot de passe :</label>
        <input type="password" id="pwd" name="pwd" required><br>
        <input type="submit" value="Se connecter">
    </form>
    <%-- Afficher un message d'erreur s'il y a une erreur de connexion --%>
    <c:if test="${not empty erreur}">
        <p style="color: red;">${erreur}</p>
    </c:if>
</body>
</html>
