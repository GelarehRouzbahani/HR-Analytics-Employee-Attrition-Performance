create database People_Turnover;
---- import the dataset---

use People_Turnover; ---for using the dataset---

select*from Churns ---for retrieving data from the databse---

EXEC sp_columns Churns; ---for describing the datatype and other information of database--


-------Preprocessing----------------

UPDATE Churns SET EnvironmentSatisfaction= IIF(EnvironmentSatisfaction= 1, 'Low',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Low,Medium,Satisfaied and Highly-Satisfied------
       IIF(EnvironmentSatisfaction =2, 'Medium',
           IIF(EnvironmentSatisfaction=3, 'Satisfied',
               IIF(EnvironmentSatisfaction=4, 'Highly-Satisfied',null))))

select*from Churns ---for retrieving the updating data from the databse---


UPDATE Churns SET  JobInvolvement= IIF( JobInvolvement= 1, 'Low',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Low,Medium,Involved and Highly-Involved------
       IIF( JobInvolvement =2, 'Medium',
           IIF( JobInvolvement=3, 'Involved',
               IIF( JobInvolvement=4, 'Highly-Involved',null))))

select*from Churns ---for retrieving the updating data from the databse---


UPDATE Churns SET  JobSatisfaction= IIF( JobSatisfaction= 1, 'Low',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Low,Medium,Satisfaied and Highly-Satisfied------
       IIF( JobSatisfaction =2, 'Medium',
           IIF( JobSatisfaction=3, 'Satisfied',
               IIF( JobSatisfaction=4, 'Highly-Satisfied',null))))

select*from Churns ---for retrieving the updating data from the databse---


UPDATE Churns SET  RelationshipSatisfaction= IIF( RelationshipSatisfaction= 1, 'Low',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Low,Medium,Satisfaied and Highly-Satisfied------
       IIF( RelationshipSatisfaction =2, 'Medium',
           IIF( RelationshipSatisfaction=3, 'Satisfied',
               IIF( RelationshipSatisfaction=4, 'Highly-Satisfied',null))))

select*from Churns ---for retrieving the updating data from the databse---


UPDATE Churns SET  WorkLifeBalance= IIF( WorkLifeBalance= 1, 'Low',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Low,Moderate,Good and Well------
       IIF( WorkLifeBalance =2, 'Moderate',
           IIF( WorkLifeBalance=3, 'Good',
               IIF( WorkLifeBalance=4, 'Well',null))))

select*from Churns ---for retrieving the updating data from the databse---



UPDATE Churns SET  PerformanceRating= IIF( PerformanceRating= 1, 'Needs Improvement',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Needs Improvement,Below Average,Above Average and Exceptional------
       IIF( PerformanceRating =2, 'Below Average',
           IIF( PerformanceRating=3, 'Above Average',
               IIF( PerformanceRating=4, 'Exceptional',null))))

select*from Churns ---for retrieving the updating data from the databse---


UPDATE Churns SET  Education= IIF( Education= 1, 'Below College',  ----for better understanding I change the type of value of this attribute from 1,2,3,4 to Below College, College,Bachelor,Master and Doctor------
       IIF( Education =2, 'College',
           IIF( Education=3, 'Bachelor',
               IIF( Education=4, 'Master',
			       IIF(Education=5, 'Doctor' ,null)))))

select*from Churns ---for retrieving the updating data from the databse---


-----Create Primary key-------------

UPDATE Churns SET PercentSalaryHike=REPLACE(PercentSalaryHike,'%','');---For cleaning this column the % for some cells have removed---

Alter table Churns alter column PercentSalaryHike float; ---for changing the datatype from varchar to float---

Alter table Churns alter column DistanceFromHomeinkm INT; ---for changing the datatype, because for creating new column as primary key I want this column---

ALTER TABLE Churns add ID INT not null default 0; ---since the data set dosen't have a primary key , I created it as ID---

UPDATE Churns SET ID =DistanceFromHomeinkm*Age*MonthlyIncome---insert the value , by doing this the ID column created without duplicated values---
                                                               ---- For setting this column as primary key I did this:  object Explorer -- People_Attrition database-- table-- design-- set ID as primary key--save



------Creating Age Distribution-----------------------

select max (Age) as Max, min (Age) as Min from Churns --- for determining the upper limit and the lower limit in Age range---


alter table Churns add Age_Range varchar(250); ---- for creating dashboard I need the Age Distribution---

UPDATE Churns SET Age_Range= IIF(Age < 25, 'Less than 25',  
       IIF(Age <35, '25-34',
           IIF(Age <45, '35-44',
               IIF(Age <55, '45-54',
			       IIF(Age>=55, 'Over 55', null)))))

select*from Churns ---for retrieving the updating data from the databse---


------Creating Attrition count-----------------------

   alter table Churns add Attrition_count int;--- for creating dashboard I need the column with integer value to calculate the count of turnover----
      UPDATE Churns SET Attrition_count = IIF(Attrition = 'Yes', 1,  
       IIF(Attrition ='No', 0, null))

select*from Churns ---for retrieving the updating data from the databse---


-------------Creating PercentSalaryHike Categories-----------------------

select max ( PercentSalaryHike)as Max,  min ( PercentSalaryHike) as Min from Churns --- for determining the upper limit and the lower limit in SalaryHike range---


alter table Churns add PercentSalaryHike_Range varchar(250); ---- for creating dashboard I need the PercentSalaryHike range---
UPDATE Churns SET PercentSalaryHike_Range= IIF(PercentSalaryHike < 5, 'Low',  
     IIF(PercentSalaryHike <10, 'Average',
           IIF(PercentSalaryHike <15, 'Moderate',
               IIF(PercentSalaryHike <20, 'High',
			       IIF(PercentSalaryHike>=20, 'Extremely High', null)))))

select*from Churns ---for retrieving the updating data from the databse------



------Creating Tenure Categories-----------------------

alter table Churns add Tenure varchar(250); ---- for creating dashboard I need the tenure categories---

UPDATE Churns SET Tenure= IIF(YearsAtCompany < 1, 'new hire',  
       IIF(YearsAtCompany <5, '1-4',
           IIF(YearsAtCompany <15, '5-14',
		    IIF(YearsAtCompany <30, '15-29',
            			       IIF(YearsAtCompany>=30, '30-40', null)))))

select*from Churns ---for retrieving the updating data from the databse------



---------------Turnover Analysis---------------------------------------------------------------------------------------------------------------------
                          
select*from Churns ---for retrieving data from the databse---

SELECT SUM(Attrition_count) from Churns--- the number of churns--

------By Tenure------------------------------
select Tenure, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100/ sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by Tenure 
  order by Turnover_count desc;--- Note:the Employees with the range of tenure between 1 to 4 years are high! (59%)---


------By PercentSalaryHike------------------------------
select PercentSalaryHike_Range, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100/ sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
Group by PercentSalaryHike_Range 
order by Turnover_count desc;---Note: the employees with Moderate salary hike category are mostly churns (55%)----

------By PercentSalaryHike------------------------------
select Age_Range, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100/ sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by Age_Range 
  order by Turnover_count desc; --- Note:the employess in Age ranges of 25 to 34 years old are mostly churns (47%)----


------By Dept.------------------------------
select Department,
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100/ sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by Department 
  order by Turnover_count DESC;----Note:trunover rate in R&D dept. is high (56%)---

  
  ------By Performance------------------------------
select PerformanceRating, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
from Churns 
Group by PerformanceRating 
ORDER BY Turnover_count DESC; ---Note: the above average is high (40%)---


------By Job role------------------------
select JobRole, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by JobRole 
  ORDER BY Turnover_count DESC; --- Note:Laboratory Technician is high (26%)---


------By Job satisfaction-----------------------
SELECT JobSatisfaction,
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
        FROM Churns 
      GROUP BY JobSatisfaction 
	  ORDER BY Turnover_Percentage DESC; ---Note: the Satisfied category is high (30%)---


------By Job satisfaction-----------------------
SELECT JobSatisfaction,
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
        FROM Churns 
      GROUP BY JobSatisfaction 
	  ORDER BY Turnover_Percentage DESC; ---Note: the Satisfied category is high (30%)---

	  
------By Gender--------------------------
select Gender, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by Gender 
  order by Turnover_count DESC;---Note:Male is high (63%)---


------By business Travel------------------------
select BusinessTravel, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by BusinessTravel 
  order by Turnover_count DESC;---Note:Travel rarely is high (65%)---

------By Distance------------------------------------
select DistanceFromHomeinkm, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by DistanceFromHomeinkm 
  order by Turnover_count DESC ;--- Note:the distance of 2km is high (11%)---

------By Education Field------------------------------
select EducationField, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by EducationField 
  order by Turnover_count DESC ;---Note:Life Sciences is high (37%)---

  
------By Work Life Balance-----------------------
select WorkLifeBalance, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
 from Churns 
 Group by WorkLifeBalance 
 order by Turnover_Percentage DESC ;---Note: the Good category 3 is high (53%)---

-----By EnvironmentSatisfaction-----------------
select EnvironmentSatisfaction, 
sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by EnvironmentSatisfaction 
  order by Turnover_count DESC ; ---Note: The LOW Category is high (30%)---

-----By Education-----------------
select Education, sum(Attrition_count) AS Turnover_count,
  CONCAT(sum(Attrition_count)*100 / sum(sum(Attrition_count)) over (),'%') AS Turnover_Percentage
  from Churns 
  Group by Education 
  order by Turnover_count DESC ; ---Note: The bachelor Category is high (41%)---




   -------------------------Comparative Analysis---------------------------------------------------------------------------------

--1- the average monthly income for each job role
SELECT JobRole,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)as Turnover_count,
       ROUND(AVG(Monthlyincome), 2) AS avg_monthly_income
FROM Churns
GROUP BY JobRole
ORDER BY avg_monthly_income DESC;


--2- the average monthly income for PerformanceRating
SELECT PerformanceRating,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)as Turnover_count,
       ROUND(AVG(Monthlyincome), 2) AS avg_monthly_income
FROM Churns
GROUP BY PerformanceRating
ORDER BY avg_monthly_income DESC;


--3- the average monthly income for each Performance and Jobrole
SELECT PerformanceRating,JobRole,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)as Turnover_count,
       ROUND(AVG(Monthlyincome), 2) AS avg_monthly_income
FROM Churns
GROUP BY PerformanceRating,JobRole
ORDER BY avg_monthly_income DESC; ---- Performance: Above Average	Jobrole: Sales Executive----



--4- the average monthly income and salaryhike for PerformanceRating 
SELECT PerformanceRating, PercentSalaryHike_Range,
       ROUND(AVG(Monthlyincome), 2) AS avg_monthly_income,
	   COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)as Turnover_count
FROM Churns
GROUP BY PerformanceRating,PercentSalaryHike_Range
ORDER BY avg_monthly_income DESC;--- the result is PerformanceRating:Above Average	PercentSalaryHike_Range: Moderate---


--5-Employees with Maximum and Minimum Salary (Less than 15% Hike) by Department---

SELECT Department, MAX(MonthlyIncome) AS MAX, MIN(MonthlyIncome) AS MIN,
COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END)as Turnover_count
FROM Churns
WHERE PercentSalaryHike < 15---moderate rate---
GROUP BY Department
ORDER BY MAX(MonthlyIncome) DESC


--6-Employees Under 5 Years of Experience  and Age range between 27 to 34---

SELECT Department,Gender,WorkLifeBalance,JobSatisfaction,JobRole,PerformanceRating, JobInvolvement, MonthlyIncome
FROM Churns
WHERE YearsAtCompany <5 AND Age BETWEEN 27 AND 34


--7-Average Monthly Income of Employees with less than 5 Years of Experience in Life Sciences--
SELECT AVG(MonthlyIncome) AS AVG
FROM Churns
WHERE EducationField = 'Life Sciences' AND YearsAtCompany <5 --- result is 4714

SELECT AVG(MonthlyIncome) AS AVG
FROM Churns
WHERE EducationField = 'Human Resources' AND YearsAtCompany <5--- result is 4907---the Human Resources field has less turnover number in compare with Life Sciences, as seen the avg. of monthly income for this field is more than Life Sciences field.


--8-Gender,  Married Employees under Attrition with No Promotion in the Last 2 Years
SELECT Gender, COUNT(*) AS number
FROM Churns
WHERE MaritalStatus = 'Married' AND YearsSinceLastPromotion = 2 AND Attrition = 'Yes'
GROUP BY Gender

--9-Employees with bachelor's degree  and Age range between 27 to 34---

SELECT Department,Gender,WorkLifeBalance,JobSatisfaction,JobRole,PerformanceRating,JobInvolvement, MonthlyIncome
FROM Churns
WHERE Education='Bachelor' AND Age BETWEEN 27 AND 34

--10-the number of trun over  based on employee performance ratings and departments

SELECT Department,
       PerformanceRating,
       COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Turn_over_count
FROM Churns
GROUP BY Department,
         PerformanceRating
ORDER BY Department,
         Turn_over_count DESC;

--11-the number of trun over  based on JobSatisfaction and departments

SELECT Department,JobSatisfaction,
       COUNT(CASE WHEN Attrition = 'Yes' THEN 1 END) AS Turn_over_count
FROM Churns
GROUP BY Department,JobSatisfaction
ORDER BY Department,
         Turn_over_count DESC;





