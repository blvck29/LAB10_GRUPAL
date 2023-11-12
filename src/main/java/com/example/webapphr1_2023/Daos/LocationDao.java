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

    public ArrayList<Country> listaCountries() {

        ArrayList<Country> list = new ArrayList<>();
        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM countries;")) {

            while (rs.next()) {
                Country country = new Country();

                country.setCountryId(rs.getString(1));
                country.setCountryName(rs.getString(2));
                country.setRegionId(rs.getString(3));

                list.add(country);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        return list;
    }

    public Location obtenerLocation(String locationId) {

        Location loc = new Location();

        String sql = "SELECT * FROM locations loc LEFT JOIN countries c ON loc.country_id = c.country_id WHERE location_id = ?;";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, locationId);

            try(ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {
                    loc.setLocationId(rs.getInt(1));
                    loc.setStreetAddress(rs.getString(2));
                    loc.setPostalCode(rs.getString(3));
                    loc.setCity(rs.getString(4));
                    loc.setStateProvince(rs.getString(5));

                    Country country = new Country();

                    country.setCountryId(rs.getString(6));
                    country.setCountryName(rs.getString("country_name"));
                    country.setRegionId(rs.getString("region_id"));

                    loc.setCountry(country);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return loc;
    }


    public void crear(String locationId, String streetAddress, String postalCode, String city, String stateProvince, String countryId){

        String sql = "INSERT INTO `hr`.`locations` (`location_id`, `street_address`, `postal_code`, `city`, `state_province`, `country_id`) VALUES (?, ?, ?, ?, ?, ?);";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, locationId);
            pstmt.setString(2, streetAddress);
            pstmt.setString(3, postalCode);
            pstmt.setString(4, city);
            pstmt.setString(5, stateProvince);
            pstmt.setString(6, countryId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void edit(String oldId, String locationId, String streetAddress, String postalCode, String city, String stateProvince, String countryId){

        String sql = "UPDATE `hr`.`locations` SET `location_id`=?, `street_address`=?, `postal_code`=?, `city`=?, `state_province`=?, `country_id`=? WHERE `location_id`=?;";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, locationId);
            pstmt.setString(2, streetAddress);
            pstmt.setString(3, postalCode);
            pstmt.setString(4, city);
            pstmt.setString(5, stateProvince);
            pstmt.setString(6, countryId);
            pstmt.setString(7, oldId);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

    }

    public void borrar(String id) {

        String sql = "DELETE FROM `hr`.`locations` WHERE `location_id`=?;";

        try (Connection conn = getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1, id);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}