<%@ page isELIgnored="false" %>
<%@page import="java.util.List"%>
<%@page import="java.util.Arrays"%>
<%@ taglib uri ="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>

<head>
</head>

<body>
    <style><%@include file="/WEB-INF/css/styles.css"%></style>
    <h1>Historial de figuras</h1>
    <a href="javascript:history.back()"><button class="back">Back</button></a>
    <table>
        <tr>
            <th>Figure Name</th>
            <th>Creation Date</th>
            <th>Figure Type</th>
            <th>Preview</th>
            <th>Delete</th>
        </tr>
        <c:forEach items="${figureList}" var="f">
            <tr>
                <td>${f.getName()}</td>
                <td>${f.getDate()}</td>
                <td>${f.getType()}</td>
                <td>
                    <form action="/preview" method="POST">
                        <input type="hidden" name="user_id" value="${f.getUser().getId()}" />
                        <input type="hidden" name="figure_id" value="${f.getId()}" />
                        <button class="button" onClick="this.form.submit()" name="preview">🔍</button>
                    </form>
                </td>
                <td>
                    <form action="/delete" method="GET">
                        <input type="hidden" name="user_id" value="${f.getUser().getId()}" />
                        <input type="hidden" name="figure_id" value="${f.getId()}" />
                        <c:if test="${f.getUser().getId() eq sessionId}">
                          <button class="button" onClick="this.form.submit()" name="delete">❌</button>
                        </c:if>
                    </form>
                </td>
            </tr>
        </c:forEach>
    </table>
</body>

</html>