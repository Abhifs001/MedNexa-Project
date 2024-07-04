--MEDISLOT  Database Schema Design Phase 1 : 
 --===================================Patients Table==================================================================
CREATE TABLE Patients (
    patientID INT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_patient PRIMARY KEY, -- Unique identifier for each patient
    FullName VARCHAR2(60) NOT NULL, -- Name of the patient
    Patient_Email Varchar2(50) UNIQUE NOT NULL, --patient email
    Patient_Phone_no VARCHAR2(15) UNIQUE NOT NULL, -- Contact phone number of the patient
    Patient_Password VARCHAR2(255) NOT NULL  --patient password 
);
commit;
--===================================Doctors Table==================================================================

 CREATE TABLE Doctors (
    DoctorID INT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_doctor PRIMARY KEY, -- Unique identifier for each doctor
    Doctor_Name VARCHAR2(50) NOT NULL, -- Name of the doctor
    Specialization VARCHAR2(30) NOT NULL, -- Specialization of the doctor
    Doctor_Email VARCHAR2(50) UNIQUE NOT NULL, --email of doctor 
    Doctor_Phone_no VARCHAR2(15) UNIQUE NOT NULL, -- Contact phone number of the doctor
    Doctor_Password VARCHAR2(255) NOT NULL
);
 --======================================DoctorSchedules---=========================================================
 CREATE TABLE DoctorSchedules (
    ScheduleID INT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_DoctorSchedule PRIMARY KEY,
    DoctorID INT NOT NULL,
    AvailableDate DATE NOT NULL,
    AvailableTime VARCHAR2(10) NOT NULL,
    BlockedTime VARCHAR2(15) NOT NULL,
    CONSTRAINT FK_DoctorSchedule_Doctor FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID), 
    CONSTRAINT UK_DoctorSchedule   UNIQUE(DoctorId, AvailableDate, AvailableTime)
);
--======================================Appointments==============================================================
 CREATE TABLE Appointments (
    AppointmentID INT GENERATED ALWAYS AS IDENTITY CONSTRAINT pk_appointements PRIMARY KEY, -- Unique identifier for each appointment
    PatientID INT NOT NULL, -- Foreign key referencing patientID in Patients table
    ScheduleID INT NOT NULL,
    Gender VARCHAR2(10) NOT NULL, -- Gender of the patient
    Age NUMBER(3) NOT NULL, --Age of the patient
    BloodGroup VARCHAR2(5) NOT NULL, -- Blood group of the patient
    Address VARCHAR2(255) NOT NULL, -- Address of the patient
    AppointmentDate date NOT NULL,
    AppointmentTime VARCHAR(10) NOT NULL, -- Preferred date and time for the appointment
    AppointmentReason VARCHAR2(255) NOT NULL, -- Reason for the appointment
    CONSTRAINT FK_Appointments_Patients FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    CONSTRAINT FK_Appointments_Schedule FOREIGN KEY (ScheduleID) REFERENCES DoctorSchedules(ScheduleID)
);
--============================TREATEMENT PLANS================================================================= 
CREATE TABLE TreatmentPlans (
    PlanID INT GENER ATED ALWAYS AS IDENTITY CONSTRAINT pk_TreatmentPlans PRIMARY KEY, -- Unique identifier for each treatment plan
    AppointmentID INT NOT NULL, -- Foreign key referencing AppointmentID in Appointments table
    Diagnosis VARCHAR2(255) NOT NULL, -- Diagnosis made by the doctor
    Treatment VARCHAR2(255) NOT NULL, -- Treatment plan prescribed by the doctor
    Prescription VARCHAR2(255) NOT NULL, -- Medication prescribed as part of the treatment plan
    NextAppointmentDate Date NOT NULL, -- Date and time of the next appointment scheduled for the patient
    NextAppointmentTime VARCHAR2(20) NOT NULL,
    CONSTRAINT FK_TreatmentPlans_Appointments FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

--============================================================================================================--=========================================
--============================================================================================================--=========================================

--PL/SQL Blocks for Medislot:
--==================================Package for Crud in Patients Table============================================================
-----------------------------Package Declaration 
-- Package for managing operations on the Patients table
CREATE OR REPLACE PACKAGE Patients_pkg AS
    -- Procedure to insert a new patient record
    PROCEDURE insert_patient(
        p_fullname IN Patients.FullName%TYPE,
        p_email IN Patients.Patient_Email%TYPE,
        p_phone_no IN Patients.Patient_Phone_no%TYPE,
        p_password IN Patients.Patient_Password%TYPE
    );
    
    -- Procedure to update an existing patient record
    PROCEDURE update_patient(
        p_patient_id IN Patients.patientID%TYPE,
        p_fullname IN Patients.FullName%TYPE,
        p_email IN Patients.Patient_Email%TYPE,
        p_phone_no IN Patients.Patient_Phone_no%TYPE,
        p_password IN Patients.Patient_Password%TYPE
    );
    
    -- Procedure to delete a patient record
    PROCEDURE delete_patient(
        p_patient_id IN Patients.patientID%TYPE
    );
END Patients_pkg;
/
---------------------------------------------------------------------Package Body--------------------------------------------------
-- Package body for managing operations on the Patients table
CREATE OR REPLACE PACKAGE BODY Patients_pkg AS
    -- Procedure to insert a new patient record
    PROCEDURE insert_patient(
        p_fullname IN Patients.FullName%TYPE,
        p_email IN Patients.Patient_Email%TYPE,
        p_phone_no IN Patients.Patient_Phone_no%TYPE,
        p_password IN Patients.Patient_Password%TYPE
    ) AS
    BEGIN
        INSERT INTO Patients (FullName, Patient_Email, Patient_Phone_no, Patient_Password)
        VALUES (p_fullname, p_email, p_phone_no, p_password);
    END insert_patient;
    
    -- Procedure to update an existing patient record
    PROCEDURE update_patient(
        p_patient_id IN Patients.patientID%TYPE,
        p_fullname IN Patients.FullName%TYPE,
        p_email IN Patients.Patient_Email%TYPE,
        p_phone_no IN Patients.Patient_Phone_no%TYPE,
        p_password IN Patients.Patient_Password%TYPE
    ) AS
    BEGIN
        UPDATE Patients
        SET FullName = p_fullname,
            Patient_Email = p_email,
            Patient_Phone_no = p_phone_no,
            Patient_Password = p_password
        WHERE patientID = p_patient_id;
    END update_patient;
    
    -- Procedure to delete a patient record
    PROCEDURE delete_patient(
        p_patient_id IN Patients.patientID%TYPE
    ) AS
    BEGIN
        DELETE FROM Patients
        WHERE patientID = p_patient_id;
    END delete_patient;
END Patients_pkg;
/
--=====================Package for Crud in Doctors Table=======================================================
---------package declaration---------------------------------------------------------------------------------------------------------------------------------
-- Package for managing operations on the Doctors table
CREATE OR REPLACE PACKAGE Doctors_pkg AS
    -- Procedure to insert a new doctor record
    PROCEDURE insert_doctor(
        p_name IN Doctors.Doctor_Name%TYPE,
        p_specialization IN Doctors.Specialization%TYPE,
        p_email IN Doctors.Doctor_Email%TYPE,
        p_phone_no IN Doctors.Doctor_Phone_no%TYPE,
        p_password IN Doctors.Doctor_Password%TYPE
    );
    
    -- Procedure to update an existing doctor record
    PROCEDURE update_doctor(
        p_doctor_id IN Doctors.DoctorID%TYPE,
        p_name IN Doctors.Doctor_Name%TYPE,
        p_specialization IN Doctors.Specialization%TYPE,
        p_email IN Doctors.Doctor_Email%TYPE,
        p_phone_no IN Doctors.Doctor_Phone_no%TYPE,
        p_password IN Doctors.Doctor_Password%TYPE
    );
    
    -- Procedure to delete a doctor record
    PROCEDURE delete_doctor(
        p_doctor_id IN Doctors.DoctorID%TYPE
    );
END Doctors_pkg;
/
---------package body ---------------------------------------------------------------------------------------------------------------------------------
-- Package body for managing operations on the Doctors table
CREATE OR REPLACE PACKAGE BODY Doctors_pkg AS
    -- Procedure to insert a new doctor record
    PROCEDURE insert_doctor(
        p_name IN Doctors.Doctor_Name%TYPE,
        p_specialization IN Doctors.Specialization%TYPE,
        p_email IN Doctors.Doctor_Email%TYPE,
        p_phone_no IN Doctors.Doctor_Phone_no%TYPE,
        p_password IN Doctors.Doctor_Password%TYPE
    ) AS
    BEGIN
        INSERT INTO Doctors (Doctor_Name, Specialization, Doctor_Email, Doctor_Phone_no, Doctor_Password)
        VALUES (p_name, p_specialization, p_email, p_phone_no, p_password);
    END insert_doctor;
    
    -- Procedure to update an existing doctor record
    PROCEDURE update_doctor(
        p_doctor_id IN Doctors.DoctorID%TYPE,
        p_name IN Doctors.Doctor_Name%TYPE,
        p_specialization IN Doctors.Specialization%TYPE,
        p_email IN Doctors.Doctor_Email%TYPE,
        p_phone_no IN Doctors.Doctor_Phone_no%TYPE,
        p_password IN Doctors.Doctor_Password%TYPE
    ) AS
    BEGIN
        UPDATE Doctors
        SET Doctor_Name = p_name,
            Specialization = p_specialization,
            Doctor_Email = p_email,
            Doctor_Phone_no = p_phone_no,
            Doctor_Password = p_password
        WHERE DoctorID = p_doctor_id;
    END update_doctor;
    
    -- Procedure to delete a doctor record
    PROCEDURE delete_doctor(
        p_doctor_id IN Doctors.DoctorID%TYPE
    ) AS
    BEGIN
        DELETE FROM Doctors
        WHERE DoctorID = p_doctor_id;
    END delete_doctor;
END Doctors_pkg;
/

--=====================Package for Crud in DoctorSchedules Table=======================================================
----------declaration --------------------------------------------------------------------------------------------------------------------------------
-- Package for managing operations on the DoctorSchedules table
CREATE OR REPLACE PACKAGE DoctorSchedules_pkg AS
    -- Procedure to insert a new doctor schedule
    PROCEDURE insert_schedule(
        p_doctor_id IN DoctorSchedules.DoctorID%TYPE,
        p_available_date IN DoctorSchedules.AvailableDate%TYPE,
        p_available_time IN DoctorSchedules.AvailableTime%TYPE,
        p_blocked_time IN DoctorSchedules.BlockedTime%TYPE
    );
    
    -- Procedure to update an existing doctor schedule
    PROCEDURE update_schedule(
        p_schedule_id IN DoctorSchedules.ScheduleID%TYPE,
        p_available_date IN DoctorSchedules.AvailableDate%TYPE,
        p_available_time IN DoctorSchedules.AvailableTime%TYPE,
        p_blocked_time IN DoctorSchedules.BlockedTime%TYPE
    );
    
    -- Procedure to delete a doctor schedule
    PROCEDURE delete_schedule(
        p_schedule_id IN DoctorSchedules.ScheduleID%TYPE
    );
END DoctorSchedules_pkg;
/

----------Body--------------------------------------------------------------------------------------------------------------------------------
-- Package body for managing operations on the DoctorSchedules table
CREATE OR REPLACE PACKAGE BODY DoctorSchedules_pkg AS
    -- Procedure to insert a new doctor schedule
    PROCEDURE insert_schedule(
        p_doctor_id IN DoctorSchedules.DoctorID%TYPE,
        p_available_date IN DoctorSchedules.AvailableDate%TYPE,
        p_available_time IN DoctorSchedules.AvailableTime%TYPE,
        p_blocked_time IN DoctorSchedules.BlockedTime%TYPE
    ) AS
    BEGIN
        INSERT INTO DoctorSchedules (DoctorID, AvailableDate, AvailableTime, BlockedTime)
        VALUES (p_doctor_id, p_available_date, p_available_time, p_blocked_time);
    END insert_schedule;
    
    -- Procedure to update an existing doctor schedule
    PROCEDURE update_schedule(
        p_schedule_id IN DoctorSchedules.ScheduleID%TYPE,
        p_available_date IN DoctorSchedules.AvailableDate%TYPE,
        p_available_time IN DoctorSchedules.AvailableTime%TYPE,
        p_blocked_time IN DoctorSchedules.BlockedTime%TYPE
    ) AS
    BEGIN
        UPDATE DoctorSchedules
        SET AvailableDate = p_available_date,
            AvailableTime = p_available_time,
            BlockedTime = p_blocked_time
        WHERE ScheduleID = p_schedule_id;
    END update_schedule;
    
    -- Procedure to delete a doctor schedule
    PROCEDURE delete_schedule(
        p_schedule_id IN DoctorSchedules.ScheduleID%TYPE
    ) AS
    BEGIN
        DELETE FROM DoctorSchedules
        WHERE ScheduleID = p_schedule_id;
    END delete_schedule;
END DoctorSchedules_pkg;
/
commit;
 --========================================================================================================

 
 
 --=====================Package for Crud in Appointments Table=======================================================
----------declaration --------------------------------------------------------------------------------------------------------------------------------
-- Package for managing operations on the Appointments table
CREATE OR REPLACE PACKAGE Appointments_pkg AS
    -- Procedure to insert a new appointment
    PROCEDURE insert_appointment(
        p_patient_id IN Appointments.PatientID%TYPE,
        p_schedule_id IN Appointments.ScheduleID%TYPE,
        p_gender IN Appointments.Gender%TYPE,
        p_age IN Appointments.Age%TYPE,
        p_blood_group IN Appointments.BloodGroup%TYPE,
        p_address IN Appointments.Address%TYPE,
        p_appointment_date IN Appointments.AppointmentDate%TYPE,
        p_appointment_time IN Appointments.AppointmentTime%TYPE,
        p_appointment_reason IN Appointments.AppointmentReason%TYPE
    );
    
    -- Procedure to update an existing appointment
    PROCEDURE update_appointment(
        p_appointment_id IN Appointments.AppointmentID%TYPE,
        p_patient_id IN Appointments.PatientID%TYPE,
        p_schedule_id IN Appointments.ScheduleID%TYPE,
        p_gender IN Appointments.Gender%TYPE,
        p_age IN Appointments.Age%TYPE,
        p_blood_group IN Appointments.BloodGroup%TYPE,
        p_address IN Appointments.Address%TYPE,
        p_appointment_date IN Appointments.AppointmentDate%TYPE,
        p_appointment_time IN Appointments.AppointmentTime%TYPE,
        p_appointment_reason IN Appointments.AppointmentReason%TYPE
    );
    
    -- Procedure to delete an appointment
    PROCEDURE delete_appointment(
        p_appointment_id IN Appointments.AppointmentID%TYPE
    );
END Appointments_pkg;
/
----------body--------------------------------------------------------------------------------------------------------------------------------
-- Package body for managing operations on the Appointments table
CREATE OR REPLACE PACKAGE BODY Appointments_pkg AS
    -- Procedure to insert a new appointment
    PROCEDURE insert_appointment(
        p_patient_id IN Appointments.PatientID%TYPE,
        p_schedule_id IN Appointments.ScheduleID%TYPE,
        p_gender IN Appointments.Gender%TYPE,
        p_age IN Appointments.Age%TYPE,
        p_blood_group IN Appointments.BloodGroup%TYPE,
        p_address IN Appointments.Address%TYPE,
        p_appointment_date IN Appointments.AppointmentDate%TYPE,
        p_appointment_time IN Appointments.AppointmentTime%TYPE,
        p_appointment_reason IN Appointments.AppointmentReason%TYPE
    ) AS
    BEGIN
        INSERT INTO Appointments (PatientID, ScheduleID, Gender, Age, BloodGroup, Address, AppointmentDate, AppointmentTime, AppointmentReason)
        VALUES (p_patient_id, p_schedule_id, p_gender, p_age, p_blood_group, p_address, p_appointment_date, p_appointment_time, p_appointment_reason);
    END insert_appointment;
    
    -- Procedure to update an existing appointment
    PROCEDURE update_appointment(
        p_appointment_id IN Appointments.AppointmentID%TYPE,
        p_patient_id IN Appointments.PatientID%TYPE,
        p_schedule_id IN Appointments.ScheduleID%TYPE,
        p_gender IN Appointments.Gender%TYPE,
        p_age IN Appointments.Age%TYPE,
        p_blood_group IN Appointments.BloodGroup%TYPE,
        p_address IN Appointments.Address%TYPE,
        p_appointment_date IN Appointments.AppointmentDate%TYPE,
        p_appointment_time IN Appointments.AppointmentTime%TYPE,
        p_appointment_reason IN Appointments.AppointmentReason%TYPE
    ) AS
    BEGIN
        UPDATE Appointments
        SET PatientID = p_patient_id,
            ScheduleID = p_schedule_id,
            Gender = p_gender,
            Age = p_age,
            BloodGroup = p_blood_group,
            Address = p_address,
            AppointmentDate = p_appointment_date,
            AppointmentTime = p_appointment_time,
            AppointmentReason = p_appointment_reason
        WHERE AppointmentID = p_appointment_id;
    END update_appointment;
    
    -- Procedure to delete an appointment
    PROCEDURE delete_appointment(
        p_appointment_id IN Appointments.AppointmentID%TYPE
    ) AS
    BEGIN
        DELETE FROM Appointments
        WHERE AppointmentID = p_appointment_id;
    END delete_appointment;
END Appointments_pkg;
/
commit;
--========================================================================================================

--=====================Package for Crud in TreatmentPlans Table=======================================================
----------Body --------------------------------------------------------------------------------------------------------------------------------
-- Package for managing operations on the TreatmentPlans table
CREATE OR REPLACE PACKAGE TreatmentPlans_pkg AS
    -- Procedure to insert a new treatment plan
    PROCEDURE insert_treatment_plan(
        p_appointment_id IN TreatmentPlans.AppointmentID%TYPE,
        p_diagnosis IN TreatmentPlans.Diagnosis%TYPE,
        p_treatment IN TreatmentPlans.Treatment%TYPE,
        p_prescription IN TreatmentPlans.Prescription%TYPE,
        p_next_appointment_date IN TreatmentPlans.NextAppointmentDate%TYPE,
        p_next_appointment_time IN TreatmentPlans.NextAppointmentTime%TYPE
    );
    
    -- Procedure to update an existing treatment plan
    PROCEDURE update_treatment_plan(
        p_plan_id IN TreatmentPlans.PlanID%TYPE,
        p_appointment_id IN TreatmentPlans.AppointmentID%TYPE,
        p_diagnosis IN TreatmentPlans.Diagnosis%TYPE,
        p_treatment IN TreatmentPlans.Treatment%TYPE,
        p_prescription IN TreatmentPlans.Prescription%TYPE,
        p_next_appointment_date IN TreatmentPlans.NextAppointmentDate%TYPE,
        p_next_appointment_time IN TreatmentPlans.NextAppointmentTime%TYPE
    );
    
    -- Procedure to delete a treatment plan
    PROCEDURE delete_treatment_plan(
        p_plan_id IN TreatmentPlans.PlanID%TYPE
    );
END TreatmentPlans_pkg;
/

----------Body--------------------------------------------------------------------------------------------------------------------------------
CREATE OR REPLACE PACKAGE BODY TreatmentPlans_pkg AS
    -- Procedure to insert a new treatment plan
    PROCEDURE insert_treatment_plan(
        p_appointment_id IN TreatmentPlans.AppointmentID%TYPE,
        p_diagnosis IN TreatmentPlans.Diagnosis%TYPE,
        p_treatment IN TreatmentPlans.Treatment%TYPE,
        p_prescription IN TreatmentPlans.Prescription%TYPE,
        p_next_appointment_date IN TreatmentPlans.NextAppointmentDate%TYPE,
        p_next_appointment_time IN TreatmentPlans.NextAppointmentTime%TYPE
    ) AS
    BEGIN
        INSERT INTO TreatmentPlans (AppointmentID, Diagnosis, Treatment, Prescription, NextAppointmentDate, NextAppointmentTime)
        VALUES (p_appointment_id, p_diagnosis, p_treatment, p_prescription, p_next_appointment_date, p_next_appointment_time);
    END insert_treatment_plan;
    
    -- Procedure to update an existing treatment plan
    PROCEDURE update_treatment_plan(
        p_plan_id IN TreatmentPlans.PlanID%TYPE,
        p_appointment_id IN TreatmentPlans.AppointmentID%TYPE,
        p_diagnosis IN TreatmentPlans.Diagnosis%TYPE,
        p_treatment IN TreatmentPlans.Treatment%TYPE,
        p_prescription IN TreatmentPlans.Prescription%TYPE,
        p_next_appointment_date IN TreatmentPlans.NextAppointmentDate%TYPE,
        p_next_appointment_time IN TreatmentPlans.NextAppointmentTime%TYPE
    ) AS
    BEGIN
        UPDATE TreatmentPlans
        SET AppointmentID = p_appointment_id,
            Diagnosis = p_diagnosis,
            Treatment = p_treatment,
            Prescription = p_prescription,
            NextAppointmentDate = p_next_appointment_date,
            NextAppointmentTime = p_next_appointment_time
        WHERE PlanID = p_plan_id;
    END update_treatment_plan;
    
    -- Procedure to delete a treatment plan
    PROCEDURE delete_treatment_plan(
        p_plan_id IN TreatmentPlans.PlanID%TYPE
    ) AS
    BEGIN
        DELETE FROM TreatmentPlans
        WHERE PlanID = p_plan_id;
    END delete_treatment_plan;
END TreatmentPlans_pkg;
/

commit;
--========================================================================================================



