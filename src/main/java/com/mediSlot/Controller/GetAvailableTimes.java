package com.mediSlot.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.util.List;

import org.json.JSONArray;

import com.mediSlot.dao.DoctorScheduleDao;
import com.mediSlot.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/getAvailableTimes")
public class GetAvailableTimes extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// Get the doctorId parameter from the request
		try {
			PrintWriter out = res.getWriter();
			int doctorId = Integer.parseInt(req.getParameter("doctorId"));
			String preferredDate = req.getParameter("preferredDate");
			Date appDate = Date.valueOf(preferredDate); 
			System.out.println(appDate);
			DBConnection dbConnection = DBConnection.getDbConnection();
			DoctorScheduleDao doctorScheduleDao = new DoctorScheduleDao(dbConnection);
			List<String> availableTimes = doctorScheduleDao.findAllTime(doctorId, appDate);
			System.out.println(availableTimes);

			// Convert the list of available times to JSON format
			JSONArray jsonTimes = new JSONArray(availableTimes);

			// Write the JSON array to the response
			out.print(jsonTimes);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
