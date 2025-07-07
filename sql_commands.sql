CREATE DATABASE CompanyDB;
USE CompanyDB;

create table employees(
EmpId int Primary Key,
Name Varchar(100),
Department varchar(50),
salary int,
JoinDate date
);

Insert into employees (EmpId, Name, Department, salary, JoinDate)
values 
(101,'Alice','HR',50000,'2022-01-15'),
(102, 'Bob', 'IT', 70000, '2021-10-12'),
(103, 'Charlie', 'Finance', 65000, '2020-07-01'),
(104, 'David', 'IT', 72000, '2019-05-20'),
(105, 'Eva', 'HR', 52000, '2023-03-10');

select * from employees;
select Name, Department  from employees;
select * from employees where Department='IT';

-- Sorting with ORDER BY-- 
select * from employees order by salary;
select * from employees order by salary DESC;

-- Aggregate Functions
select sum(salary) as totalsalary from employees;
select Avg(salary) as Averagesalary from employees;
select count(*) as HRemployees  from employees where Department='HR';
 
 -- Group BY 
 -- Average salary by department
select Department, avg(salary) as AvgSalary , sum(salary) as TotalDeptSalary
from employees
group by Department

-- Having (post-grouping filter)
-- Departments with average salary > 60000
select Department, Avg(salary) as AvgSalary
from employees
group by Department
Having Avg(salary)>60000;


-- Update and delete
update employees set salary=75000 where Name='Bob';

-- Join
Create table department(
	deptid int primary key,
    deptname varchar(50)
); 
insert into department values
(1,'HR'),
(2, 'IT'),
(3, 'Finance');

select E.Name, E.salary, D.deptid 
from employees E
join department D
on E.Department=D.deptname;



-- 11. Subqueries-- 
-- Find Employees with salary>avg salary-- 
select * from employees
where salary>(select avg(salary)from employees);


-- 1️⃣ Find the highest-paid employee in each department
select Department, Name, salary 
from employees e
where salary =(
	select max(salary)
    from employees
    where Department=e.Department
);  

select Name,salary, 
case
	when salary>=70000 then 'High'
    when salary>=60000 then 'medium'
    else 'low'
end as salary_category
from employees;

-- 3️⃣ Count of employees in each department, only if count > 1
select Department, count(*) as empcount
from employees
group by department
having count(*) >1;

 -- 5️⃣ Show employees with the 2nd highest salary
 SELECT *
FROM Employees
WHERE Salary = (
    SELECT MAX(Salary)
    FROM Employees
    WHERE Salary < (
        SELECT MAX(Salary) FROM Employees
    )
);




 
