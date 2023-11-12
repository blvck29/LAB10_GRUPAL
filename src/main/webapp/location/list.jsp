<%@ page import="com.example.webapphr1_2023.Beans.Location" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean type="java.util.ArrayList<com.example.webapphr1_2023.Beans.Location>" scope="request" id="locationList"/>


<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../includes/bootstrap_header.jsp"/>
    <title>Listar Locations</title>
</head>
<body>
<div class='container'>

    <h1 class='mb-3'>Lista de Locations en hr</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>">Home</a></li>
            <li class="breadcrumb-item active">Locations</li>
        </ol>
    </nav>

    <% if (request.getParameter("notify") != null) { %>
    <% String notification = (String) request.getAttribute("notification"); %>
    <% String notifyType = request.getParameter("notify"); %>

    <div id="notification" class="alert <%=(notifyType.equals("success")) ? "alert-success" : "alert-danger"%>" role="alert">
        <%=notification%>
    </div>

    <script>
        // Ocultar la notificación después de 10 segundos.
        setTimeout(function () {
            var notificationDiv = document.getElementById("notification");
            if (notificationDiv) {
                notificationDiv.style.display = 'none';
            }
        }, 10000);
    </script>
    <% } %>

    <a class="btn btn-primary mb-3" href="<%=request.getContextPath()%>/LocationServlet?action=formCrear">Crear
        Location</a>
    <table class="table">
        <tr>
            <th>Loc ID</th>
            <th>Street Address</th>
            <th>Postal Code</th>
            <th>City</th>
            <th>State Province</th>
            <th>Country id</th>
            <th></th>
            <th></th>
        </tr>
        <%
            for (Location loc : locationList) {
        %>
        <tr>
            <td><%=loc.getLocationId()%>
            </td>
            <td><%=loc.getStreetAddress()%>
            </td>
            <td><%=loc.getPostalCode()%>
            </td>
            <td><%=loc.getCity()%>
            </td>
            <% if (loc.getStateProvince()==null) {%>
            <td>------
            </td>
            <%} else {%>
            <td><%=loc.getStateProvince()%>
            </td>
            <%}%>
            <td><%=loc.getCountry().getCountryName()%>
            </td>
            <td>
                <a class="btn btn-primary"
                   href="<%=request.getContextPath()%>/LocationServlet?action=formEditar&id=<%=loc.getLocationId()%>">
                    <i class="bi bi-pencil-square"></i>
                </a>
            </td>
            <td>
                <a onclick="return confirm('¿Estas seguro de borrar?');" class="btn btn-danger"
                   href="<%=request.getContextPath()%>/LocationServlet?action=borrar&id=<%=loc.getLocationId()%>">
                    <i class="bi bi-trash3"></i>
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>
<jsp:include page="../includes/bootstrap_footer.jsp"/>
</body>
</html>


