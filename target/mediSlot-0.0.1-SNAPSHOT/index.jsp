<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>MediSlot - Your Health Partner</title>
    <link
      rel="stylesheet"
      href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
    />
    <style>
      /* Custom CSS styles */
      body {
        font-family: Arial, sans-serif;
      }

      .outBanner {
        background-color: #2b92ff;
        height: 300px;
        clip-path: polygon(
          30% 0%,
          70% 0%,
          100% 0,
          100% 100%,
          70% 95%,
          23% 100%,
          0 95%,
          0 0
        );
        display: flex;
        justify-content: center;
        align-items: center;
        margin-bottom: 30px;
        animation: fadeIn 2s ease; /* Fade-in animation */
      }

      .banner {
        color: rgb(255, 255, 255);
        font-family: cursive;
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

      .lead {
        font-size: 24px;
        margin-top: 20px;
        padding-left: 10px;
        animation: slideUp 1s ease; /* Slide-up animation */
      }

      .feature {
        background-color: #ffffff;
        padding: 20px 0;
      }

      .feature h2 {
        color: #007bff;
        animation: fadeInUp 1s ease; /* Fade-in and slide-up animation */
      }

      .feature p {
        font-size: 18px;
        line-height: 1.6;
        animation: fadeInUp 1s ease; /* Fade-in and slide-up animation */
      }

      .footer {
        background-color: #2b92ff;
        color: white;
        padding: 20px 0;
        margin-top: auto; /* Push to bottom */
        text-align: center;
        width: 100%;
      }

      /* Keyframes for animations */
      @keyframes fadeIn {
        from {
          opacity: 0;
        }
        to {
          opacity: 1;
        }
      }

      @keyframes slideUp {
        from {
          transform: translateY(100%);
          opacity: 0;
        }
        to {
          transform: translateY(0);
          opacity: 1;
        }
      }

      @keyframes fadeInUp {
        from {
          opacity: 0;
          transform: translateY(50px);
        }
        to {
          opacity: 1;
          transform: translateY(0);
        }
      }
    </style>
  </head>
  <body>
    <header>
      <nav class="navbar navbar-expand-lg navbar-light">
        <a class="navbar-brand" href="#" style="font-family:cursive;">MediSlot</a>
        <div class="container">
          <div class="navbar-collapse">
            <ul class="navbar-nav ml-auto">
              <li class="nav-item">
                <a class="nav-link" href="index.jsp">Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="patient_login.jsp">Patient Login</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="doctor_login.jsp">Doctor Login</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="about.jsp">About Us</a>
              </li>
            </ul> 
          </div>
        </div>
      </nav>
    </header>

    <div id="home" class="outBanner">
      <div class="banner">
        <h1>Welcome to MediSlot</h1>
        <p class="lead">Your trusted partner in healthcare</p>
      </div>
    </div>

    <div id="about" class="feature">
      <div class="container">
        <div class="row">
          <div class="col-lg-6" style="padding-top: 8px">
            <img
              src="assets/image/10-Best-Medical-Appointment-Scheduling-Software.jpg"
              alt="Our Services"
              class="img-fluid rounded"
            />
          </div>
          <div class="col-lg-6">
            <h2>Our Services</h2>
            <p style="text-align: justify">
              Welcome to MediSlot, your premier destination for seamless
              healthcare access. At MediSlot, we pride ourselves on
              revolutionizing the way you book appointments with healthcare
              professionals. Our comprehensive suite of services encompasses
              everything you need for convenient and efficient healthcare
              management.With MediSlot, you can say goodbye to long wait times
              and tedious phone calls. Our intuitive platform allows you to
              browse a wide range of healthcare providers, specialties, and
              appointment slots, all from the comfort of your own home.
            </p>
          </div>
        </div>
      </div>
    </div>

    <div id="services" class="feature">
      <div class="container">
        <div class="row">
          <div class="col-lg-6" style="padding-top: 15px">
            <h2>Appointment Booking</h2>
            <p style="text-align: justify">
              At MediSlot, we believe that access to quality healthcare should
              be effortless. That's why we've developed a cutting-edge
              appointment booking feature that puts you in control of your
              healthcare journey. Gone are the days of waiting on hold or
              struggling to find a suitable appointment time. With our
              user-friendly interface, booking appointments is as easy as 1-2-3.
              Simply log in to your account, select your preferred healthcare
              provider, and choose from a range of available appointment slots
              that fit your schedule.
            </p>
          </div>
          <div class="col-lg-6">
            <img
              src="assets/image/appointment-scheduling-solution.png"
              alt="Appointment Booking"
              class="img-fluid rounded"
            />
          </div>
        </div>
      </div>
    </div>

    <div class="footer">
      <div class="container" style="display: flex; justify-content: center">
        <span>&copy; 2024 MediSlot. All rights reserved.</span>
      </div>
    </div>
  </body>
</html>
