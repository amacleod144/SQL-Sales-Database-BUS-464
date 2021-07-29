--B

--7 M:M
--List the number of backers at each level from most to least
SELECT backer_levels.name, minimum_pledge,COUNT(customers.customer_id) AS NoOfCustomers
FROM customers,backer_levels,customer_backer_levels
WHERE customers.customer_id = customer_backer_levels.customer_id
AND backer_levels.level_id = customer_backer_levels.level_id
GROUP BY backer_levels.level_id
ORDER BY NoOfCustomers DESC;

--8 1:1
--Show all orders whose invoices were sent out after the order was processed
SELECT orders.order_id,order_date,issue_date FROM orders,invoices
WHERE orders.order_id = invoices.order_id
AND order_date < issue_date;

--9 recursive
--List each boss and the number of subordinates they have, in descending order
SELECT CONCAT(bos.first_name," ",bos.last_name) AS boss_name,COUNT(emp.employee_id) AS NoOfSubordinates
FROM employees AS bos,employees AS emp
WHERE emp.boss_id = bos.employee_id
GROUP BY bos.employee_id
ORDER BY NoOfSubordinates DESC;


--C

--1
--List all the backers who are entitled to a digital copy of the game’s OST as part of their backer rewards
SELECT DISTINCT(CONCAT(first_name," ",last_name)) AS customer_name
FROM customers,backer_levels,customer_backer_levels
WHERE customers.customer_id = customer_backer_levels.customer_id
AND backer_levels.level_id = customer_backer_levels.level_id
AND reward_details LIKE "%Digital OST%";

--2
-- Which version of the game is the best selling?
SELECT version_name, COUNT(versions.version_id) AS max_copies_sold
FROM versions,order_versions
WHERE versions.version_id = order_versions.version_id
GROUP BY versions.version_id
HAVING max_copies_sold = (
SELECT MAX(copies_sold) FROM (
SELECT version_name, COUNT(versions.version_id) AS copies_sold
FROM versions,order_versions
WHERE versions.version_id = order_versions.version_id
GROUP BY versions.version_id) AS version_sales);

--3
--List all the Junior Programmers and Game Testers who worked on the Nintendo Switch version of the game
SELECT CONCAT(employees.first_name," ",employees.last_name) AS employee,title
FROM employees,roles,employee_versions
WHERE employees.employee_id = employee_versions.employee_id
AND roles.role_id = employees.role_id
AND version_id = 4
AND employees.role_id IN (7,8);

--4
--Find all customers whose total donations are greater than $60
SELECT CONCAT(customers.first_name," ",customers.last_name) AS customer_name,SUM(pledge_amount) AS total_donated
FROM customers JOIN customer_backer_levels ON customers.customer_id = customer_backer_levels.customer_id
GROUP BY customers.customer_id HAVING total_donated > 60;

--5
--List all customers who bought a version that was worked on by Willow Swan
SELECT CONCAT(customers.first_name," ",customers.last_name) AS customer_name, versions.version_name
FROM customers JOIN orders ON customers.customer_id = orders.customer_id
JOIN order_versions ON orders.order_id = order_versions.order_id
JOIN employee_versions ON order_versions.version_id = employee_versions.version_id
JOIN versions ON employee_versions.version_id = versions.version_id
WHERE employee_versions.employee_id = 12;

--6
--Find all customers in the database who have not ordered a copy of the game
SELECT * FROM customers WHERE NOT EXISTS (
SELECT * FROM orders
WHERE customers.customer_id = orders.customer_id);

--8
--Find the average salary of James Howlett’s direct subordinates
SELECT ROUND(AVG(roles.salary),2) AS avg_salary FROM employees AS emp,employees AS bos,roles
WHERE emp.role_id = roles.role_id
AND emp.boss_id = bos.employee_id
AND emp.boss_id = 1;

--9
--List all employees who are older than 40 and whose salary is greater than $60 000
SELECT CONCAT(first_name," ",last_name) AS employee,date_of_birth,salary
FROM employees, roles
WHERE roles.role_id = employees.role_id
AND DATEDIFF(CURRENT_DATE(),date_of_birth)>=14600
AND salary > 60000;

--10
--List all customer whose orders were invoiced on November 16th, 2020
SELECT CONCAT(customers.first_name," ",customers.last_name) AS customer
FROM customers JOIN orders ON customers.customer_id = orders.customer_id
JOIN invoices ON orders.order_id = invoices.order_id
WHERE issue_date = "2020-11-16";

--11
--List each role in the company and the number of people in it from most employees to least
SELECT roles.title, COUNT(employees.employee_id) AS nofemployees FROM roles, employees
WHERE roles.role_id=employees.role_id
GROUP BY roles.role_id
ORDER BY nofemployees DESC;

--12
--How many backers will be listed in the game credits? (if someone backs twice they are still only listed once)
SELECT COUNT(DISTINCT(customers.customer_id)) AS customers_in_credits FROM customers,customer_backer_levels,backer_levels
WHERE customers.customer_id = customer_backer_levels.customer_id
AND customer_backer_levels.level_id = backer_levels.level_id
AND reward_details LIKE "%Name in Credits%";
