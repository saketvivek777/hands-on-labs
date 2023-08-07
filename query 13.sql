-- call get_doctor_info(150);
call get_doctor_info(@records);
select @records as totalrecord;

create trigger patient_trig
before insert
on patient
for each row
set new.height=new.height+2;
drop trigger patient_trig;

select * from patient;
INSERT INTO patient (patient_id, doctor_id, patient_name, gender, date_of_birth, contact, age, blood_group, height)
VALUES
    (308923, 145234, 'John Doe', 'Male', '1990-05-15', '+1 (123) 456-7890', '32', 'A+', 175);




-- Query to get the list of all patients who have an appointment with a specific doctor on a specific date.
-- SQL
SELECT patient.patient_id, patient.patient_name
FROM patient
JOIN appointment_history ON patient.patient_id = appointment_history.patient_id
JOIN doctors ON appointment_history.doctor_id = doctors.doctor_id
WHERE doctors.doctor_id = 1008 AND time = '2023-07-26 10:10:00';
 
-- Query to get the list of all appointments for a specific patient.
-- SQL
SELECT appointment_id, appointment_date, appointment_time
FROM appointment
WHERE patient_id = 3001;
 
-- Query to get the list of all doctors who are available on a specific date and time.
-- SQL
SELECT doctor_id, first_name, last_name, specialty
FROM doctor
WHERE doctor_id NOT IN (
    SELECT doctor_id
    FROM appointment
    WHERE appointment_date = '2023-08-25'
);
 
-- Query to get the list of all patients who have not had an appointment in the past 6 months.
-- SQL
SELECT patient_id, first_name, last_name
FROM patient
WHERE patient_id NOT IN (
    SELECT patient_id
    FROM appointment
    WHERE appointment_date > CURRENT_DATE - INTERVAL 6 MONTH
);
 
-- Query to get the list of all patients who have seen a specific doctor more than once.
-- SQL
 SELECT patient_id, first_name, last_name
FROM patient
JOIN appointment_history ON patient.patient_id = appointment_history.patient_id
GROUP BY patient_id
HAVING COUNT(*) > 1
WHERE doctor_id = 1001;

 



-- Query to get the list of all patients who have been prescribed a specific medication.
-- SQL
SELECT patient_id, first_name, last_name
FROM patient
JOIN prescription ON patient.patient_id = prescription.patient_id
JOIN medication ON prescription.medication_id = medication.medication_id
WHERE medication.name = 'Advil';
 
-- Query to get the list of all medications that have been prescribed to more than 100 patients.
-- SQL
SELECT medication_id, name, COUNT(*) AS number_of_prescriptions
FROM prescription
GROUP BY medication_id
HAVING COUNT(*) > 100;
 
-- Query to get the list of all doctors who have prescribed more than the average number of medications.
-- SQL
SELECT doctor_id, first_name, last_name, COUNT(*) AS number_of_prescriptions
FROM prescription
GROUP BY doctor_id
HAVING COUNT(*) > (
    SELECT AVG(number_of_prescriptions)
    FROM prescription
);
Use code with caution. Learn more
Query to get the list of all patients who have been prescribed a medication that is not in stock.
SQL
SELECT patient_id, first_name, last_name, medication_name
FROM prescription
JOIN medication ON prescription.medication_id = medication.medication_id
WHERE medication.in_stock = 0;
 
Query to get the list of all medications that have been prescribed more often in the past 6 months than in the previous 6 months.
SQL
SELECT medication_id, name,
    (
        SELECT COUNT(*)
        FROM prescription
        WHERE appointment_date > CURRENT_DATE - INTERVAL 6 MONTH
    ) AS number_of_prescriptions_past_6_months,
    (
        SELECT COUNT(*)
        FROM prescription
        WHERE appointment_date < CURRENT_DATE - INTERVAL 6 MONTH
    ) AS number_of_prescriptions_previous_6_months
FROM prescription
GROUP BY medication_id
HAVING number_of_prescriptions_past_6_months > number_of_prescriptions_previous_6_months;

Query to get the list of all patients who have been prescribed a medication that is more expensive than the average medication.
SQL
SELECT patient_id, first_name, last_name, medication_name,
    (
        SELECT AVG(price)
        FROM medication
    ) AS average_medication_price
FROM prescription
JOIN medication ON prescription.medication_id = medication.medication_id
WHERE price > average_medication_price;
 
Query to get the list of all doctors who have prescribed more than the average number of medications for a specific condition.
SQL
SELECT doctor_id, first_name, last_name, condition,
    (
        SELECT COUNT(*)
        FROM prescription
        WHERE condition = 'Asthma'
    ) AS number_of_asthma_prescriptions
FROM prescription
JOIN medication ON prescription.medication_id = medication.medication_id
JOIN condition ON medication.condition_id = condition.condition_id
GROUP BY doctor_id
HAVING number_of_asthma_prescriptions > (
    SELECT AVG(number_of_asthma_prescriptions)
    FROM prescription
    WHERE condition = 'Asthma'
);
 
-- Query to get the list of all patients who have been prescribed a medication for a specific condition and have not seen a doctor in the past 6 months.
-- SQL
SELECT patient_id, first_name, last_name, condition
FROM prescription
JOIN medication ON prescription.medication_id = medication.medication_id
JOIN condition ON medication.condition_id = condition.condition_id
JOIN appointment ON prescription.patient_id = appointment.patient_id
WHERE condition = 'Asthma' AND appointment_date < CURRENT_DATE - INTERVAL 6 MONTH;
 
-- Query to get the list of all medications that have been prescribed more often to patients over the age of 65 than to patients under the age of 65.
-- SQL
SELECT medication_id, name,
    (
        SELECT COUNT(*)
        FROM prescription
        WHERE patient_age >= 65
    ) AS number_of_prescriptions_over_65,
    (
        SELECT COUNT(*)
        FROM prescription
        WHERE patient_age < 65
    ) AS number_of_prescriptions_under_65
FROM prescription
GROUP BY medication_id
HAVING number_of_prescriptions_over_65 > number_of_prescriptions_under_65;
 
-- Query to get the list of all doctors who have prescribed more than the average number of medications to patients who are insured.
-- SQL
SELECT doctor_id, first_name, last_name,
    (
        SELECT COUNT(*)
        FROM prescription
        WHERE patient_is_insured = 1
    ) AS number_of_insured_prescriptions
FROM prescription
JOIN patient ON prescription.patient_id = patient.patient_id
GROUP BY doctor_id
HAVING number_of_insured_prescriptions > (
    SELECT AVG(number_of_insured_prescriptions)
    FROM prescription
    WHERE patient_is_insured = 1
);


