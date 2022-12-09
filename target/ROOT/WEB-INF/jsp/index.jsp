<%@ page isELIgnored="false" %>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html lang="es">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Figuras_Geometricas">
    <meta name="author" content="Maru">
    <title>Figuras Geométricas</title>
</head>

<body>
   <style> <%@include file="/WEB-INF/css/styles.css"%></style>
    <main>
        <div>
            <h1>Figure Drawing</h1>
            <canvas width="1024" height="768" id="canvas"></canvas><br>
        </div>
        <div class="column_choice">
            <div class="figure_choice_view">
                <h1>Figure Choice</h1>
                <form action="/save" method="POST">
                    <ul>
                        <li>
                            Name: <input type="text" name="name" id="name" placeholder="circle_1">
                        </li>
                        <li>
                            <label> Figure Type:
                                <select name="figure_type" id="figure_type">
                                    <option value="Circle"> Circle </option>
                                    <option value="Square"> Square </option>
                                    <option value="Triangle"> Triangle </option>
                                    <option value="Pentagon"> Pentagon </option>
                                </select>
                            </label>
                        </li>
                        <li>
                            Size: <input type="range" name="size" id="size">
                        </li>
                        <li>
                            <label> Color:
                                <select name="color" id="color">
                                    <option value="Black">Black </option>
                                    <option value="Green"> Green </option>
                                    <option value="Red"> Red </option>
                                    <option value="Blue"> Blue </option>
                                    <option value="Yellow"> Yellow </option>
                                    <option value="Gray"> Gray </option>
                                </select>
                            </label>
                        </li>
                        <li>
                            Coordinate X: <input type="number" min=0 max=1024 name="coordinate_x" id="coordinate_x"
                                required>
                        </li>
                        <li>
                            Coordinate Y:<input type="number" min=0 max=768 name="coordinate_y" id="coordinate_y"
                                required>
                        </li>
                    </ul>
                    <button class="button" onclick="preview(); return false">Preview</button>
                    <button class="button" onClick="clearCanvas(); return false">Clear</button>
                    <input class="button" type="submit" id="save_button" value="Save">
                </form>
            </div>
            <div class="figure_choice_view">
                <h1> Figure View </h1>
                <div class="figure_view_options">
                    <form action="/getfigures" method="GET">
                        <input name="search-name" type="hidden" value="">
                        <input class="button" type="submit" value="Show global figures record">
                    </form>
                </div>
                <div class="figure_view_options">
                    <form action="/getfigures" method="POST">
                        <input class="button" type="submit" value="Show own figures record">
                </div>
                <div class="figure_view_options">
                    <form action="/getfigures" method="GET">
                        <div class="name-search">
                            <input class="" name="search-name" type"text">
                        </div>
                        <div class="name-search">
                            <input class="button" type="submit" value="Search figure by name">
                        </div>
                    </form>
                </div>
            </div>


        </div>

        <script>

            const canvas = document.getElementById("canvas");
            const canvas_width = 1024;
            const canvas_height = 768;
            const ctx = canvas.getContext("2d");

            var button = document.getElementById('save_button');
            boton.addEventListener("click", block, false);

            function block() {
                if (button.disabled == false) {
                    button.disabled = true;

                    setTimeout(function () {
                        button.disabled = false;
                    }, 2000)
                }
            }

            function drawCircle(coordX, coordY, color, size) {
                ctx.beginPath();
                ctx.strokeStyle = getColor(color);
                ctx.arc(coordX, coordY, size/2, 0, 2 * Math.PI)
                ctx.stroke();
            }

            function drawSquare(coordX, coordY, color, size) {
                let half_size = size / 2;
                ctx.beginPath();
                ctx.strokeStyle = getColor(color);
                ctx.rect(coordX - half_size, coordY - half_size, size, size);
                ctx.stroke();
            }
            function drawTriangle(coordX, coordY, color, size) {
                let half_size = size/2;
                let height = Number(Math.sqrt(Math.pow(size, 2) - Math.pow(half_size, 2)));
                ctx.beginPath();
                ctx.strokeStyle = getColor(color);
                ctx.moveTo(coordX, Number(coordY) - Number(height / 2));
                ctx.lineTo(Number(coordX) + Number(half_size), Number(coordY) + Number(height / 2));
                ctx.lineTo(Number(coordX) - Number(half_size), Number(coordY) + Number(height / 2));
                ctx.closePath();
                ctx.stroke();
            }

            function drawPentagon(coordX, coordY, color, size) {
                ctx.beginPath();
                let step = 2 * Math.PI / 5;
                let shift = (Math.PI / 180.0) * -18;
                for (var i = 0; i < 5; i++) {
                    let ang = i * step + shift;
                    ctx.lineTo(Number(coordX) + size * Math.cos(ang), Number(coordY) + size * Math.sin(ang));
                }
                ctx.strokeStyle = getColor(color);
                ctx.closePath();
                ctx.stroke();
            }

            function clearCanvas() {
                ctx.beginPath();
                ctx.clearRect(0, 0, canvas_width, canvas_height);
            }

            function getColor(color) {
                switch (color) {
                    case "Black":
                        return "#000000";
                        break;
                    case "Green":
                        return "#008000";
                        break;
                    case "Red":
                        return "#FF0000";
                        break;
                    case "Blue":
                        return "#0000FF";
                        break;
                    case "Yellow":
                        return "#FFFF00";
                        break;
                    case "Gray":
                        return "#808080";
                        break;
                }
            }

            function preview() {
                let figure_type = document.getElementById("figure_type").value;
                let size = document.getElementById("size").value;
                let color = document.getElementById("color").value;
                let coordinate_x = document.getElementById("coordinate_x").value;
                let coordinate_y = document.getElementById("coordinate_y").value;

                if (figure_type == "Circle") {
                    drawCircle(coordinate_x, coordinate_y, color, size);
                } else if (figure_type == "Square") {
                    drawSquare(coordinate_x, coordinate_y, color, size);
                } else if (figure_type == "Triangle") {
                    drawTriangle(coordinate_x, coordinate_y, color, size);
                } else if (figure_type == "Pentagon") {
                    drawPentagon(coordinate_x, coordinate_y, color, size);
                }
            }

        </script>
    </main>

</body>

</html>