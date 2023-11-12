<%@ page import="com.example.webapphr1_2023.Beans.Country" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<jsp:useBean type="com.example.webapphr1_2023.Beans.Location" scope="request" id="location"/>
<jsp:useBean type="java.util.ArrayList<com.example.webapphr1_2023.Beans.Country>" scope="request" id="listaCountries"/>



<html>
<head>
  <jsp:include page="../includes/bootstrap_header.jsp"/>
  <title>Editar Location</title>
</head>
<body>
<div class='container'>
  <h1 class='mb-3'>Editar Location</h1>
  <nav aria-label="breadcrumb">
    <ol class="breadcrumb">
      <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>">Home</a></li>
      <li class="breadcrumb-item"><a href="<%= request.getContextPath()%>/LocationServlet">Locations</a></li>
      <li class="breadcrumb-item active">Editar Location</li>
    </ol>
  </nav>

  <form method="POST" action="<%=request.getContextPath()%>/LocationServlet?action=edit&id=<%=location.getLocationId()%>" class="col-md-6 col-lg-6">
    <div class="mb-3">
      <label for="locationId">Location ID</label>
      <input required type="text" class="form-control" id="locationId" name="locationId" value="<%=location.getLocationId()%>">
    </div>
    <div class="mb-3">
      <label for="streetAddress">Street Addres</label>
      <input required type="text" class="form-control" id="streetAddress" name="streetAddress"  value="<%=location.getStreetAddress()%>">
    </div>
    <div class="mb-3">
      <label for="postalCode">Postal Code</label>
      <input required type="text" class="form-control" id="postalCode" name="postalCode"  value="<%=location.getPostalCode()%>">
    </div>
    <div class="mb-3">
      <label for="city">City</label>
      <input required type="text" class="form-control" id="city" name="city"  value="<%=location.getCity()%>">
    </div>
    <div class="mb-3">
      <label for="stateProvince">State Province</label>
      <input type="text" class="form-control" id="stateProvince" name="stateProvince"  <%if(location.getStateProvince() != null) {%>value="<%=location.getStateProvince()%><%}%>">
    </div>
    <div class="mb-3 form-group">
      <label for="country">Country</label>
      <select required name="country" id="country" class="form-control">
        <% for (Country con : listaCountries) { %>
        <option value="<%=con.getCountryId()%>" <%= location.getCountry().getCountryName().equals(con.getCountryName()) ? "selected" : "" %> >
          <%=con.getCountryName()%>
        </option>
        <% } %>
      </select>
    </div>
    <a href="<%=request.getContextPath()%>/LocationServlet" class="btn btn-danger">Regresar</a>
    <button type="submit" class="btn btn-primary">Submit</button>
  </form>


</div>
</body>
</html>
