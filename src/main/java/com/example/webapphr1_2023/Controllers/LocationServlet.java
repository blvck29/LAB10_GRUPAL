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


@WebServlet(name = "LocationServlet", urlPatterns = {"/LocationServlet"})
public class LocationServlet extends HttpServlet {

    LocationDao locationDao = new LocationDao();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String action = req.getParameter("action") == null? "list" : req.getParameter("action");

        switch (action){
            case "list":
                ArrayList<Location> locationList = locationDao.lista();

                String notify = req.getParameter("notify") == null? "null" : req.getParameter("notify");
                String notification = "Hubo un error al crear el nuevo Location, inténtelo de nuevo.";

                req.setAttribute("locationList", locationList);

                switch (notify){
                    case "null":
                        notification = "null";
                        req.setAttribute("notification", notification);
                        break;
                    case "error":
                        req.setAttribute("notification", notification);
                        break;
                    case "success":
                        notification = "La creación del nuevo Location fue un éxito.";
                        req.setAttribute("notification", notification);
                        break;
                }


                req.getRequestDispatcher("location/list.jsp").forward(req,resp);
                break;

            case "formCrear":
                ArrayList<Country> listaCountries = locationDao.listaCountries();
                req.setAttribute("listaCountries",listaCountries);
                req.getRequestDispatcher("location/form_crear.jsp").forward(req,resp);
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

                if (countryId.equals("no-country")){
                    countryId = null;
                }

                locationDao.crear(locationId, streetAddress, postalCode, city, stateProvince, countryId);
                resp.sendRedirect(req.getContextPath() + "/LocationServlet?action=list&notify=success");
                break;
        }

    }
}