package com.liceu.geom.controllers;

import com.liceu.geom.model.Figure;
import com.liceu.geom.services.FigureService;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/preview")
public class FigurePreviewController extends HttpServlet {
    FigureService figureService = new FigureService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res) throws IOException, ServletException {
        int id = Integer.parseInt(req.getParameter("figure_id"));
        String userId = req.getParameter("user_id");
        //Obtenemos todas las figuras del usuario
        List<Figure> figureList = figureService.getAllFiguresByUser(userId);
        Figure figure = null;
        //Recorremos la lista hasta encontrar la figura que tenga la misma ID que la que hemos recibido del cliente.
        for (Figure f:figureList) {
            if (f.getId() == id) {
                figure = f;
                break;
            }
        }
        //Enviamos esta figura de vuelta al cliente y mostramos la página que recogerá y mostrará esta información.
        req.setAttribute("f", figure);
        RequestDispatcher dispatcher = req.getRequestDispatcher("WEB-INF/jsp/preview.jsp");
        dispatcher.forward(req, res);
    }
}
