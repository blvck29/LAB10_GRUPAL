package com.example.webapphr1_2023.Controllers;

import com.example.webapphr1_2023.Beans.Country;
import com.example.webapphr1_2023.Beans.Location;
import com.example.webapphr1_2023.Daos.LocationDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.awt.datatransfer.DataFlavor;
import java.io.IOException;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Objects;


@WebServlet(name = "LocationServlet", urlPatterns = {"/LocationServlet"})
public class LocationServlet extends HttpServlet {

    LocationDao locationDao = new LocationDao();
    ArrayList<Country> listaCountries = locationDao.listaCountries();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action") == null? "list" : req.getParameter("action");

        switch (action){
            case "list":
                ArrayList<Location> locationList = locationDao.lista();
                req.setAttribute("locationsNoDelete", locationDao.locationsNoDelete());
                req.setAttribute("locationList", locationList);

                if (req.getParameter("notify") != null){

                    String notify = req.getParameter("notify");
                    String notification = "Hubo un error, inténtelo de nuevo.";

                    switch (notify){
                        case "error":
                            req.setAttribute("notification", notification);
                            break;
                        case "success":
                            notification = "La acción realizada fue un éxito.";
                            req.setAttribute("notification", notification);
                            break;
                    }
                }

                req.getRequestDispatcher("location/list.jsp").forward(req,resp);
                break;

            case "formCrear":
                ArrayList<Location> listaIdsLoc = locationDao.listaIds();
                req.setAttribute("listaIds", listaIdsLoc);
                req.setAttribute("listaCountries",listaCountries);
                req.getRequestDispatcher("location/form_crear.jsp").forward(req,resp);
                break;

            case "formEditar":
                String locationId = req.getParameter("id");
                Location location = locationDao.obtenerLocation(locationId);

                req.setAttribute("location",location);
                req.setAttribute("listaCountries",listaCountries);
                req.getRequestDispatcher("location/form_editar.jsp").forward(req,resp);
                break;

            case "borrar":
                if (req.getParameter("id") != null) {
                    String locationIdStr = req.getParameter("id");
                    int idLocation = 0;
                    try {
                        idLocation = Integer.parseInt(locationIdStr);
                    } catch (NumberFormatException ex) {
                        resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=error");
                    }

                    Location loc = locationDao.obtenerLocation(String.valueOf(idLocation));

                    if (loc != null) {
                        locationDao.borrar(String.valueOf(idLocation));
                        resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=success");
                    } else {
                        resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=error");
                    }
                }
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action") == null? "error" : req.getParameter("action");

        switch (action){
            case "crear":

                String locationId = req.getParameter("locationId");
                String streetAddress = req.getParameter("streetAddress");
                String postalCode = req.getParameter("postalCode");
                String city = req.getParameter("city");
                String stateProvince = req.getParameter("stateProvince");
                String countryId = req.getParameter("country");

                locationDao.crear(locationId, streetAddress, postalCode, city, stateProvince, countryId);
                if (locationDao.obtenerLocation(locationId) != null){
                    resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=success");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=error");
                }
                break;

            case "edit":
                String oldLocationId = req.getParameter("id");
                String newLocationId = req.getParameter("locationId");
                String newStreetAddress = req.getParameter("streetAddress");
                String newPostalCode = req.getParameter("postalCode");
                String newCity = req.getParameter("city");
                String newStateProvince = req.getParameter("stateProvince");
                String newCountryId = req.getParameter("country");

                if (Objects.equals(newStateProvince, "")){
                    newStateProvince = null;
                }

                if (locationDao.verifyId(oldLocationId, newLocationId)){
                    locationDao.edit(oldLocationId, newLocationId, newStreetAddress, newPostalCode, newCity, newStateProvince, newCountryId);
                } else {
                    resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=error");
                }

                if (locationDao.obtenerLocation(newLocationId) != null){
                    resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=success");
                } else {
                    resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=error");
                }
                break;

        }

    }
}