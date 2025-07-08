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

-- practice

create table Orders(
OrderID int primary key,
CustomerId int,
OrderDate date,
Amount int
); 

create table Customers(
CustomerID int primary key,
Name varchar(50),
City varchar(50)
); 

INSERT INTO Orders (OrderID, CustomerID, OrderDate, Amount) VALUES
  (1, 101, '2023-01-10', 500),
  (2, 102, '2023-01-11', 1500),
  (3, 101, '2023-01-12', 700),
  (4, 103, '2023-01-15', 300),
  (5, 102, '2023-01-17', 1000);

INSERT INTO Customers (CustomerID, Name, City) VALUES
  (101, 'Alice', 'Mumbai'),
  (102, 'Bob', 'Delhi'),
  (103, 'Charlie', 'Bangalore'),
  (104, 'David', 'Mumbai');

--  Q1. Get the names of customers who have placed more than 1 order.
select C.Name 
from Customers C 
join Orders O on C.CustomerID=O.CustomerID
group by C.CustomerID, C.Name
Having Count(O.OrderId)>1;

 --  Q2. List all customers who have not placed any order.
select C.Name 
from Customers C
left join Orders O on C.CustomerID=O.CustomerID
group by C.CustomerID, C.Name
Having Count(O.OrderId)=0;    -- correct but we can reduce it

---
SELECT C.Name 
FROM Customers C
LEFT JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderID IS NULL;

 
 -- Q3. Display total amount spent by each customer, sorted from highest to lowest.
SELECT C.Name, SUM(O.Amount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY TotalSpent desc;

--  Q4. Retrieve customers and their order details using a JOIN.
Select C.CustomerID, C.Name, O.OrderID, O.OrderDate, O.Amount
from Customers C
join Orders O on C.CustomerID = O.CustomerID


 -- Q5. Find the total number of orders and total amount spent by customers from Delhi.
 Select count(O.OrderId) as TotalNoOfOrders, sum(O.Amount) as totalAmount
 from Customers C
 join Orders O on C.CustomerID = O.CustomerID
 where C.City='Delhi';
 
 --  Q6. Display customers who placed at least one order above ₹1000.
 SELECT DISTINCT C.Name 
FROM Customers C 
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.Amount > 1000;
 
 -- Q7. List the top 2 customers who spent the most total amount (use subquery, no window functions).
 SELECT C.Name, SUM(O.Amount) AS TotalSpent
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID, C.Name
ORDER BY TotalSpent DESC
LIMIT 2;

 
 -- 🔹 Q8. Add a column called SpendingLevel:
Select O.OrderID, C.CustomerID, O.Amount,
case
	when Amount>1000 then 'High'
    when Amount>500 AND Amount<1000 then 'medium'
    else 'low'
end as SpendingLevel
FROM Orders O 
JOIN Customers C ON C.CustomerID = O.CustomerID

-- 🔹 Q9. Find the average order amount for each city

SELECT C.City, AVG(O.Amount) AS AvgAmount
FROM Orders O 
JOIN Customers C ON C.CustomerID = O.CustomerID
GROUP BY C.City;


 -- Q10. Find the customers who placed an order on the earliest date in the dataset. 
 SELECT DISTINCT C.Name
FROM Customers C
JOIN Orders O ON C.CustomerID = O.CustomerID
WHERE O.OrderDate = (
    SELECT MIN(OrderDate)
    FROM Orders
);



 
