package com.mediSlot.Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.List;

import org.json.JSONArray;

import com.mediSlot.dao.DoctorScheduleDao;
import com.mediSlot.util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/getAvailableDates")
public class GetAvailableDates extends HttpServlet {

	private static final long serialVersionUID = 1L;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		// Get the doctorId parameter from the request
		try {
			PrintWriter out = res.getWriter();
			int doctorId = Integer.parseInt(req.getParameter("doctorId"));

			DBConnection dbConnection = DBConnection.getDbConnection();
			DoctorScheduleDao doctorScheduleDao = new DoctorScheduleDao(dbConnection);
			List<Date> availableDates = doctorScheduleDao.findAllDate(doctorId);

			SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");

			JSONArray jsonDates = new JSONArray();
			for (Date date : availableDates) {
				String formattedDate = formatter.format(date);
				jsonDates.put(formattedDate);
			}

			// Convert the list of available times to JSON format
//			JSONArray jsonTimes = new JSONArray(availableDates);

			// Write the JSON array to the response
			out.print(jsonDates);
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
