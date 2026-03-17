# Employee-Health
Data driven evaluation to determine bonus and incentives for healthy employees. (Placeholder)

# Goals

* Provide a list of *Healty Individuals & Low Absenteeism* for healthy bonus programn.
* Calculate a *Wage Increase* or annual compensation for non-smokers.
    * Insurance Budget of $983,221 for all non-smoker.
* Dashboard for HR to understand Absenteeism at work based on approved wireframe.

# Steps (PlaceHolder)

Using SQL Sever Managment import flat files (Absenteeism_at_work, compensation & Reasons). *NOTE: REFRESH WHEN ADDING TABLES - ctrl + Shift + R*
Connect tables using SQL querries.
1. Connect Absenteeism_at_work with compensation using left join (ID)
2. Join Reasons
3. Create a table that allows HR to see "Healthiest Employees"

# 1. Connect Absenteeism_at_work with compensation using left join (ID)

``` SQL
SELECT * FROM Absenteeism_at_work a
LEFT JOIN compensation b
```
<img width="1646" height="627" alt="image" src="https://github.com/user-attachments/assets/3e2b6004-0cbc-47dd-898f-37ff494944f8" />

The SQL querry allow to visualize the merge between table "Absenteeism_at_work" and table "compensation" were the rows for ID in both are matched.

# 2. Join Reasons

``` SQL
SELECT * FROM Absenteeism_at_work a
LEFT JOIN compensation b
ON a.ID  = b.ID
LEFT JOIN Reasons r ON
a.Reason_for_absence = r.Number;
```
<img width="1658" height="636" alt="image" src="https://github.com/user-attachments/assets/13840fd4-1587-4100-8a0e-310a18c0ede5" />

Now the "reasons" table is added to the mix under the condition that the reason of absence matches the number (numeral representation of absence reason like "Unkown," "Neoplasms," "Mental and behavioural disorders," among others)

# 3. Create a table that allows HR to see "Healthiest Employees"
``` SQL
SELECT * FROM Absenteeism_at_work
WHERE Social_drinker = 0 AND Social_smoker = 0
AND Body_mass_index < 25 
AND Absenteeism_time_in_hours < (SELECT Avg(Absenteeism_time_in_hours) From Absenteeism_at_work)
```

<img width="1664" height="664" alt="image" src="https://github.com/user-attachments/assets/1d1a6918-07e1-43dd-8061-8a4e7b40c629" />


This table allow HR to look at the 111 employees that qualify as "Healthy"

** What qualifies an employee as "Healthy"? **
- No smoker.
- No drinker.
- BMI needs to be in a "healthy" range.
- The employee need to have less absences than the average absences from all employees.

----------------------------------------------------------------------------------------------

- Budget = $938,211.
- 111 employes qualify as "healthy."
- 686 non smokers.

- 0.6575262110338641 increase per hour = $938,211 budget / 1,426,880.
- 1,426,880 = 2,080 hours in a year x 686 employees.
- 2,080 hours in a year that 686 employees worked = 40 hours a week x 52 weeks in a year.
- 40 hours a week = 8 hours x 5 days a week.

This a yearly amount is a total of $1,414.4 per employee.

----------------------------------------------------------------------------------------------

# Query optimization:

A query optimization is done to display HR only relevant information to their department:
 - Only relkevant columns are displayed. 
 - A new column 'BMI_Category' is created categorizing in a 'readable' manner the information.
 - A new column 'Season_Names' is created to categorized the seasons.

```SQL
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
```

<img width="1770" height="548" alt="image" src="https://github.com/user-attachments/assets/7afb4a0e-4714-47b4-b0d9-cdc72d3ae20f" />


