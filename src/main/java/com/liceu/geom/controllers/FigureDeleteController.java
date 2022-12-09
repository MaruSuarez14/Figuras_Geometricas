package com.liceu.geom.controllers;

import com.liceu.geom.services.FigureService;

import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;


@WebServlet("/delete")
public class FigureDeleteController extends HttpServlet {
    FigureService figureService = new FigureService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res) throws IOException {
        HttpSession session = req.getSession();
        String sessionID = session.getId();
        //Obtenemos los parámetros para saber qué figura borrar
        String userId = req.getParameter("user_id");
        int figureId = Integer.parseInt(req.getParameter("figure_id"));
        //Se borra la figura
        figureService.deleteFigure(userId,figureId, sessionID);
        //Redirigimos la página al historial de figuras (dónde estaba antes el cliente)
        res.sendRedirect("/getfigures");
    }
}
