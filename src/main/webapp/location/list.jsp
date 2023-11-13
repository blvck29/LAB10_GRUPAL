<%@ page import="com.example.webapphr1_2023.Beans.Location" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean type="java.util.ArrayList<com.example.webapphr1_2023.Beans.Location>" scope="request" id="locationList"/>
<%ArrayList<String> idLocNoDelete = (ArrayList<String>) request.getAttribute("locationsNoDelete");%>
<script>
    var idsNoDelete= [
        <%for(String id: idLocNoDelete){%>
        '<%=id %>',
        <%}%>
    ];
    console.log(idsNoDelete);
</script>


<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../includes/bootstrap_header.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
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
                String deleteId = "borrar_" + loc.getLocationId();
                String locIdInput = "locId_" + loc.getLocationId();
        %>
        <input type="hidden" id="<%=locIdInput%>" class="form-control" name="depId" value="<%=loc.getLocationId()%>">
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
                <a class="btn btn-danger" id="<%=deleteId%>" onclick="return confirmacionEliminar(event)" href="<%=request.getContextPath()%>/LocationServlet?action=borrar&id=<%=loc.getLocationId()%>">
                    <i class="bi bi-trash3"></i>
                </a>
            </td>
        </tr>
        <%
            }
        %>
    </table>
</div>


<script>
    function confirmacionEliminar(event) {
        event.preventDefault();
        var idEventoBorrar = event.currentTarget.id;
        var modeladoIdInput = idEventoBorrar.replace("borrar_", "locId_");
        var valueDelInput = document.getElementById(modeladoIdInput).value;
        console.log(valueDelInput)

        if(idsNoDelete.includes(valueDelInput)){
            Swal.fire({
                icon: 'error',
                title: 'ERROR:',
                iconColor: '#DC3545',
                confirmButtonColor: '#DC3545',
                confirmButtonText: "Regresar",
                text: "Este ubicación está asociada a algunos departamentos, por lo tanto, no se puede eliminar."
            });
        }
        else{
            Swal.fire({
                title: '¿Estas seguro de eliminar esta ubicación?',
                text: "No se podrán revertir los cambios",
                icon: 'warning',
                iconColor: '#DC3545',
                showCancelButton: true,
                cancelButtonColor: '#0D6EFD',
                cancelButtonText: 'Cancelar',
                confirmButtonColor: '#DC3545',
                confirmButtonText: 'Borrar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = document.getElementById(idEventoBorrar).getAttribute('href');
                }});
        }
    }
</script>
<jsp:include page="../includes/bootstrap_footer.jsp"/>
</body>
</html>


