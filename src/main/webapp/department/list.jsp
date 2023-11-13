<%@ page import="com.example.webapphr1_2023.Beans.Department" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean type="java.util.ArrayList<com.example.webapphr1_2023.Beans.Department>" scope="request" id="departmentList"/>
<% ArrayList<String> idDepNoDelete = (ArrayList<String>) request.getAttribute("departmentsNoDelete"); %>

<script>
    var idsNoDelete= [
        <%for(String id: idDepNoDelete){%>
        '<%=id %>',
        <%}%>
    ];
    console.log(idsNoDelete);
</script>


<!DOCTYPE html>
<html>
<head>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <jsp:include page="../includes/bootstrap_header.jsp"/>
    <title>Listar Departments</title>
</head>
<body>
<div class='container'>

    <h1 class='mb-3'>Lista de Departments en hr</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>">Home</a></li>
            <li class="breadcrumb-item active">Departments</li>
        </ol>
    </nav>
    <a class="btn btn-primary mb-3" href="<%=request.getContextPath()%>/DepartmentServlet?action=new">Crear
        Department</a>
    <table class="table">
        <tr>
            <th>Dep ID</th>
            <th>Dep Name</th>
            <th>Dep Manager</th>
            <th>Dep Location</th>
            <th></th>
            <th></th>
        </tr>
        <%for (Department dep : departmentList) {
            String deletekId = "borrar_" + dep.getDepartmentId();
            String depIdInput = "depId_" + dep.getDepartmentId();
            String street = dep.getStreetAddress();
            String city = ", " + dep.getCity();
            String province =  ", "+ dep.getProvince();
            String country = ", " + dep.getCountry();
            if(street.equals(", "+ null)){
                street ="";
            }
            if(city.equals(", "+ null)){
                city ="";
            }
            if(province.equals(", "+ null)){
                province ="";
            }
            if(country.equals(", "+ null)){
                country ="";
            }%>
        <input type="hidden" id="<%=depIdInput%>" class="form-control" name="depId" value="<%=dep.getDepartmentId()%>">


        <tr>
            <td><%=dep.getDepartmentId()%></td>

            <td><%=dep.getDepartmentName()%></td>

            <% if(dep.getManagerName() != null){%>

                <td><%=dep.getManagerName()%></td>

            <% } else{%>

                <td>------</td>

            <% }%>

            <td><%=street+city+province+country%></td>

            <td>
                <a class="btn btn-primary"
                   href="<%=request.getContextPath()%>/DepartmentServlet?action=edit&idDep=<%=dep.getDepartmentId()%>">
                    <i class="bi bi-pencil-square"></i>
                </a>
            </td>
            <td>
                <a class="btn btn-danger" id="<%=deletekId%>" onclick="return confirmacionEliminar(event)" href="<%=request.getContextPath()%>/DepartmentServlet?action=delete&idDep=<%=dep.getDepartmentId()%>">
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
        var modeladoIdInput = idEventoBorrar.replace("borrar_", "depId_");
        var valueDelInput = document.getElementById(modeladoIdInput).value;

        if(idsNoDelete.includes(valueDelInput)){
            Swal.fire({
                icon: 'error',
                title: 'ERROR:',
                iconColor: '#DC3545',
                confirmButtonColor: '#DC3545',
                confirmButtonText: "Regresar",
                text: "Este departamento está asociado a algunos empleados, por lo tanto, no se puede eliminar."
            });
        }
        else{
            Swal.fire({
                title: '¿Estas seguro de eliminar este departamento?',
                text: "No se podrán revertir estos cambios",
                icon: 'warning',
                iconColor: '#DC3545',
                showCancelButton: true,
                cancelButtonColor: '#0D6EFD',
                cancelButtonText: 'Cancelar',
                confirmButtonColor: '#DC3545',
                confirmButtonText: 'Borrar'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = document.getElementById(deleteLinkId).getAttribute('href');
                }});
        }
    }
</script>
<jsp:include page="../includes/bootstrap_footer.jsp"/>
</body>
</html>


