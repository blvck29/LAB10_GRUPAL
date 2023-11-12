package com.example.webapphr1_2023.Controllers;

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

                req.setAttribute("locationList", locationList);
                req.getRequestDispatcher("location/list.jsp").forward(req,resp);
                break;

            case "formCrear":
                
                break;

        }

    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        super.doPost(req, resp);
    }
}