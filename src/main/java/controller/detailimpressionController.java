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

public class detailimpressionController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public detailimpressionController() {
        super();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;
        String username = request.getParameter("username");

        try {
            conn = DB.get_connection();
            String role = getUtilisateurRole(username);

            if (role != null && role.equals("imprimeur")) {
                String sql = "SELECT * FROM demandeimpression";
                pstmt = conn.prepareStatement(sql);
                rs = pstmt.executeQuery();

                request.setAttribute("resultSet", rs);
                request.setAttribute("role", role);
                request.getRequestDispatcher("/detailimpression.jsp").forward(request, response);
            } else {
                String idConnecte = getUtilisateurId(username);
                String sql = "SELECT * FROM demandeimpression WHERE enseignant_id = ?";
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, idConnecte);
                rs = pstmt.executeQuery();

                request.setAttribute("resultSet", rs);
                request.setAttribute("userId", idConnecte);
                request.setAttribute("role", role);
                request.getRequestDispatcher("/detailimpression.jsp").forward(request, response);
            }
        } catch (SQLException e) {
            System.out.println("Erreur SQL : " + e.getMessage());
        } catch (Exception e) {
            System.out.println("Erreur : " + e.getMessage());
        } finally {
            try {
                if (rs != null) rs.close();
                if (pstmt != null) pstmt.close();
                if (conn != null) conn.close();
            } catch (Exception ex) {
                System.out.println("Erreur lors de la fermeture des ressources : " + ex.getMessage());
            }
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    public String getUtilisateurId(String username) throws SQLException {
        String userId = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DB.get_connection();
            String sql = "SELECT id FROM inscription WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                userId = rs.getString("id");
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return userId;
    }

    public String getUtilisateurRole(String username) throws SQLException {
        String role = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DB.get_connection();
            String sql = "SELECT role FROM inscription WHERE username = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, username);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                role = rs.getString("role");
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return role;
    }
    public String getNomEnseignant(int enseignantId) throws SQLException {
        String nomEnseignant = null;
        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            conn = DB.get_connection();
            String sql = "SELECT nom FROM inscription WHERE id = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setInt(1, enseignantId);
            rs = pstmt.executeQuery();

            if (rs.next()) {
                nomEnseignant = rs.getString("nom");
            }
        } finally {
            if (rs != null) rs.close();
            if (pstmt != null) pstmt.close();
            if (conn != null) conn.close();
        }

        return nomEnseignant;
    }

}
