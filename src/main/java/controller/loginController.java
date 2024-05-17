package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import common.DB;

public class loginController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public loginController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.getWriter().append("Service à : ").append(request.getContextPath());
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("pwd");
        String logoutParam = request.getParameter("logout");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DB.get_connection();
            String sql = "SELECT * FROM inscription WHERE username = ? AND pwd = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String role = rs.getString("role");

                // Vérifier le rôle de l'utilisateur
                if ("admin".equals(role)) {
                    // Utilisateur authentifié en tant qu'admin, récupérer l'ID de l'utilisateur depuis la base de données
                    int id = rs.getInt("id");

                    // Insérer l'ID de l'utilisateur dans la session
                    request.getSession().setAttribute("id", id);
                    request.getSession().setAttribute("username", username);
                    request.getSession().setAttribute("role", role); // Définir le rôle dans la session

                    // Rediriger vers la page de détail utilisateur
                    response.sendRedirect("detailuser.jsp");
                } else if ("imprimeur".equals(role) || "enseignant".equals(role)) {
                    // Utilisateur authentifié en tant qu'imprimeur, récupérer l'ID de l'utilisateur depuis la base de données
                    int id = rs.getInt("id");

                    // Insérer l'ID de l'utilisateur dans la session
                    request.getSession().setAttribute("id", id);
                    request.getSession().setAttribute("username", username);
                    request.getSession().setAttribute("role", role); // Définir le rôle dans la session

                    // Rediriger vers la page de demande d'impression
                    response.sendRedirect("detailimpressionController?id=" + id);
                } else {
                    // Rediriger l'utilisateur non-admin vers une page non autorisée
                    response.sendRedirect("index.jsp");
                }

            } else {
                // Authentification échouée, afficher un message d'erreur
                request.setAttribute("erreur", "Nom d'utilisateur ou mot de passe incorrect !");
                request.getRequestDispatcher("/index.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            // Afficher l'erreur SQL
            request.setAttribute("erreur", "Erreur SQL : " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
            // Afficher l'erreur générique
            request.setAttribute("erreur", "Erreur : " + e.getMessage());
            request.getRequestDispatcher("/index.jsp").forward(request, response);
        } finally {
            // Fermeture des ressources
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                ex.printStackTrace();
            }
        }

        // Gestion de la déconnexion
        if (logoutParam != null && logoutParam.equals("1")) {
            request.getSession().invalidate(); // Invalider la session si le paramètre de déconnexion est présent
            response.sendRedirect("index.jsp"); // Rediriger vers la page de connexion
        }
    }
}
