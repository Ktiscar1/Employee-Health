--Basic Join Table
SELECT * FROM Absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID = b.ID

--create a join table
SELECT * FROM Absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID  = b.ID
LEFT JOIN Reasons r ON
a.Reason_for_absence = r.Number;

--Healthiest (No smoke, No Drink, Less Absences)
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25 
AND Absenteeism_time_in_hours < (SELECT Avg(Absenteeism_time_in_hours) From Absenteeism_at_work)

--Increase for non-smokers (Compensation rate increase - $983,211)
SELECT COUNT(*) AS nonsmoker FROM Absenteeism_at_work
WHERE Social_smoker = 0

--Query Optimization
SELECT 
a.ID, r.Reason, Month_of_absence, body_mass_index,
CASE WHEN Body_mass_index < 18.5 THEN 'Underweight'
	WHEN Body_mass_index BETWEEN 18.5 AND 25 THEN 'Healthy weight'
	WHEN Body_mass_index BETWEEN 25 AND 30 THEN 'Overweight'
	WHEN Body_mass_index > 30 THEN 'Obese'
	ELSE 'Unkown' END AS BMI_Category,
CASE WHEN Month_of_absence IN (12,1,2) THEN 'Winter'
	WHEN Month_of_absence IN (3,4,5) THEN 'Spring'
	WHEN Month_of_absence IN (6,7,8) THEN 'Summer'
	WHEN Month_of_absence IN (9,10,11) THEN 'Fall'
	ELSE 'Unkown' END AS Season_Names,
Month_of_absence, Day_of_the_week, Transportation_expense, Education,
Son, Social_drinker, Social_smoker, Pet, Disciplinary_failure, Age,
Work_load_Average_day, Absenteeism_time_in_hours
FROM Absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID = b.ID
LEFT JOIN Reasons r ON
a.Reason_for_absence = r.Number