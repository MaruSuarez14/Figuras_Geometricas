package com.liceu.geom.services;

import com.liceu.geom.DAO.FigureDAO;
import com.liceu.geom.DAO.FigureDAOImpl;
import com.liceu.geom.model.Figure;
import com.liceu.geom.model.User;

import java.util.Date;
import java.util.List;

public class FigureService {
    FigureDAO figureDAO = new FigureDAOImpl();

    //Crea una figura y la almacena en la lista de figuras
    public void newFigure(String name, String type, int size, String color, int coordinate_x, int coordinate_y, String userId) {
        //Se crea una figura
        Figure f = new Figure();
        //Se establecen todos los atributos de la figura
        Date date = new Date();
        f.setDate(date);
        User user = new User(userId);
        f.setUser(user);
        assignType(type, f);
        assignColor(color, f);
        f.setCoordinateX(coordinate_x);
        f.setCoordinateY(coordinate_y);
        f.setSize(size);
        //Comprobamos que el nombre no esta vacío y si es así asignamos un nombre por defecto
        if(name.equals("")) name = type + "_" +  (int)(Math.random() * 1000);
        do {
            //Si el nombre existe, se asigna otro nuevo
            if(nameExists(name, userId)){
                name = type + "_" +  (int)(Math.random() * 1000);
            } else {
            //Si el nombre no existe, se asigna al nombre de la figura
                f.setName(name);
            }
        //Se repetirá el bucle hasta que la figura tenga un nombre asignado
        } while (f.getName()==null);
        figureDAO.save(f);
    }

    //Comprueba si el nombre recibido está como nombre en alguna figura de la lista
    private boolean nameExists (String name, String userID) {
        List<Figure> figureList = figureDAO.getAllFiguresByUser(userID);
        for(Figure figure : figureList) {
            if (figure.getName().equals(name)) return true;
        }
        return false;
    }

    //Función para asignar cada tipo de figura a su correspondiente tipo Enum
    public void assignType(String type, Figure f) {
        switch (type){
            case "Circle":
                f.setType(Figure.Type.CIRCLE);
                break;
            case "Square":
                f.setType(Figure.Type.SQUARE);
                break;
            case "Triangle":
                f.setType(Figure.Type.TRIANGLE);
                break;
            case "Pentagon":
                f.setType(Figure.Type.PENTAGON);
                break;
        }

    }

    //Función para asignar cada color de figura a su correspondiente tipo Enum
    public void assignColor(String color, Figure f){
        switch (color){
            case "Black":
                f.setColor(Figure.Color.BLACK);
                break;
            case "Green":
                f.setColor(Figure.Color.GREEN);
                break;
            case "Red":
                f.setColor(Figure.Color.RED);
                break;
            case "Blue":
                f.setColor(Figure.Color.BLUE);
                break;
            case "Yellow":
                f.setColor(Figure.Color.YELLOW);
                break;
            case "Gray":
                f.setColor(Figure.Color.GRAY);
                break;
        }

    }

    //Devuelve una lista de todas las figuras
    public List<Figure> getAllFigures(String name){
        return figureDAO.getAllFigures(name);
    }

    //Devuelve una lista de las figuras de un usuario en concreto
    public List<Figure> getAllFiguresByUser(String id){
        return figureDAO.getAllFiguresByUser(id);
    }

    //Elimina una figura
    public void deleteFigure(String userId, int figureId, String sessionID){
        figureDAO.deleteOne(userId,figureId, sessionID);
    }


}
