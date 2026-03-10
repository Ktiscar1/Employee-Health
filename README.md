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

This table allow HR to look at the 111 employees that qualify as "Healthy"

What qualifies an employee as "Healthy"?
- No smoker
- No drinker
- BMI needs to be in a "healthy" range.
- The employee need to have less absences than the average absences from all employees.
