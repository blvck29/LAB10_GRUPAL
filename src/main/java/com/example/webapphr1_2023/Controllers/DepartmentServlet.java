package com.example.webapphr1_2023.Controllers;

import com.example.webapphr1_2023.Beans.Department;
import com.example.webapphr1_2023.Beans.Employee;
import com.example.webapphr1_2023.Daos.DepartmentDao;
import com.example.webapphr1_2023.Daos.EmployeeDao;
import com.example.webapphr1_2023.Daos.JobDao;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;

@WebServlet(name = "DepartmentServlet", urlPatterns = {"/DepartmentServlet"})
public class DepartmentServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        String action = req.getParameter("action") == null? "list" : req.getParameter("action");


        JobDao jobDao = new JobDao();
        DepartmentDao departmentDao = new DepartmentDao();
        EmployeeDao employeeDao = new EmployeeDao();
        ArrayList<Employee> employeesList = employeeDao.listarEmpleadosOrdenadosPorNombre();
        ArrayList<Department> locationsList = departmentDao.locationsList();

        switch (action){
            case "list":
                req.setAttribute("departmentList", departmentDao.listarConNombres());
                req.setAttribute("departmentsNoDelete", departmentDao.departmentsNoDelete());
                req.getRequestDispatcher("department/list.jsp").forward(req, resp);
                break;

            case "edit":
                String idDepartment = req.getParameter("idDep");
                Department dep = departmentDao.buscarPorId(idDepartment);
                ArrayList<Employee> noManagerList = departmentDao.listNoManagerDepartments();

                req.setAttribute("locationsList", locationsList);
                req.setAttribute("employeesList", noManagerList);
                req.setAttribute("department", dep);
                req.getRequestDispatcher("department/editDepartment.jsp").forward(req,resp);
                break;

            case "new":
                ArrayList<Department> idsDepartments = departmentDao.lista();
                ArrayList<Employee> noManagerList2 = departmentDao.listNoManagerDepartments();
                req.setAttribute("idsDepartments",idsDepartments);
                req.setAttribute("locationsList", locationsList);
                req.setAttribute("employeesList", noManagerList2);
                req.getRequestDispatcher("department/newDepartment.jsp").forward(req,resp);
                break;

            case "delete":
                String idDepartment2 = req.getParameter("idDep");

                System.out.println("A eliminar: " + idDepartment2);
                departmentDao.deleteDepartment(idDepartment2);
                resp.sendRedirect(req.getContextPath()+ "/DepartmentServlet");
                break;



        }


    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {


        DepartmentDao departmentDao = new DepartmentDao();
        EmployeeDao employeeDao = new EmployeeDao();

        String action = req.getParameter("action") == null ? "edit" : req.getParameter("action");

        String idDep = req.getParameter("depId");
        String name = req.getParameter("departmentName");
        String manegerId = req.getParameter("managerId");
        String locationId = req.getParameter("locationId");

        switch (action){
            case "edit":

                System.out.println("idDep : " + idDep);
                System.out.println("nombre: "+ name);
                System.out.println("managerId: "+ manegerId);
                System.out.println("locationId: " + locationId);

                departmentDao.updateDepartment(name,manegerId,locationId,idDep);
                resp.sendRedirect(req.getContextPath()+ "/DepartmentServlet");
                break;


            case "new":

                System.out.println("idDep : " + idDep);
                System.out.println("nombre: "+ name);
                System.out.println("managerId: "+ manegerId);
                System.out.println("locationId: " + locationId);
                departmentDao.newDepartment(idDep, name, manegerId, locationId);
                resp.sendRedirect(req.getContextPath()+ "/DepartmentServlet");
                break;

        }






    }





}
