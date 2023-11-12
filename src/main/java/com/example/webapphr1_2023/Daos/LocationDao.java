package com.example.webapphr1_2023.Daos;

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

                location.(rs.getInt(1));
                department.setDepartmentName(rs.getString(2));

                list.add(location);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        return list;
    }
}