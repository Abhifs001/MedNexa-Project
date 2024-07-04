<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Patient Dashboard</title>
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" />
<style>
/* Custom CSS styles */
body {
	font-family: Arial, sans-serif;
	display: flex;
	flex-direction: column;
	min-height: 100vh;
	background-color: #f8f9fa;
	animation: fadeIn 1s ease;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

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

.feature {
	background-color: #ffffff;
	padding: 20px;
	flex-grow: 1; /* Fill remaining space */
	display: flex;
	justify-content: center; /* Center horizontally */
	align-items: center; /* Center vertically */
	flex-direction: column; /* Stack items vertically */
	border-radius: 10px;
	box-shadow: 0px 0px 10px rgba(0, 0, 0, 0.1);
	margin: 20px;
	animation: fadeInUp 1s ease; /* Fade-in and slide-up animation */
}

.feature h2 {
	color: #007bff;
}

.feature p {
	font-size: 18px;
	line-height: 1.6;
}

.btn-primary {
	background-color: #007bff;
	border-color: #007bff;
	transition: all 0.3s ease;
}

.btn-primary:hover {
	background-color: #0056b3;
	border-color: #0056b3;
	transform: scale(1.05);
}

/* Keyframes for animations */
@
keyframes fadeInUp {from { opacity:0;
	transform: translateY(50px);
}

to {
	opacity: 1;
	transform: translateY(0);
}

}
.footer {
	background-color: #2b92ff;
	padding: 20px 0;
	margin-top: auto; /* Push to bottom */
	text-align: center;
	width: 100%;
}

.footer span {
	color: #ffffff;
}
</style>
</head>
<body>
	<header>
		<nav class="navbar navbar-expand-lg navbar-light">
			<a class="navbar-brand" href="#" style="font-family: cursive;">MediSlot</a>
			<div class="container">
				<div class="navbar-collapse">
					<ul class="navbar-nav ml-auto">
						<li class="nav-item"><a class="nav-link" href="logout">LOGOUT</a></li>
					</ul>
				</div>
			</div>
		</nav>
	</header>

	<div id="appointment" class="feature">
		<div class="container">
			<div class="row">
				<div class="col-lg-12" style="text-align: center">
					<h2>Book an Appointment</h2>
					<p>Ready to schedule your appointment? Click below to book now!</p>
					<a href="appointment.jsp" class="btn btn-primary">Book
						Appointment</a>
				</div>
			</div>
		</div>
	</div>

	<div id="upcoming-appointments" class="feature">
		<div class="container">
			<div class="row">
				<div class="col-lg-12" style="text-align: center">
					<h2>Upcoming Appointments</h2>
					<%
					String noApp = (String) session.getAttribute("checkApp");
					if (noApp == null) {
					%><p>No upcoming appointments</p>
					<%
					} else {
					%>
					<p><%=noApp%></p>

					<%
					session.removeAttribute("checkApp");
					}
					%>
				</div>
			</div>
		</div>
	</div>

	<div id="medical-records" class="feature">
		<div class="container">
			<div class="row">
				<div class="col-lg-12" style="text-align: center">
					<h2>Medical Records</h2>
					<p>No medical records available</p>
				</div>
			</div>
		</div>
	</div>

	<div class="footer">
		<div class="container">
			<span>&copy; 2024 MediSlot. All rights reserved.</span>
		</div>
	</div>
</body>
</html>