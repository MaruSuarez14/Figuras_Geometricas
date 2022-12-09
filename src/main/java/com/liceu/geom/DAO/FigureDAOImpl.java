package com.liceu.geom.DAO;

import com.liceu.geom.model.Figure;

import java.util.ArrayList;
import java.util.List;

public class FigureDAOImpl implements FigureDAO{

    static List<Figure> figureList = new ArrayList<>();
    static int currentID = 0;


    @Override
    public void save(Figure f) {
        f.setId(currentID);
        figureList.add(f);
        currentID++;
    }

    @Override
    public List<Figure> getAllFigures(String name) {
        //Si el nombre recibido como argumento está vacío o es null, devolvemos la lista tal cual
        if(name==null) return figureList;
        if(name.equals("")) {
            return figureList;
        } else {
            //Si el nombre no está vacío, añadimos en una nueva lista todas las figuras que contengan alguna parte de ese nombre
            List<Figure> figureByName = new ArrayList<>();
            for(Figure figure : figureList){
                if(figure.getName().toLowerCase().contains(name.toLowerCase())){
                    figureByName.add(figure);
                }
            }
            return figureByName;
        }
    }

    @Override
    public List<Figure> getAllFiguresByUser(String id) {
        List<Figure> figureByUser = new ArrayList<>();
        for(Figure figure : figureList){
            if(figure.getUser().getId().equals(id)) {
                figureByUser.add(figure);
            }
        }
        return figureByUser;

    }

    @Override
    public void deleteOne(String userID, int figureID, String sessionID) {
        Figure figureToDelete = null;
        for(Figure figure : figureList){
            if(figure.getUser().getId().equals(userID) && figure.getId() == figureID) {
                figureToDelete = figure;
            }
        }
        if(sessionID.equals(userID)) {
            figureList.remove(figureToDelete);
        }
    }

}

