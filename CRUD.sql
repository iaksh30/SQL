# CREATE (C):
# Question: Write an SQL query to create a new table named "Employees" with columns for ID (integer), Name (string), Age (integer), 
# and Department (string).

create database employees;
use employees;
create table employee(
ID int,
Emp_name varchar(225),
Age int,
Department varchar(225));
insert into employee ( ID, emp_name, age, department) 
values
(101,'Ramesh',24 ,'Sales'),
(102,'Vikas',26 ,'HR'),
(103,'Nimit',25 ,'IT'),
(104,'Ronit',29 ,'Finance');		

# READ (R):
# Question: Given the "Employees" table created in the previous question, write an SQL query to retrieve the names of all employees.

select * from employee
select emp_name from employee;

# UPDATE (U):
# Question: Suppose an employee's department has changed. 
# Write an SQL query to update the Department column for the employee with ID 101 from "Sales" to "Marketing" in the "Employees" table.

update employee set department = 'Marketing' where id = 101;

# Delete (D):
# Question: An employee has left the company. Write an SQL query to delete the record of the employee with ID 103 from the "Employees" table.

delete from employee where id = 103;

# Question: A new employee has joined the company. 
# Write an SQL query to insert a new record into the "Employees" table with the following details: 
# ID = 105, Name = "John Doe", Age = 30, Department = "Finance".

insert into employee (id,emp_name,age,department)
values (105,'John Doe',30,'Finance')





