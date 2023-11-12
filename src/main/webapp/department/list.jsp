<%@ page import="com.example.webapphr1_2023.Beans.Department" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean type="java.util.ArrayList<com.example.webapphr1_2023.Beans.Department>" scope="request" id="departmentList"/>


<!DOCTYPE html>
<html>
<head>
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
        <%
            for (Department dep : departmentList) {

                String street = dep.getStreetAddress();
                String city = ", " + dep.getCity();
                String province =  ", "+ dep.getProvince();

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



        <tr>
            <td><%=dep.getDepartmentId()%></td>

            <td><%=dep.getDepartmentName()%></td>

            <% if(dep.getManagerName() != null){%>

                <td><%=dep.getManagerName()%></td>

            <% } else{%>

                <td>------</td>

            <% }%>

            <td><%=street+city+province %></td>

            <td>
                <a class="btn btn-primary"
                   href="<%=request.getContextPath()%>/DepartmentServlet?action=edit&idDep=<%=dep.getDepartmentId()%>">
                    <i class="bi bi-pencil-square"></i>
                </a>
            </td>
            <td>
                <a class="btn btn-danger" onclick="alert('¿Estás seguro de querer eliminar este departamento?')" href="<%=request.getContextPath()%>/DepartmentServlet?action=delete&idDep=<%=dep.getDepartmentId()%>">
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


