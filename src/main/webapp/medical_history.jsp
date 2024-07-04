<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page session="true"%>

<%@page import="java.util.List"%>
<%@page import="com.mediSlot.dao.*"%>
<%@page import="com.mediSlot.util.DBConnection"%>
<%@page import="com.mediSlot.model.*"%>
<%@page import="com.mediSlot.service.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>MediSlot</title>
<link href="assets/image/icon.png" rel="icon">
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<style>
body {
	font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
	margin: 0;
	padding: 0;
	background-color: #f7f7f7;
}

.navbar {
	background-color: #2b92ff;
	height: 55px;
	border-bottom: 2px solid #93c7ff;
}

.navbar-brand {
	font-size: 35px;
	font-weight: bold;
	color: #ffffff !important;
	justify-content: left;
	align-content: center;
}

.navbar-nav .nav-link {
	font-size: 15px;
	color: #ffffff !important;
	border: 1px solid rgb(242, 242, 242); /* Add border */
	border-radius: 0.6rem;
	padding: 0.2rem; /* Add padding */
	margin: 1rem;
	transition: transform 0.3s ease; /* Smooth transition on hover */
}

.navbar-nav .nav-link:hover {
	border-color: rgba(56, 75, 179, 0.5); /* Change border color on hover */
	transform: translateY(-3px); /* Move link up slightly */
}

.container {
	background-color: #ffffff;
	margin-top: 20px;
	padding: 20px;
	border-radius: 12px;
	box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
	overflow-x: auto;
}

h1 {
	text-align: center;
	margin-bottom: 30px;
	color: #2c3e50;
	text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1);
}

table {
	width: 100%;
	border-collapse: collapse;
	border-radius: 12px;
	overflow: hidden;
	border: 2px solid #2c3e50;
}

th, td {
	padding: 20px;
	border-bottom: 1px solid #ddd;
	text-align: left;
	transition: background-color 0.3s ease;
}

th {
	background-color: #2b92ff;
	color: white;
}

tr:nth-child(even) {
	background-color: #f2f2f2;
}

tr:hover {
	background-color: #dbdbdb;
}
</style>
</head>
<body>
	<%
	try {
		DBConnection dbConnection = DBConnection.getDbConnection();

		TreatmentPlanDao treatmentPlanDao = new TreatmentPlanDao(dbConnection);
		TreatmentPlanService treatmentPlanService = new TreatmentPlanService(treatmentPlanDao);

		DoctorDao doctorDao = new DoctorDao(dbConnection);
		DoctorService doctorService = new DoctorService(doctorDao);

		String phoneNo = (String) session.getAttribute("phoneNo");
		Doctor doctor = doctorService.findByPhoneNo(phoneNo);
		int doctorID = doctor.getDoctorId();

		List<TreatmentPlan> treatmentPlans = treatmentPlanService.findAllRecordByDoctorId(doctorID);
	%>

	<header>
		<nav class="navbar navbar-expand-lg navbar-light">
			<p class="navbar-brand"
				style="font-family: cursive; margin-top: 16px">MediSlot</p>
			<div class="navbar-collapse">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item nav-link"
						style="border: 0px; font-weight: bolder; font-size: 1.2rem;">Welcome!
						<%=doctor.getDoctorName()%></li>
					<li class="nav-item"><a class="nav-link"
						href="doctor_dashboard.jsp">Go To Dashboard</a></li>
				</ul>
			</div>
		</nav>
	</header>

	<div class="container">
		<%
		if (treatmentPlans != null) {
		%>
		<h1 align="center">Medical History</h1>
		<table>
			<thead>
				<tr>
					<th>Patient Name</th>
					<th>Diagnosis Date</th>
					<th>Medical Condition</th>
					<th>Treatment</th>
					<th>Prescription</th>
					<th>Next Appointment</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (TreatmentPlan treatmentPlan : treatmentPlans) {
				%>
				<tr>
					<td><%=treatmentPlan.getAppointment().getPatient().getFullName()%></td>
					<td><%=treatmentPlan.getAppointment().getAppointmentDate()%></td>
					<td><%=treatmentPlan.getDiagnosis()%></td>
					<td><%=treatmentPlan.getTreatment()%></td>
					<td><%=treatmentPlan.getPrescription()%></td>
					<td><%=treatmentPlan.getNextAppointmentDate()%></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
		<%
		} else {
		%>
		<h1 style="color: #2b92ff; text-align: center">YOU NOT HAVE ANY
			MEDICAL RECORD</h1>
		<%
		}
		} catch (Exception e) {
		response.sendRedirect("error.jsp");
		}
		%>
	</div>

</body>
</html>