<%@ page import="com.example.webapphr1_2023.Beans.Department" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.webapphr1_2023.Beans.Employee" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Department dep = (Department) request.getAttribute("department");
   ArrayList<Employee> employeesList = (ArrayList<Employee>) request.getAttribute("employeesList");
   ArrayList<Department> locationsList = (ArrayList<Department>) request.getAttribute("locationsList");
%>

<!DOCTYPE html>
<html>
<head>
    <jsp:include page="../includes/bootstrap_header.jsp" />
    <title>Editar un departamento</title>
</head>
<body>
<div class='container'>
    <h1 class='mb-3'>Editar un Departamento</h1>
    <nav aria-label="breadcrumb">
        <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>">Home</a></li>
            <li class="breadcrumb-item "><a href="<%= request.getContextPath()%>/DepartmentServlet">Departments</a></li>
            <li class="breadcrumb-item active">Editar Departamento</li>

        </ol>
    </nav>

    <form method="POST" action="<%=request.getContextPath()%>/DepartmentServlet?action=edit" class="col-md-6 col-lg-6">
        <input type="hidden" class="form-control" name="depId" value="<%=dep.getDepartmentId()%>">


        <div class="mb-3">
            <label for="jobTitle">Department Name</label>
            <input type="text" class="form-control" name="departmentName" value="<%=dep.getDepartmentName()%>">
        </div>




        <div class="mb-3">
            <label for="minSalary">Department Manager</label>
            <select class="form-select" name=managerId aria-label="Default select example">

                <%if(dep.getManagerName() == null){%>
                <option value="UNSET" selected>--- No Asignar ---</option>

                <%}else{%>
                <option value="<%=dep.getManagerId()%>" selected><%=dep.getManagerName()%></option>
                <option value="UNSET" >--- No Asignar ---</option>
                <%}%>

                <%for (Employee e : employeesList){ %>

                <option value="<%=e.getEmployeeId()%>"><%=e.getFirstName() + " " + e.getLastName()%></option>

                <%}%>

            </select>
        </div>


        <div class="mb-3">
            <label for="maxSalary">Department Location</label>
            <select class="form-select" name=locationId aria-label="Default select example">

                <%for (Department loc : locationsList) {

                        String street = loc.getStreetAddress();
                        String city = ", " + loc.getCity();
                        String province =  ", "+ loc.getProvince();
                        String country = ", " + loc.getCountry();

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

                <option value="<%=loc.getLocationId()%>"  <%=loc.getLocationId()==dep.getLocationId() ? "selected": ""%>><%=street+city+province+country%></option>

                <%}%>

            </select>
        </div>



        <a href="<%=request.getContextPath()%>/DepartmentServlet" class="btn btn-danger">Regresar</a>
        <button type="submit" class="btn btn-primary">Aplicar Cambios</button>

    </form>
</div>
<jsp:include page="../includes/bootstrap_footer.jsp" />
</body>
</html>
