package com.example.webapphr1_2023.Daos;


import com.example.webapphr1_2023.Beans.Department;
import com.example.webapphr1_2023.Beans.Employee;

import java.sql.*;
import java.util.ArrayList;

public class DepartmentDao extends DaoBase {

    public ArrayList<Department> lista() {

        ArrayList<Department> list = new ArrayList<>();

        String sql = "select * from departments";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Department department = new Department();
                department.setDepartmentId(rs.getInt(1));
                department.setDepartmentName(rs.getString(2));
                list.add(department);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        return list;
    }


    public ArrayList<Department> listarConNombres() {

        ArrayList<Department> list = new ArrayList<>();

        String sql = "select d.*, concat(e.first_name,\" \", e.last_name), l.street_address,l.city,l.state_province\n" +
                "from departments d\n" +
                "left join employees e on (d.manager_id = e.employee_id)\n" +
                "left join locations l on (d.location_id = l.location_id)";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Department department = new Department();

                department.setDepartmentId(rs.getInt(1));
                department.setDepartmentName(rs.getString(2));
                department.setManagerId(rs.getInt(3));
                department.setLocationId(rs.getInt(4));
                department.setManagerName(rs.getString(5));
                department.setStreetAddress(rs.getString(6));
                department.setCity(rs.getString(7));
                department.setProvince(rs.getString(8));

                list.add(department);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        return list;
    }



    public Department buscarPorId(String idDep) {

        Department department = null;

        String sql = "select d.*, concat(e.first_name,\" \", e.last_name), l.street_address,l.city,l.state_province\n" +
                "from departments d\n" +
                "left join employees e on (d.manager_id = e.employee_id)\n" +
                "left join locations l on (d.location_id = l.location_id)\n" +
                "where d.department_id = ? ";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql) ) {

            pstmt.setString(1,idDep);

            try(ResultSet rs = pstmt.executeQuery()){

                while (rs.next()){
                    department = new Department();
                    department.setDepartmentId(rs.getInt(1));
                    department.setDepartmentName(rs.getString(2));
                    department.setManagerId(rs.getInt(3));
                    department.setLocationId(rs.getInt(4));
                    department.setManagerName(rs.getString(5));
                    department.setStreetAddress(rs.getString(6));
                    department.setCity(rs.getString(7));
                    department.setProvince(rs.getString(8));
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return department;
    }


    public ArrayList<Department> locationsList() {

        ArrayList<Department> locationsList = new ArrayList<>();

        String sql = "select location_id, street_address,city,state_province FROM hr.locations;";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Department location = new Department();

                location.setLocationId(rs.getInt(1));
                location.setStreetAddress(rs.getString(2));
                location.setCity(rs.getString(3));
                location.setProvince(rs.getString(4));

                locationsList.add(location);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);

        }
        return locationsList;
    }


    public void updateDepartment(String name, String idManager, String idLocation, String idDepartment){

        String sql = "update departments set department_name = ?, manager_id = ?, location_id = ? where department_id = ?";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,name);
            if (idManager.equals("UNSET")) {
                pstmt.setNull(2, java.sql.Types.VARCHAR);
            } else {
                pstmt.setString(2, idManager);
            }
            pstmt.setString(3,idLocation);
            pstmt.setString(4, idDepartment);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void newDepartment(String idDep, String name, String idManager,  String idLocation){

        String sql = "insert into departments (department_id, department_name,manager_id,location_id) values (?,?,?,?)";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){

            pstmt.setString(1, idDep);
            pstmt.setString(2, name);
            if (idManager.equals("UNSET")){
                pstmt.setNull(3, java.sql.Types.VARCHAR);
            }else{
                pstmt.setString(3, idManager);
            }
            pstmt.setString(4, idLocation);

            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public void deleteDepartment(String idDepartment){

        String sql ="delete from departments where department_id = ?";

        try(Connection conn = getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)) {

            pstmt.setString(1,idDepartment);
            pstmt.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }


    public ArrayList<Employee> listNoManagerDepartments() {

        ArrayList<Employee> listaEmpleados = new ArrayList<>();

        String sql = "SELECT * FROM employees e\n" +
                "WHERE e.employee_id NOT IN (SELECT d.manager_id FROM departments d WHERE d.manager_id IS NOT NULL) order by first_name";

        try (Connection conn = getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Employee e = new Employee();
                e.setEmployeeId(rs.getInt(1));
                e.setFirstName(rs.getString(2));
                e.setLastName(rs.getString(3));
                listaEmpleados.add(e);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

        return listaEmpleados;
    }




}