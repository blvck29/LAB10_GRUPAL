package com.example.webapphr1_2023.Daos;

import com.example.webapphr1_2023.Beans.Country;
import com.example.webapphr1_2023.Beans.Location;

import java.sql.*;
import java.util.ArrayList;

public class LocationDao extends DaoBase {

    public ArrayList<Location> lista() {

        ArrayList<Location> list = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM locations loc LEFT JOIN countries c ON loc.country_id = c.country_id;")) {

            while (rs.next()) {
                Location location = new Location();

                location.setLocationId(rs.getInt(1));
                location.setStreetAddress(rs.getString(2));
                location.setPostalCode(rs.getString(3));
                location.setCity(rs.getString(4));
                location.setStateProvince(rs.getString(5));

                Country country = new Country();

                country.setCountryId(rs.getString(6));
                country.setCountryName(rs.getString("country_name"));
                country.setRegionId(rs.getString("region_id"));

                location.setCountry(country);

                list.add(location);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        return list;
    }
}