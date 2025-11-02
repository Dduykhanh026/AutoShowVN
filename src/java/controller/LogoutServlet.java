package controller;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * LogoutServlet handles user logout
 * @author Duy Khánh
 */
public class LogoutServlet extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doLogout(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doLogout(request, response);
    }
    
    /**
     * Perform logout operation
     */
    private void doLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession(false);
        if (session != null) {
            String userName = (String) session.getAttribute("userName");
    
            
            // Invalidate session
            session.invalidate();
        }
        
        // Redirect to home page
        response.sendRedirect("home");
    }

    @Override
    public String getServletInfo() {
        return "Logout Servlet for user logout";
    }
}
