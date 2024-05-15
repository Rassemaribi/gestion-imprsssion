<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="fr">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inscription</title>
    <link href="https://fonts.googleapis.com/css?family=Lato:300,400,700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
    <link rel="stylesheet" href="css/style.css">
    <style>
        .center-text {
            text-align: center;
        }
        .heading-section {
            margin-top: -40px; /* Ajustez cette valeur pour plus ou moins d'espace en haut */
        }
    </style>
</head>
<body class="img js-fullheight" style="background-image: url(images/bgb.jpg);">
    <section class="ftco-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12 center-text">
                    <h2 class="heading-section">Inscription</h2>
                </div>
            </div>
            <div class="row justify-content-center">
                <div class="col-md-6 col-lg-4">
                    <div class="login-wrap p-0">
                        <form method="post" action="InscriptionController" class="signin-form">
                            <div class="form-group">
                                <select name="role" id="role" class="form-control" required>
                                   <option style="color:black;" value="enseignant">Enseignant</option>
                                    <option style="color:black;" value="imprimeur">Imprimeur</option>
                                    <option style="color:black;" value="admin">Admin</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="nom" name="nom" placeholder="Nom" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="prenom" name="prenom" placeholder="Prénom" required>
                            </div>
                            <div class="form-group">
                                <input type="text" class="form-control" id="username" name="username" placeholder="Nom d'utilisateur" required>
                            </div>
                            <div class="form-group">
                                <input type="email" class="form-control" id="email" name="email" placeholder="Email" required>
                            </div>
                            <div class="form-group">
                                <input type="password" class="form-control" id="pwd" name="pwd" placeholder="Mot de passe" required>
                            </div>
                            <div class="form-group">
                                <button type="submit" class="form-control btn btn-primary submit px-2">S'inscrire</button>
                            </div>
                        </form>
                        <p class="w-100 text-center">&mdash; Ou se connecter avec &mdash;</p>
                        <div class="social d-flex text-center">
                            <a href="index.jsp" class="px-2 py-2 mr-md-0 rounded"><span class="ion-logo-facebook mr-2"></span> Connexion</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <script src="js/jquery.min.js"></script>
    <script src="js/popper.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/main.js"></script>
</body>
</html>
