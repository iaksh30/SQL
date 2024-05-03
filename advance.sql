-- (b)List the top 3 most sold products from the "Products" table.
select products.productID, products.productname, count(orders.orderID) as totalorders from products
left join orders on products.productID = orders.productID
group by products.productID, products.productname
order by totalorders desc
limit 3;

-- (b)Retrieve the names of students along with their corresponding classes from the "Students" and "Classes" tables.
select students.name as studentname, classes.classname from students
join classes on students.classID = classes.classID;

-- (b)Create a stored procedure named GetProductDetails that takes a product ID as input and returns the details of that product from the "Products" table.
delimiter //

create procedure getproductdetails(in productID int)
begin
    select * from Products where ProductID = productID;
end //

delimiter ;
call getproductdetails(123);

-- (m)Rank customers based on the total amount they have spent on orders in descending order.
select customer.customerID, customers.customername, sum(orders.totalamount) as totalspend from customers
join orders on customer.customerID = orders.customerID
group by customers.customerID, customers.customername
order by totalspent desc;

-- (m)Retrieve the names of customers who have made orders along with the order dates from the "Customers" and "Orders" tables.
select customers.customername, orders.orderdate
from customers
join orders on customers.customerID = orders.customerID;

-- (m)Create a stored procedure named GetCustomerOrders that takes a customer ID as input and returns all orders made by that customer from the "Orders" table.
delimiter //

create procedure getcustomerorders(in customerID int)
begin
    select * from Orders where customerID = customerID;
end //

delimiter ;
call getcustomerorders(123)

-- (i)Rank students in each class based on their scores in descending order.
select studentID, studentname, classID, score,
rank() over(partition by classID order by score desc) as rank
from students;

-- (i)Retrieve the names of employees along with the project names they are assigned to from the "Employees", "Projects", and "Assignments" tables.
select employees.employeename, projects.projectname from employees
join assignments on employees.employeeID = assignments.employeeID
join projectss on assignments.productID = projects.productID;

-- (i)Create a stored procedure named CalculateTotalSales that calculates the total sales amount for a given period and returns it.
delimiter //

create procedure calculatetotalsales(
    in start_date date,
    in end_date date,
    out total_sales decimal(10, 2)
)
begin
    select sum(totalamount) into total_sales
    from orders
    where orderdate between start_date and end_date;
end //

delimiter ;
call calculatetotalsales(123)

-- (a)Rank employees based on their performance scores within each department, showing the rank within the department.
select department, employeeID, employeename,performancescore, 
rank() over(partition by department order by performancescore desc) as rank_within_department from employees;

-- (a)Rank countries based on their population density (population divided by area) in descending order.
select country, population, area, population/area as populationdensity,
rank() over(order by population/area desc) as rankbypopulationdensity
from countries

-- (a)Retrieve the names of customers who have not made any orders along with their contact details from the "Customers" table.
select customers.customername, customers.contactdetails from customers
left join orders on customers.customerID = orders.customerID
where orders.customerID is null;

-- (a)Retrieve the names of employees who have worked on the same projects together, along with the project names, from the "Employees" and "Assignments" tables.
select distinct e1.EmployeeName AS Employee1, e2.EmployeeName AS Employee2, p.ProjectName
FROM Assignments a1
JOIN Assignments a2 ON a1.ProjectID = a2.ProjectID AND a1.EmployeeID < a2.EmployeeID
JOIN Employees e1 ON a1.EmployeeID = e1.EmployeeID
JOIN Employees e2 ON a2.EmployeeID = e2.EmployeeID
JOIN Projects p ON a1.ProjectID = p.ProjectID;

-- (a)Create a stored procedure named GetEmployeeHierarchy that takes an employee ID as input and returns the hierarchical structure of employees reporting to that employee.
DELIMITER //

CREATE FUNCTION GetEmployeeHierarchy(employeeID INT) RETURNS TEXT
BEGIN
    DECLARE output TEXT;
    SET output = '';
    
    WITH RECURSIVE EmployeeHierarchy AS (
        SELECT EmployeeID, EmployeeName, ManagerID, 1 AS Level
        FROM Employees
        WHERE EmployeeID = employeeID
        UNION ALL
        SELECT e.EmployeeID, e.EmployeeName, e.ManagerID, eh.Level + 1
        FROM Employees e
        JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
    )
    SELECT CONCAT(REPEAT('  ', Level), EmployeeName, '\n')
    INTO output
    FROM EmployeeHierarchy
    ORDER BY Level, EmployeeName;

    RETURN output;
END //

DELIMITER ;

-- (a)Create a stored procedure named GenerateMonthlyReport that generates a report summarizing sales data for each product for a given month
DELIMITER //

CREATE PROCEDURE GenerateMonthlyReport(IN report_month DATE)
BEGIN
    SELECT
        Products.ProductID,
        Products.ProductName,
        SUM(Orders.Quantity) AS TotalQuantity,
        SUM(Orders.TotalAmount) AS TotalSalesAmount
    FROM
        Products
    LEFT JOIN
        Orders ON Products.ProductID = Orders.ProductID
    WHERE
        MONTH(Orders.OrderDate) = MONTH(report_month)
        AND YEAR(Orders.OrderDate) = YEAR(report_month)
    GROUP BY
        Products.ProductID,
        Products.ProductName;
END //

DELIMITER ;