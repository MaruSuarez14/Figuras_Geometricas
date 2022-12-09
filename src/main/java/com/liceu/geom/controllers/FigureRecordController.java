package com.liceu.geom.controllers;

import com.liceu.geom.model.Figure;
import com.liceu.geom.services.FigureService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/getfigures")
public class FigureRecordController extends HttpServlet {
    FigureService figureService = new FigureService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //Recogemos el parámetro con el nombre de búsqueda (puede o no estar vacío)
        String name = req.getParameter("search-name");
        //Almacenamos la lista de figuras
        List<Figure> figureList = figureService.getAllFigures(name);
        HttpSession session = req.getSession();
        String sessionId = session.getId();
        //Enviamos al cliente la lista de figuras y la sesión del usuario
        req.setAttribute("sessionId", sessionId);
        req.setAttribute("figureList", figureList);
        //Se muestra la página con el historial de figuras
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/jsp/record.jsp");
        dispatcher.forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        HttpSession session = req.getSession();
        String sessionId = session.getId();
        //Se almacena la lista de figuras por usuario
        List<Figure> figureList = figureService.getAllFiguresByUser(sessionId);
        //Enviamos al cliente la lista de figuras y la sesión del usuario
        req.setAttribute("sessionId", sessionId);
        req.setAttribute("figureList", figureList);
        //Se muestra la página con el historial de figuras
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/jsp/record.jsp");
        dispatcher.forward(req, res);
    }
}
