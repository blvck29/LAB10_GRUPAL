<%@ page import="com.example.webapphr1_2023.Beans.Department" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.webapphr1_2023.Beans.Employee" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%
    ArrayList<Employee> employeesList = (ArrayList<Employee>) request.getAttribute("employeesList");
    ArrayList<Department> locationsList = (ArrayList<Department>) request.getAttribute("locationsList");
    ArrayList<Department> idsDepartments = (ArrayList<Department>) request.getAttribute("idsDepartments");

    ArrayList<String> ids = new ArrayList<>();

    for (Department d : idsDepartments){
        ids.add(d.getDepartmentId()+"");
    }
%>

<script>
    var idsNoDisponibles = [
        <%for (String id : ids){%>
        '<%= id %>',
        <% }  %>
    ];
    console.log(idsNoDisponibles);
</script>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../includes/bootstrap_header.jsp" />
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Crear un departamento</title>
</head>
<body>
<div class='container'>
    <h1 class='mb-3'>Crear un departamento</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>">Home</a></li>
            <li class="breadcrumb-item "><a href="<%= request.getContextPath()%>/DepartmentServlet">Departments</a></li>
            <li class="breadcrumb-item active">Crear Departamento</li>
        </ol>
    </nav>

    <form method="POST" id="form" action="<%=request.getContextPath()%>/DepartmentServlet?action=new" class="col-md-6 col-lg-6">


        <div class="mb-3">
            <label for="first_name">Department ID</label>
            <input type="text" id="idElegido" class="form-control form-control-sm" name="depId" required>
        </div>


        <div class="mb-3">
            <label for="first_name">Department Name</label>
            <input type="text" class="form-control form-control-sm" name="departmentName" required>
        </div>


        <div class="mb-3">
            <label for="minSalary">Department Manager</label>
            <select class="form-select" name="managerId" aria-label="Default select example" required>
                <option selected disabled value="">Seleccionar manager</option>
                <option value="UNSET" >--- No Asignar ---</option>

                <%for (Employee e : employeesList){ %>

                <option value="<%=e.getEmployeeId()%>"><%=e.getFirstName() + " " + e.getLastName()%></option>

                <%}%>

            </select>
        </div>


        <div class="mb-3">
            <label for="maxSalary">Department Location</label>
            <select class="form-select" name="locationId" aria-label="Default select example" required>
                <option selected disabled value="">Seleccionar ubicación</option>
                <%
                    for (Department loc : locationsList) {

                        String street = loc.getStreetAddress();
                        String city = ", " + loc.getCity();
                        String province =  ", "+ loc.getProvince();

                        if(street.equals(", "+ null)){
                            street ="";
                        }
                        if(city.equals(", "+ null)){
                            city ="";
                        }
                        if(province.equals(", "+ null)){
                            province ="";
                        }

                %>
                <option value="<%=loc.getLocationId()%>"><%=street+city+province%></option>

                <%}%>

            </select>
        </div>
        <a href="<%=request.getContextPath()%>/DepartmentServlet" class="btn btn-danger">Regresar</a>
        <button type="submit" class="btn btn-primary">Aplicar Cambios</button>

    </form>
</div>

<script>
    const idElegido = document.getElementById("idElegido")
    const form = document.getElementById("form")
    form.addEventListener("submit", e=>{

        if (idsNoDisponibles.includes(idElegido.value)){
            Swal.fire({
                icon: 'error',
                title: 'ERROR:',
                iconColor: '#DC3545',
                confirmButtonColor: '#DC3545',
                confirmButtonText: "Regresar",
                text: "El ID elegido ya está en uso",
                footer: '<a href="">Volver a ingresar los datos</a>'
            });
            e.preventDefault();
        } else if (isNaN(idElegido.value)) {
            Swal.fire({
                icon: 'error',
                title: 'ERROR:',
                iconColor: '#DC3545',
                confirmButtonColor: '#DC3545',
                confirmButtonText: "Regresar",
                text: "Debe ingresar un número en Department ID",
                footer: '<a href="">Volver a ingresar los datos</a>'
            });
            e.preventDefault();
        }else if (idElegido.value<1) {
            Swal.fire({
                icon: 'error',
                title: 'ERROR:',
                iconColor: '#DC3545',
                confirmButtonColor: '#DC3545',
                confirmButtonText: "Regresar",
                text: "Department ID debe ser mayor a 0",
                footer: '<a href="">Volver a ingresar los datos</a>'
            });
            e.preventDefault();
        }
        else{

        }
    })
</script>



<jsp:include page="../includes/bootstrap_footer.jsp" />
</body>
</html>
