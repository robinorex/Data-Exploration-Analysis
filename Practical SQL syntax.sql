-- create database alex;
-- Use alex;
-- show tables;
-- Create Table EmployeeDemographics 
-- (EmployeeID int, 
-- FirstName varchar(50), 
-- LastName varchar(50), 
-- Age int, 
-- Gender varchar(50)
-- );

-- Create Table EmployeeSalary (EmployeeID int, 
-- JobTitle varchar(50), 
-- Salary int
-- );

-- Insert into EmployeeDemographics VALUES
-- (1001, 'Jim', 'Halpert', 30, 'Male'),
-- (1002, 'Pam', 'Beasley', 30, 'Female'),
-- (1003, 'Dwight', 'Schrute', 29, 'Male'),
-- (1004, 'Angela', 'Martin', 31, 'Female'),
-- (1005, 'Toby', 'Flenderson', 32, 'Male'),
-- (1006, 'Michael', 'Scott', 35, 'Male'),
-- (1007, 'Meredith', 'Palmer', 32, 'Female'),
-- (1008, 'Stanley', 'Hudson', 38, 'Male'),
-- (1009, 'Kevin', 'Malone', 31, 'Male');
-- select * from EmployeeDemographics;
-- Insert Into EmployeeSalary VALUES
-- (1001, 'Salesman', 45000),
-- (1002, 'Receptionist', 36000),
-- (1003, 'Salesman', 63000),
-- (1004, 'Accountant', 47000),
-- (1005, 'HR', 50000),
-- (1006, 'Regional Manager', 65000),
-- (1007, 'Supplier Relations', 41000),
-- (1008, 'Salesman', 48000),
-- (1009, 'Accountant', 42000);
-- select * from EmployeeSalary;
DROP DATABASE IF EXISTS `Parks_and_Recreation`;
CREATE DATABASE `Parks_and_Recreation`;
USE `Parks_and_Recreation`;
CREATE TABLE employee_demographics (
  employee_id INT NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  age INT,
  gender VARCHAR(10),
  birth_date DATE,
  PRIMARY KEY (employee_id)
);
CREATE TABLE employee_salary (
  employee_id INT NOT NULL,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  occupation VARCHAR(50),
  salary INT,
  dept_id INT
);
INSERT INTO employee_demographics (employee_id, first_name, last_name, age, gender, birth_date)
VALUES
(1,'Leslie', 'Knope', 44, 'Female','1979-09-25'),
(3,'Tom', 'Haverford', 36, 'Male', '1987-03-04'),
(4, 'April', 'Ludgate', 29, 'Female', '1994-03-27'),
(5, 'Jerry', 'Gergich', 61, 'Male', '1962-08-28'),
(6, 'Donna', 'Meagle', 46, 'Female', '1977-07-30'),
(7, 'Ann', 'Perkins', 35, 'Female', '1988-12-01'),
(8, 'Chris', 'Traeger', 43, 'Male', '1980-11-11'),
(9, 'Ben', 'Wyatt', 38, 'Male', '1985-07-26'),
(10, 'Andy', 'Dwyer', 34, 'Male', '1989-03-25'),
(11, 'Mark', 'Brendanawicz', 40, 'Male', '1983-06-14'),
(12, 'Craig', 'Middlebrooks', 37, 'Male', '1986-07-27');

INSERT INTO employee_salary (employee_id, first_name, last_name, occupation, salary, dept_id)
VALUES
(1, 'Leslie', 'Knope', 'Deputy Director of Parks and Recreation', 75000,1),
(2, 'Ron', 'Swanson', 'Director of Parks and Recreation', 70000,1),
(3, 'Tom', 'Haverford', 'Entrepreneur', 50000,1),
(4, 'April', 'Ludgate', 'Assistant to the Director of Parks and Recreation', 25000,1),
(5, 'Jerry', 'Gergich', 'Office Manager', 50000,1),
(6, 'Donna', 'Meagle', 'Office Manager', 60000,1),
(7, 'Ann', 'Perkins', 'Nurse', 55000,4),
(8, 'Chris', 'Traeger', 'City Manager', 90000,3),
(9, 'Ben', 'Wyatt', 'State Auditor', 70000,6),
(10, 'Andy', 'Dwyer', 'Shoe Shiner and Musician', 20000, NULL),
(11, 'Mark', 'Brendanawicz', 'City Planner', 57000, 3),
(12, 'Craig', 'Middlebrooks', 'Parks Director', 65000,1);

CREATE TABLE parks_departments (
  department_id INT NOT NULL AUTO_INCREMENT,
  department_name varchar(50) NOT NULL,
  PRIMARY KEY (department_id)
);
INSERT INTO parks_departments (department_name)
VALUES
('Parks and Recreation'),
('Animal Control'),
('Public Works'),
('Healthcare'),
('Library'),
('Finance');
select * from Employee_Demographics;
select * from Employee_Salary;
select * from parks_departments;
select * from Employee_Demographics as Dem right Join Employee_Salary as Sal on Dem.employee_id=Sal.employee_id;
select sal1.employee_id as emp_santa, sal1.first_name as First_name_Santa, sal1.Last_name as Last_name_Santa, sal2.employee_id as emp_santa, sal2.first_name as First_name_Santa, sal2.Last_name as Last_name_Santa from employee_salary sal1 join employee_salary sal2 on sal1.employee_id+3 = sal2.employee_id;   #self join
-- join multiple table with Union: #having count 放在group by後面 union後面可以直接放select語句
select dem.employee_id, dem.first_name,dem.last_name,dem.age,dem.gender,sal.occupation,sal.salary,pd.department_name from Employee_Demographics Dem Inner Join Employee_Salary Sal on Dem.employee_id=Sal.employee_id Inner Join parks_departments pd on sal.dept_id=pd.department_id;
select first_name,last_name,"old Man" as label from Employee_Demographics where age > 40 and gender="Male" Union
select first_name,last_name,"old lady" as label from Employee_Demographics where age > 40 and gender="Female" UNION 
select first_name,last_name,"Highly Paid Employee" as label from Employee_Salary where Salary > 70000 order by first_name, last_name;
-- string function-- 
select length("hello");
select first_name, length(first_name) from employee_demographics order by 2;
select first_name, UPPER(first_name) from employee_demographics;
select substring(birth_date,9,2) from employee_demographics as birth_day;  #substring(column,第幾個位數,取幾位)
select first_name, last_name,substring(birth_date,1,7) as birth_date from employee_demographics;
select first_name, last_name,left(birth_date,7) as birth_date from employee_demographics;
select last_name, locate('e',last_name) from Employee_demographics;
select last_name, replace(last_name, "e", "a") from Employee_demographics;
-- Use CONCAT to add up the column string !!!!
select first_name,last_name, concat(first_name," " ,last_name) as full_name from Employee_demographics;
-- Use CASE to have logical statment
select first_name,last_name,age,
CASE 
    WHEN age <= 30 THEN "Young"
    WHEN age BETWEEN 31 and 50 THEN "Middle age"
    ELSE "Old"  #Else後面不加then
END as age_bracket
from Employee_demographics;
-- bonus
-- salary>50000, 7% ; <=50000, 5%, Finance extra=10%
select first_name,last_name,occupation,salary, department_name,
CASE
	WHEN salary <= 50000 THEN salary*1.05
    WHEN salary>50000 THEN salary*1.07
END as salary_with_bonus,
CASE
	WHEN dept_id = 6 THEN salary*0.1
    WHEN dept_id= 3 THEN salary*0.05
    WHEN dept_id= 1 then salary*0.03
    WHEN dept_id= 4 then salary*0.02
END as extra_bouns
from employee_salary e left Join parks_departments p on e.dept_id = p.department_id;
-- subquery
select * from employee_Demographics where employee_id in (select employee_id from employee_salary where dept_id=1);
select first_name,last_name, AVG(salary) from Employee_salary group by first_name,last_name;
select first_name, salary, (select AVG(salary) from Employee_salary) as avg_salary from Employee_salary;
select gender,AVG(age),MIN(age),MAX(age),COUNT(age) from employee_Demographics group by gender;
select * from 
(select gender,AVG(age) as ave_age,
MIN(age) as min_age,
MAX(age) as max_age,
COUNT(age) as count_age from employee_Demographics group by gender) as aggr_table;

select gender, AVG(salary) as ave_salary from employee_demographics join employee_salary using(employee_id) group by gender;
-- Windows function
select employee_id,dem.first_name,dem.last_name,gender, age, AVG(salary) OVER(partition by gender) from employee_demographics dem join employee_salary sal using(employee_id);
select employee_id,dem.first_name,dem.last_name,gender, age, SUM(salary) OVER(partition by gender) from employee_demographics dem join employee_salary sal using(employee_id);
select employee_id,dem.first_name,dem.last_name,gender, age,salary, SUM(salary) OVER(partition by gender ORDER BY employee_id) as Rolling_total from employee_demographics dem join employee_salary sal using(employee_id);
select employee_id,dem.first_name,dem.last_name,gender, age,salary, 
row_number() OVER(partition by gender order by salary desc) as row_num,
rank() OVER(partition by gender order by salary desc) as rank_,
dense_rank() OVER(partition by gender order by salary desc) as dense_rank_
from employee_demographics dem join employee_salary sal using(employee_id);
select employee_id,first_name,last_name,gender, age, age+3*5 from employee_demographics;
#SQL數理運算的執行順序PEMDAS ----Parentheses->Exponents->Multiplication->Division->Addition->Subtraction
select * from employee_demographics where (first_name= "Tom" and age=36) or age>60;
-- Like Statement % _
select * from employee_demographics where first_name LIKE "%k%";
select * from employee_demographics where first_name LIKE "a____";
select * from employee_demographics where birth_date LIKE "%5%";
select gender, avg(age) from employee_demographics group by gender;
select occupation, salary from employee_salary group by occupation, salary;
-- if you want to filter out the aggregate function after group by, you have to use HAVING clause
select occupation,AVG(salary) from Employee_Salary where occupation LIKE "%Director%" group by occupation HAVING AVG(salary) > 30000;
select occupation,AVG(salary) from Employee_Salary where occupation LIKE "%Manager%" group by occupation HAVING AVG(salary) > 30000;
select * from Employee_Salary order by salary desc;
select gender, AVG(age) as ave_age from employee_demographics group by gender having ave_age >40;
-- CTE
WITH CTE_Example (Gender, AVG_SAL, MAX_SAL, MIN_SAL, COUNT_SAL)AS
(
select gender,AVG(salary) as avg_salary,MIN(salary) as min_salary,MAX(salary) as max_salary,COUNT(salary) as count_salary
from employee_Demographics join employee_salary using(employee_id) group by gender
)
select * from CTE_Example;
-- CTE is not a permanent object. CTE is not creating a table so you have to use it in immediate fashion after the query. You cant resue it. While temp table is a object table.
WITH CTE_Example AS
(
select employee_id, first_name, age, gender
from employee_Demographics where birth_date > "1970-01-01"
),
 CTE_example2 as 
(
select employee_id, salary from employee_salary where salary > 50000
)
select * from CTE_Example join CTE_example2 on CTE_Example.employee_id=CTE_example2.employee_id;
-- Temporary table
create temporary table temp_table
(first_name varchar(50),
 last_name varchar(50),
 fave_movie varchar(100)
 );
 Insert into temp_table values ("Alex","Yang","Paris with love");
 select * from temp_table;
--  More useful way below !!!! create a temp table base on curren table !!
create temporary table salary_over_50K
select * from employee_salary where salary >= 50000;
select * from salary_over_50K;
-- store procedures
USE parks_and_recreation;
create procedure large_salaries()
select * from employee_salary where salary >= 50000;
call large_salaries();
drop procedure if exists `large_salaries2`;

DELIMITER $$
Create procedure large_salaries2()
Begin
	select * from employee_salary where salary >= 50000;
	select * from employee_salary where salary >= 40000;
End $$
DELIMITER ;   #needs to change it back to ; 
call large_salaries2()

DELIMITER $$
Create procedure large_salaries3(p_id INT)  #input parameter 
Begin
	select salary from employee_salary where employee_id=p_id ;
End $$
DELIMITER ;   
call large_salaries3(9);
#Trigger
DELIMITER $$
CREATE TRIGGER employee_insert
	after insert on employee_salary   #輸入在salary的資料會Trigger自動更新到demographics裡面
    for each row
BEGIN
	INSERT INTO employee_demographics(employee_id,first_name,last_name)
    values (new.employee_id,new.first_name,new.last_name);
END $$
DELIMITER ;
INSERT INTO employee_salary(employee_id,first_name,last_name,occupation,salary,dept_id)
VALUES(13,"Jean-Claude","Van Dan","CEO","1000000",NULL);
select * from employee_salary;
select * from employee_demographics;
-- Events
DELIMITER $$
CREATE Event delete_retirees
ON SCHEDULE EVERY 30 SECOND
DO
BEGIN
	DELETE FROM employee_demographics where age >= 60;
END $$
DELIMITER ;
SHOW variables LIKE "event%";

