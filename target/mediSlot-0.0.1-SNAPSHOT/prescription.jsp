<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Prescription Form</title>
<!-- Bootstrap CSS -->
<link
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	rel="stylesheet" />
<!-- Custom CSS -->
<style>
body {
	background-color: #f4f4f4;
	font-family: Arial, sans-serif;
}

.container {
	max-width: 400px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 10px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
	animation: fadeIn 1s ease;
}

@
keyframes fadeIn {from { opacity:0;
	
}

to {
	opacity: 1;
}

}
h2 {
	text-align: center;
	margin-bottom: 20px;
	color: #007bff;
}

label {
	font-weight: bold;
	color: #007bff;
}

input[type="text"], input[type="date"], input[type="time"], textarea {
	width: calc(100% - 22px);
	padding: 10px;
	margin-bottom: 20px;
	border: 1px solid #ccc;
	border-radius: 5px;
	box-sizing: border-box;
	animation: slideIn 1s ease;
}

@
keyframes slideIn {from { transform:translateY(-50px);
	opacity: 0;
}

to {
	transform: translateY(0);
	opacity: 1;
}

}
input[type="submit"] {
	background-color: #007bff;
	color: #fff;
	border: none;
	padding: 10px 20px;
	border-radius: 5px;
	cursor: pointer;
	font-size: 16px;
	transition: background-color 0.3s ease;
}

input[type="submit"]:hover {
	background-color: #0056b3;
}
</style>
</head>
<body>
	<div class="container">
		<h2>Prescription Form</h2>
		<form action="#" method="post">
			<div class="form-group">
				<label for="diagnosis">Diagnosis:</label> <input type="text"
					id="diagnosis" name="diagnosis" required>
			</div>
			<div class="form-group">
				<label for="treatment">Treatment:</label>
				<textarea id="treatment" name="treatment" rows="3" required></textarea>
			</div>
			<div class="form-group">
				<label for="medication">Medication Prescription:</label>
				<textarea id="medication" name="medication" rows="3" required></textarea>
			</div>
			<div class="form-group">
				<label for="next_appointment_date">Next Appointment Date:</label> <input
					type="date" id="next_appointment_date" name="next_appointment_date"
					required>
			</div>
			<div class="form-group">
				<label for="next_appointment_time">Next Appointment Time:</label> <input
					type="time" id="next_appointment_time" name="next_appointment_time"
					required>
			</div>
			<input type="submit" value="Submit Prescription">
		</form>
	</div>
</body>
</html>
