
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cr�er un groupe</title>
</head>
<body>

<h1>Cr�er un groupe</h1>

<form action="groupController" method="post">
   
    <label for="nomGroup">Nom du groupe :</label>
    <input type="text" id="nomGroup" name="nomGroup" required>
    <br><br>
    <label for="nbPersonne">Nombre de personnes :</label>
    <input type="number" id="nbPersonne" name="nbPersonne" required>
    <br><br>
    <input type="submit" value="Cr�er">
</form>

</body>
</html>
