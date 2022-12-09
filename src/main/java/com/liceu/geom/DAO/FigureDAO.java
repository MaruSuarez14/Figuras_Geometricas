package com.liceu.geom.DAO;

import com.liceu.geom.model.Figure;

import java.util.List;

public interface FigureDAO {
    //Guarda una figura en la lista de figuras
    void save(Figure f);
    //Devuelve una lista con todas las figuras
    List<Figure> getAllFigures(String name);
    //Devuelve una lista con todas las figuras de un usuario en concreto
    List<Figure> getAllFiguresByUser(String id);
    //Elimina una figura de la lista de figuras
    void deleteOne (String userID, int figureID, String sessionID);
}


