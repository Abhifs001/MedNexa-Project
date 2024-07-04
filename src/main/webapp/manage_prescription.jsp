<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page session="true"%>
<%@page import="com.mediSlot.model.*"%>
<%@page import="java.util.List"%>
<%@page import="com.mediSlot.dao.*"%>
<%@page import="com.mediSlot.util.DBConnection"%>
<%@page import="com.mediSlot.model.*"%>
<%@page import="com.mediSlot.service.*"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>MediSlot</title>
<link href="assets/image/icon.png" rel="icon">
<!-- Bootstrap CSS -->
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
}

h1 {
	text-align: center;
	margin-bottom: 30px;
	color: #2c3e50;
	text-shadow: 2px 2px 2px rgba(0, 0, 0, 0.1);
}

.table {
	width: 100%;
	border-collapse: collapse;
	border-radius: 12px;
	overflow: hidden;
	border: 2px solid #2c3e50;
}

.table th, .table td {
	padding: 20px;
	border-bottom: 1px solid #ddd;
	text-align: left;
	transition: background-color 0.3s ease;
}

.thead-blue {
	border-radius: 12px;
	background-color: #2b92ff;
	color: #fff;
}

.update-btn {
	padding: 5px 10px;
	border-radius: 15px;
	background-color: #2b92ff;
	color: #fff;
	border: none;
	cursor: pointer;
}

.update-btn:hover {
	background-color: #0056b3;
	color: #fff;
}

tbody tr:hover {
	background-color: #dbdbdb;
}
</style>
</head>
<body>
	<%
	try {
		// Retrieve the session

		// Retrieve the DoctorPhoneNo attribute from the session
		DBConnection dbConnection = DBConnection.getDbConnection();
		AppointmentDao appointmentDao = new AppointmentDao(dbConnection);
		AppointmentService appointmentService = new AppointmentService(appointmentDao);

		DoctorDao doctorDao = new DoctorDao(dbConnection);
		DoctorService doctorService = new DoctorService(doctorDao);

		String phoneNo = (String) session.getAttribute("phoneNo");
		Doctor doctor = doctorService.findByPhoneNo(phoneNo);
		int doctorID = doctor.getDoctorId();
		List<Appointment> appointments = appointmentService.findByDoctorId(doctorID);
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
		if (appointments != null && !appointments.isEmpty()) {
		%>
		<div class="row">
			<div class="col">
				<h2 align="center">Add Prescription</h2>
			</div>

		</div>
		<table class="table">
			<thead class="thead-blue">
				<tr>
					<th>Patient Name</th>
					<th>Appointment Date</th>
					<th>Appointment Time</th>
					<th>Appointment Reason</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				TreatmentPlanDao treatmentPlanDao = new TreatmentPlanDao(dbConnection);
				TreatmentPlanService treatmentPlanService = new TreatmentPlanService(treatmentPlanDao);

				for (Appointment appointment : appointments) {
					TreatmentPlan appointmentTreatment = treatmentPlanService.findByAppointmentId(appointment.getAppointmentID());
				%>
				<tr>
					<td><%=appointment.getPatient().getFullName()%></td>
					<td><%=appointment.getAppointmentDate()%></td>
					<td><%=appointment.getAppointmentTime()%></td>
					<td><%=appointment.getAppointmentReason()%></td>
					<td>
						<%
						if (appointmentTreatment == null) {
						%>
						<button class="update-btn"
							onclick="fillForm('<%=appointment.getAppointmentID()%>' , '<%=appointment.getPatient().getFullName()%>'  )"
							data-toggle="modal" data-target="#exampleModal">Add
							Prescription</button> <%
 } else {
 %> 					<a href="medical_history_for_one_patient.jsp?planID=<%=appointmentTreatment.getPlanId()%>"
						class="update-btn btn">See Prescription</a> <%
						
						
 }
 %>
					</td>
				</tr>
				<%
				}
				%>

			</tbody>
		</table>
		<%
		} else {
		%>
		<h1 style="color: #2b92ff; text-align: center">No Appointments
			for Prescription</h1>
		<%
		}
		} catch (Exception e) {
		response.sendRedirect("error.jsp");
		}
		%>
	</div>

	<!-- Modal for updating schedule -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Add
						Prescription</h5>

					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- Form for updating schedule -->
					<form action="addTreatmentPlan" id="treatmentForm">
						<div class="form-group">
							<label for="appointmentId">Appointment ID </label> <input
								type="text" class="form-control" id="appointmentId"
								name="appointmentId" readonly>
						</div>
						<div class="form-group">
							<label for="patientName">Patient Name </label> <input type="text"
								class="form-control" id="patientName" name="patientName"
								readonly>
						</div>

						<div class="form-group">
							<label for="diagnosis">Diagnosis</label> <input type="text"
								class="form-control" id="diagnosis" name="diagnosis">
						</div>
						<div class="form-group">
							<label for="treatment">Treatment</label> <input type="text"
								class="form-control" id="treatment" name="treatment">
						</div>

						<div class="form-group">
							<label for="prescription">Prescription</label> <input type="text"
								class="form-control" id="prescription" name="prescription">
						</div>

						<div class="form-group">
							<label for="nextAppointmentDate">Next Appointment Date</label> <input
								type="Date" class="form-control" id="nextAppointmentDate"
								name="nextAppointmentDate">
						</div>
						<div class="form-group">
							<label for="nextAppointmentTime">Next Appointment Time</label> <input
								type="text" class="form-control" id="nextAppointmentTime"
								pattern="^(0[1-9]|1[0-2]):[0-5][0-9] (AM|PM)$"
								name="nextAppointmentTime" placeholder="e.g 02:00 PM">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Add
								Treatmemt</button>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>

	<script>
		// Get current date in YYYY-MM-DD format
		let currentDate = new Date().toISOString().split('T')[0];

		// Set the minimum date attribute of the date input
		document.getElementById('nextAppointmentDate').min = currentDate;
	</script>

	<script>
		function fillForm(appointmentId, patientName) {
			// Set the values of the form fields
			document.getElementById('appointmentId').value = appointmentId;
			document.getElementById('patientName').value = patientName;
			document.getElementById('prescriptionPatientName').value = patientName

		}

		function submitForm() {
			document.getElementById('treatmentForm').submit();
		}
	</script>

	<!-- Bootstrap JS and jQuery -->
	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

</body>
</html>