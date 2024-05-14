package controller;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * Servlet implementation class impressionController
 */
public class impressionController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public impressionController() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	 protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        // Récupérer le chemin du PDF à partir des paramètres de la requête
	        String pdfPath = request.getParameter("pdfPath");
	        
	        // Vérifier si le chemin du PDF est valide
	        if (pdfPath != null && !pdfPath.isEmpty()) {
	            // Transmettre le chemin du PDF à la vue appropriée pour l'affichage
	            request.setAttribute("pdfPath", pdfPath);
	            RequestDispatcher dispatcher = request.getRequestDispatcher("affichagePDF.jsp");
	            dispatcher.forward(request, response);
	        } else {
	            // Gérer le cas où le chemin du PDF est vide ou invalide
	            response.getWriter().println("Chemin du PDF invalide.");
	        }
	    }

}
