<!DOCTYPE html>
<%@page import="com.mediSlot.Service.DoctorService"%>
<%@page import="com.mediSlot.dao.DoctorDao"%>
<%@page import="com.mediSlot.model.Doctor"%>
<%@page import="com.mediSlot.model.DoctorSchedule"%>
<%@page import="java.util.List"%>
<%@page import="com.mediSlot.dao.DoctorScheduleDao"%>
<%@page import="com.mediSlot.util.DBConnection"%>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Schedule Table</title>
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

.container {
	width: 95%;
	max-width: 1200px;
	margin: 20px auto;
}

.table {
	background-color: #fff;
	border-radius: 12px;
}

.table th, .table td {
	padding: 15px;
	text-align: center;
}

.thead-blue {
	background-color: #2b92ff;
	color: #fff;
}

.update-btn {
	padding: 5px 10px;
	border-radius: 5px;
	background-color: #2b92ff;
	color: #fff;
	border: none;
	cursor: pointer;
	transition: background-color 0.3s;
}

.update-btn:hover {
	background-color: #0056b3;
}

.modal-content {
	animation: fadeIn 0.3s ease;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-20px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body>
	<%
	String phoneNo = (String) session.getAttribute("phoneNo");
	DBConnection dbConnection = DBConnection.getDbConnection();
	DoctorDao doctorDao = new DoctorDao(dbConnection);
	DoctorService doctorService = new DoctorService(doctorDao);
	Doctor doctor = doctorService.findByPhoneNo(phoneNo);

	int doctorId = doctor.getDoctorId();
	session.setAttribute("scheduledDoctorId", doctorId);
	DoctorScheduleDao doctorScheduleDao = new DoctorScheduleDao(dbConnection);

	List<DoctorSchedule> doctorSchedules = doctorScheduleDao.findAllDoctorSchedulesById(doctorId);
	%>
	<div class="container">
		<%
		if (doctorSchedules != null) {
		%>
		<table class="table">
			<thead class="thead-blue">
				<tr>
					<th>Schedule Date</th>
					<th>Schedule Time</th>
					<th>Status</th>
					<th>Action</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (DoctorSchedule doctorSchedule : doctorSchedules) {
					if (doctorSchedule.getBlockedTime().equals("Available")) {
				%>
				<tr>
					<td><%=doctorSchedule.getAvailableDate()%></td>
					<td><%=doctorSchedule.getAvailableTime()%></td>
					<td><%=doctorSchedule.getBlockedTime()%></td>
					<td><button class="update-btn"
							onclick="fillForm('<%=doctorSchedule.getAvailableDate()%>', '<%=doctorSchedule.getAvailableTime()%>', '<%=doctorSchedule.getBlockedTime()%>')"
							data-toggle="modal" data-target="#exampleModal">Update</button></td>

				</tr>
				<%
				}
				}
				%>
			</tbody>
		</table>
		<%
		} else {
		%>
		<h1 style="color: #2b92ff; text-align: center">YOU NOT HAVE ANY
			SCHEDULE</h1>
		<%
		}
		%>
	</div>

	<!-- Modal for updating schedule -->
	<div class="modal fade" id="exampleModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Update Schedule</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<!-- Form for updating schedule -->
					<form action="updateDoctorSchedule" method=post>
						<div class="form-group">
							<label for="scheduleDate">Schedule Date:</label> <input
								type="date" class="form-control" id="scheduleDate"
								name="scheduleDate">
						</div>
						<div class="form-group">
							<label for="scheduleTime">Schedule Time:</label> <input
								type="text" class="form-control" id="scheduleTime"
								name="scheduleTime">
						</div>
						<div class="form-group">
							<label for="status">Status:</label> <select class="form-control"
								id="status" name="status">
								<option value="Blocked">Blocked</option>
							</select>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-dismiss="modal">Close</button>
							<button type="submit" class="btn btn-primary">Save
								changes</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- Bootstrap JS and jQuery -->
	<script>
		// Function to fill the modal form with schedule data
		function fillForm(scheduleDate, scheduleTime, status) {
			document.getElementById('scheduleDate').value = scheduleDate;
			document.getElementById('scheduleTime').value = scheduleTime;
			document.getElementById('status').value = status;
		}
	</script>

	<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
