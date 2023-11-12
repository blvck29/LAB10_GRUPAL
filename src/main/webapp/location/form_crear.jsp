<%@ page import="com.example.webapphr1_2023.Beans.Country" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.webapphr1_2023.Beans.Location" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean type="java.util.ArrayList<com.example.webapphr1_2023.Beans.Country>" scope="request" id="listaCountries"/>
<% ArrayList<Location> listaIds = (ArrayList<Location>) request.getAttribute("listaIds"); %>

<%
ArrayList<String> idsString = new ArrayList<>();
for(Location l : listaIds){
    idsString.add(l.getLocationId()+"");}
%>
<script>
    var idsNoDisponibles= [
        <% for(String id : idsString){ %>
          '<%=id %>',
        <%}%>
    ];
    console.log(idsNoDisponibles);
</script>

<html>
<head>
    <jsp:include page="../includes/bootstrap_header.jsp"/>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <title>Crear un nuevo Location</title>
</head>
<body>
<div class='container'>
    <h1 class='mb-3'>Crear un nuevo Location</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>">Home</a></li>
            <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/LocationServlet">Locations</a></li>
            <li class="breadcrumb-item active">Crear Location</li>
        </ol>
    </nav>

    <form method="POST" id="form" action="<%=request.getContextPath()%>/LocationServlet?action=crear" class="col-md-6 col-lg-6">
        <div class="mb-3">
            <label for="locationId">Location ID</label>
            <input required type="text" class="form-control" id="locationId" name="locationId">
        </div>
        <div class="mb-3">
            <label for="streetAddress">Street Addres</label>
            <input required type="text" class="form-control" id="streetAddress" name="streetAddress">
        </div>
        <div class="mb-3">
            <label for="postalCode">Postal Code</label>
            <input required type="text" class="form-control" id="postalCode" name="postalCode">
        </div>
        <div class="mb-3">
            <label for="city">City</label>
            <input required type="text" class="form-control" id="city" name="city">
        </div>
        <div class="mb-3">
            <label for="stateProvince">State Province</label>
            <input required type="text" class="form-control" id="stateProvince" name="stateProvince">
        </div>
        <div class="mb-3 form-group">
            <label for="country">Country</label>
            <select required name="country" id="country" class="form-select">
                <option selected disabled value="">Seleccionar country</option>
                <% for (Country con : listaCountries) {%>
                <option value="<%=con.getCountryId()%>"><%=con.getCountryName()%>
                </option>
                <% }%>
            </select>
        </div>
        <a href="<%=request.getContextPath()%>/LocationServlet" class="btn btn-danger">Regresar</a>
        <button type="submit" class="btn btn-primary">Submit</button>
    </form>


    <script>
        const id = document.getElementById("locationId")
        const form = document.getElementById("form")
        form.addEventListener("submit", e =>{

            if(idsNoDisponibles.includes(id.value)){
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
            }else if (isNaN(id.value)) {
                Swal.fire({
                    icon: 'error',
                    title: 'ERROR:',
                    iconColor: '#DC3545',
                    confirmButtonColor: '#DC3545',
                    confirmButtonText: "Regresar",
                    text: "Debe ingresar un número en Location ID",
                    footer: '<a href="">Volver a ingresar los datos</a>'
                });
                e.preventDefault();
            }else if (id.value<1) {
                Swal.fire({
                    icon: 'error',
                    title: 'ERROR:',
                    iconColor: '#DC3545',
                    confirmButtonColor: '#DC3545',
                    confirmButtonText: "Regresar",
                    text: "Location ID debe ser mayor a 0",
                    footer: '<a href="">Volver a ingresar los datos</a>'
                });
                e.preventDefault();
            }else{
            }
        })
    </script>


</div>
</body>
</html>
