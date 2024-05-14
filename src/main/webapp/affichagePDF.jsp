<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
    <title>Affichage PDF</title>
</head>
<body>
    <object data="${pdfPath}" type="application/pdf" width="100%" height="600px">
        <p>Votre navigateur ne peut pas afficher ce fichier PDF. <a href="${pdfPath}">Cliquez ici pour le télécharger</a>.</p>
    </object>
</body>
</html>
