<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Modifier une matière</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
    <style>
       body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
        }

      

        h1 {
            text-align: center;
        }

        table {
            width: 80%;
            margin: 20px auto;
            border-collapse: collapse;
        }

        th, td {
            border: 1px solid #ccc;
            padding: 8px;
            text-align: left;
        }

        th {
            background-color: #f2f2f2;
        }

        td form {
            display: inline;
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

        .message {
            text-align: center;
            margin-top: 20px;
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

         input[type="text"],
        input[type="number"],
        input[type="submit"]
       {
            width: 100%;
            padding: 5px 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
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
            <input type="submit" name="logout" value="Déconnexion" style="margin-top:7.5px">
        </formE>
    </li>
</ul>

<h1>Modifier une matière</h1>

<%-- Récupérer le paramètre idMatiere de l'URL --%>
<% String idMatiereParam = request.getParameter("idMatiere"); %>

<%-- Vérifier si le paramètre idMatiere est présent et non null --%>
<% if(idMatiereParam != null && !idMatiereParam.isEmpty()) { %>

    <%-- Afficher le paramètre idMatiere pour vérification --%>
    <p>ID de la matière à modifier : <%= idMatiereParam %></p>

    <%-- Récupérer les données de la matière depuis la base de données --%>
    <%@ page import="java.sql.*" %>
    <%@ page import="common.DB" %>

    <% Connection conn = null;
       PreparedStatement stmt = null;
       ResultSet rs = null;

       try {
           conn = DB.get_connection();
           String sqlSelectMatiere = "SELECT * FROM matiere WHERE id = ?";
           stmt = conn.prepareStatement(sqlSelectMatiere);
           stmt.setInt(1, Integer.parseInt(idMatiereParam));
           rs = stmt.executeQuery();

           if (rs.next()) {
               String nomMatiere = rs.getString("nomMatiere");
    %>

               <%-- Afficher un formulaire de modification avec les données préremplies --%>
               <form action="UpdateMatiereController" method="post">
                   <label for="nommatiere">Nom de la matière :</label>
                   <input type="text" id="nommatiere" name="nommatiere" value="<%= nomMatiere %>" required>
                   <br><br>
                   <input type="hidden" name="idMatiere" value="<%= idMatiereParam %>">
                   <input type="submit" value="Modifier">
               </form>

    <%         } else { %>

               <p>Aucune matière trouvée avec l'ID spécifié.</p>

    <%         }
       } catch (SQLException e) {
           e.printStackTrace();
           out.println("Erreur SQL : " + e.getMessage());
       } finally {
           try {
               if (rs != null) rs.close();
               if (stmt != null) stmt.close();
               if (conn != null) conn.close();
           } catch (SQLException ex) {
               ex.printStackTrace();
           }
       }
    %>

<% } else { %>

    <p>Aucun ID de matière spécifié.</p>

<% } %>

</body>
</html>
