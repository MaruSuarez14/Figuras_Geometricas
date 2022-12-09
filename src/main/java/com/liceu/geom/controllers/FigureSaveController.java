package com.liceu.geom.controllers;

import com.liceu.geom.services.FigureService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/save")
public class FigureSaveController extends HttpServlet {
    FigureService figureService= new FigureService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
        //Se muestra la página principal
        RequestDispatcher dispatcher = req.getRequestDispatcher("/WEB-INF/jsp/index.jsp");
        dispatcher.forward(req, res);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException {
        //Creamos una sesión y le asignamos al usuario la ID de esta sesión
        HttpSession session = req.getSession();
        String userId = session.getId();
        //Recogemos el resto de datos enviados en la petición POST
        String name = req.getParameter("name");
        String type = req.getParameter("figure_type");
        int size = Integer.parseInt(req.getParameter("size"));
        String color = req.getParameter("color");
        int coordinate_x = Integer. parseInt(req.getParameter("coordinate_x"));
        int coordinate_y = Integer.parseInt(req.getParameter("coordinate_y"));
        //Se crea la figura
        figureService.newFigure(name, type, size, color, coordinate_x, coordinate_y, userId);
        //Se redirige la página a la misma dónde estaba el cliente
        res.sendRedirect("/save");
    }


}

