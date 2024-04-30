-- Moderate level

-- Join Operations:
-- Question: Given two tables, "Employees" and "Departments," with foreign key relationships (Employees.DepartmentID -> Departments.ID), 
-- write an SQL query to retrieve the names of all employees along with their corresponding department names.
select employees.empname as emp_name, department.dname as dep_name from employees
join departments on employees.departmentID = department.ID;

-- Subquery:
-- Question: In a database with tables "Orders" and "Customers," 
-- write an SQL query to find the total number of orders placed by customers who are located in the United States.
select count(*) as totalorders from orders
join customers on orders.customerID = customers.ID
where customers. country = 'United States';

-- Update with Join:
-- Question: Suppose you have two tables, "Employees" and "Salaries," where "Employees" contains employee information 
-- and "Salaries" contains their corresponding salary details. 
-- Write an SQL query to update the salary of all employees by a certain percentage (let's say 10%).
update salaries
join employees on salaries.employeeID = employees.employeeID

-- Nested Query with Aggregation:
-- Question: Given tables "Products" and "Orders," write an SQL query to find the product ID and name of the product that has been ordered the most.
select products.productID, products.productname from products
join orders on products.productID = orders.productID 
group by products.productID, products.productname
order by count(*) desc
limit 1;

-- Delete with Join:
-- Question: Suppose you have two tables, "Customers" and "Orders," where "Customers" contains customer information 
-- and "Orders" contains their corresponding order details. Write an SQL query to delete all customers who have not placed any orders.
select * from customers
select customers.* from customers
left join orders on customer.customerID = order.customerID
where orders.customerID is null;
delete from customers
where customerID in (
select customers.customerID from customers
left join orders on customers.customerID = orders.customerID
where orders.customerID is null);