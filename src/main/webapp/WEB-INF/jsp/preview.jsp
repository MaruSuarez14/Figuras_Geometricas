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
    <h1 class="main_title">Geometric Figures</h1>
    <a href="javascript:history.back()"><button class="back">Back</button></a>
    <main>
        <canvas class="canvas-preview" height="768" width="1024" id="canvas"></canvas><br>
    <script>
        const canvas = document.getElementById("canvas");
        const ctx = canvas.getContext("2d");
        preview();

        function preview() {
            let figure_type = '${f.getType()}';
            let size = '${f.getSize()}';
            let color = '${f.getColor()}';
            let coordinate_x = '${f.getCoordinateX()}';
            let coordinate_y = '${f.getCoordinateY()}';

            if (figure_type == "CIRCLE") {
                drawCircle(coordinate_x, coordinate_y, color, size, size / 2);
            } else if (figure_type == "SQUARE") {
                drawSquare(coordinate_x, coordinate_y, color, size, size / 2);
            } else if (figure_type == "TRIANGLE") {
                drawTriangle(coordinate_x, coordinate_y, color, size, size / 2);
            } else if (figure_type == "PENTAGON") {
                drawPentagon(coordinate_x, coordinate_y, color, size);
            }
         }

        function drawCircle(coordX, coordY, color, size, half_size) {
            ctx.beginPath();
            ctx.strokeStyle = getColor(color);
            ctx.arc(coordX, coordY, half_size, 0, 2 * Math.PI)
            ctx.stroke();
        }

        function drawSquare(coordX, coordY, color, size, half_size) {
            ctx.beginPath();
            ctx.strokeStyle = getColor(color);
            ctx.rect(coordX - half_size, coordY - half_size, size, size);
            ctx.stroke();
        }

        function drawTriangle(coordX, coordY, color, size, half_size) {
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

        function getColor(color) {
            switch (color) {
                case "BLACK":
                    return "#000000";
                    break;
                case "GREEN":
                    return "#008000";
                    break;
                case "RED":
                    return "#FF0000";
                    break;
                case "BLUE":
                    return "#0000FF";
                    break;
                case "YELLOW":
                    return "#FFFF00";
                    break;
                case "GRAY":
                    return "#808080";
                    break;
            }
        }

    </script>
    </main>

</body>

</html>