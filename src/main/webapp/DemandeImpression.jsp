<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DB" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Liste des demandes d'impression</title>
    <style>
        * {
            box-sizing: border-box;
        }

        input[type=text], select, textarea, input[type=date], input[type=time] {
            width: 100%;
            padding: 12px;
            border: 1px solid #ccc;
            border-radius: 4px;
            resize: vertical;
        }

        label {
            padding: 12px 12px 12px 0;
            display: inline-block;
        }

        input[type=submit] {
            background-color: #04AA6D;
            color: white;
            padding: 12px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            float: right;
        }

        input[type=submit]:hover {
            background-color: #45a049;
        }

        .container {
            border-radius: 5px;
            background-color: #f2f2f2;
            padding: 20px;
        }

        .col-25 {
            float: left;
            width: 25%;
            margin-top: 6px;
        }

        .col-75 {
            float: left;
            width: 75%;
            margin-top: 6px;
        }

        /* Clear floats after the columns */
        .row::after {
            content: "";
            display: table;
            clear: both;
        }

        body {
            font-size: 16px;
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

        h1 {
            font-size: 24px; /* Taille de la police réduite pour le titre */
        }
    </style>
</head>
<body>

<ul>
    <li><a class="active" href="detailimpression.jsp">Accueil</a></li>
    <li><a href="DemandeImpression.jsp">Ajouter demande</a></li>
    <li><a href="formmatiere.jsp">Ajouter matière</a></li>
    <li><a href="matiere.jsp">Voir matières</a></li>
    <li style="float:right"><a href="loginController?logout=true">Déconnexion</a></li>
</ul>
<div class="container">
   
</head>
<body>



    <form action="DemandeImpression" method="post" enctype="multipart/form-data">
        <% 
                Connection conn = null;
                ResultSet rsMatiere = null;
                try {
                    conn = DB.get_connection();
                    Integer userId = (Integer) session.getAttribute("id");
                    if (conn != null && userId != null) {
                        PreparedStatement stmtMatiere = conn.prepareStatement("SELECT nommatiere FROM matiere WHERE id_enseignant = ?");
                        stmtMatiere.setInt(1, userId);
                        rsMatiere = stmtMatiere.executeQuery();
                    }
            %>
        
        <div class="row">
            <div class="col-25">
                <label for="matiere">Matière :</label>
            </div>
            <div class="col-75">
                <select id="matiere" name="matiere">
                    <!-- Boucle pour afficher les options de la liste déroulante -->
                    <% while (rsMatiere.next()) { %>
                        <option value="<%= rsMatiere.getString("nommatiere") %>"><%= rsMatiere.getString("nommatiere") %></option>
                    <% } %>
                </select>
            </div>
        </div>
        
        <!-- Fermeture des ressources -->
        <% 
                rsMatiere.close();
                
            } catch (SQLException e) {
                e.printStackTrace();
            } finally {
                try {
                    if (conn != null) conn.close();
                } catch (SQLException ex) {
                    ex.printStackTrace();
                }
            }
        %>
        
        <div class="row">
            <div class="col-25">
                <label for="date_arrivee">Date d'arrivée :</label>
            </div>
            <div class="col-75">
                <input type="date" id="date_arrivee" name="date_arrivee">
            </div>
        </div>
        
        <div class="row">
            <div class="col-25">
                <label for="heure_arrivee">Heure d'arrivée :</label>
            </div>
            <div class="col-75">
                <input type="time" id="heure_arrivee" name="heure_arrivee">
            </div>
        </div>
<% 
    Connection connn = null;
    ResultSet rsGroupes = null;
    try {
        connn = DB.get_connection();
        if (connn != null) {
            Integer userId = (Integer) session.getAttribute("id");
            PreparedStatement stmtGroupes = connn.prepareStatement("SELECT nbpersone, nomgroup FROM groupe WHERE id_enseignant = ?");
            stmtGroupes.setInt(1, userId);
            rsGroupes = stmtGroupes.executeQuery();
        }
%>


<div class="row">
    <div class="col-25">
        <label for="nombre_copies">Nombre de copies par groupe :</label>
    </div>
    <div class="col-75">
        <select id="nombre_copies" name="nombre_copies">
            <!-- Boucle pour afficher les options de la liste déroulante -->
            <% while (rsGroupes.next()) { %>
                <option value="<%= rsGroupes.getString("nbpersone") %>"><%= rsGroupes.getString("nomgroup") %> - <%= rsGroupes.getString("nbpersone") %> personne(s)</option>
            <% } %>
        </select>
    </div>
</div>

<!-- Fermeture des ressources -->
<% 
        rsGroupes.close();
        
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        try {
            if (connn != null) connn.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
%>

        
        <div class="row">
            <div class="col-25">
                <label for="document_pdf">Document PDF :</label>
            </div>
            <div class="col-75">
                <input type="file" id="document_pdf" name="document_pdf">
            </div>
        </div>
        
        
        <br>
        <div class="row">
            <input type="submit" value="Soumettre la demande">
        </div>
    </form>
</div>

</body>
</html>
