<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*, common.DB" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));

    try (Connection connection = DB.get_connection()) {
        String query = "UPDATE demandeimpression SET is_printed = 1 WHERE id = ?";
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, id);
            statement.executeUpdate();
            out.print("Success"); // Indiquer le succès
        }
    } catch (Exception e) {
        out.print("Erreur : " + e.getMessage()); // Indiquer l'erreur
    }
%>
