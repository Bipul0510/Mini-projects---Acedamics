--- PROBLEM STATEMENT - Hospital Management System Analytics ---

/*  SCOPE - The hospital administration team wants to improve operational efficiency and patient care quality by analyzing their existing
    hospital data. Currently, appointment management and patient tracking are done in spreadsheets, making it difficult to 
	identify bottlenecks, cancellations, and doctor workload distribution.              */

create database Analyticssept0325

use Analyticssept0325

select * from Appointment_Detail
select * from Doctor_Detail
select * from Medical_History
select * from Medicine_cost
select * from Patient_Appointment
select * from Patient_History
select * from Patient_Table

------------------------------------------------------------------------------------------------------------------------------------------------------------------


--(Q1) Appointments per doctor with rank (most to least busy) --

SELECT 
    d.DoctorID,
    CONCAT(d.Fname, ' ', d.Lname) as Doctor_Name,
    COUNT(a.AppointmentID) as Total_Appointments,
    RANK() OVER (ORDER BY COUNT(a.AppointmentID) DESC) as Doctor_Rank
FROM Doctor_Detail d
LEFT JOIN Appointment_Detail a 
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID,CONCAT(d.Fname, ' ', d.Lname)
ORDER BY Total_Appointments DESC;


--(Q2) Peak booking hours (by start time hour) --

SELECT 
    DATEPART(HOUR, a.Date) as Booking_Hour,
    COUNT(*) AS Total_Appointments
FROM Appointment_Detail a
GROUP BY DATEPART(HOUR, a.date)
ORDER BY Total_Appointments DESC;


--(Q3) Which doctor has the most appointments? --

SELECT	Top 1
    d.DoctorID,
    CONCAT(d.Fname, ' ', d.Lname) as Doctor_Name,
    COUNT(a.AppointmentID) as Total_Appointments
FROM Doctor_Detail d
JOIN Appointment_Detail a 
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID, CONCAT(d.Fname, ' ', d.Lname)
ORDER BY Total_Appointments DESC;

--(Q4) How many patients does each doctor treat? --

SELECT 
    d.DoctorID,
    CONCAT(d.Fname, ' ', d.Lname) as Doctor_Name,
    COUNT(DISTINCT a.PatientID) as Total_Patients
FROM Doctor_Detail d
JOIN Appointment_Detail a 
    ON d.DoctorID = a.DoctorID
GROUP BY d.DoctorID,CONCAT(d.Fname, ' ', d.Lname)
ORDER BY Total_Patients DESC;

--(Q5) Doctor–patient pairs with most interactions (top 10) --

SELECT TOP 10
    d.DoctorID,
    CONCAT(d.Fname, ' ', d.Lname) as Doctor_Name,
    p.PatientID,
    CONCAT(p.Fname, ' ', p.Lname) as Patient_Name,
    COUNT(a.AppointmentID) as Total_Interactions
FROM Appointment_Detail a
JOIN Doctor_Detail d 
    ON a.DoctorID = d.DoctorID
JOIN Patient_Table p 
    ON a.PatientID = p.PatientID
GROUP BY d.DoctorID, CONCAT(d.Fname, ' ', d.Lname), p.PatientID,CONCAT(p.Fname, ' ', p.Lname)
ORDER BY Total_Interactions DESC;


--(Q6) First and most recent visit per patient (with total visits) --

SELECT 
    p.PatientID,
    CONCAT(p.Fname, ' ', p.Lname) as Patient_Name,
    MIN(a.date) as First_Visit,
    MAX(a.date) as Most_Recent_Visit,
    COUNT(a.AppointmentID) as Total_Visits
FROM Patient_Table p
JOIN Appointment_Detail a 
    ON p.PatientID = a.PatientID
GROUP BY p.PatientID,CONCAT(p.Fname, ' ', p.Lname)
ORDER BY Most_Recent_Visit DESC;


-----------------------------------------------------------------------------------------------------------------------------------------------------------


















