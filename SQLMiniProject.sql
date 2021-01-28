Use Northwind;

-- 1.1	Write a query that lists all Customers in either Paris or London. Include Customer ID, Company Name and all address fields.

SELECT 
c.CustomerID AS "Customer ID",
c.CompanyName AS "Customer Name",
c.Address + ' , ' + c.City + ' , ' + c.Country + ' , ' + c.PostalCode AS "Full Address" 
FROM Customers c WHERE c.City IN ('Paris', 'London');

-- 1.2	List all products stored in bottles.

SELECT 
p.ProductID AS "Product ID",
p.ProductName AS "Product Name",
p.SupplierID AS "Supplier ID",
p.QuantityPerUnit AS "Quantity Per Unit",
p.UnitPrice AS "Unit Price",
p.UnitsInStock AS "Units In Stock",
p.UnitsOnOrder AS "Reorder Level",
p.Discontinued FROM Products p WHERE p.QuantityPerUnit LIKE '%bottles';

-- 1.3	Repeat question above, but add in the Supplier Name and Country.

SELECT 
p.ProductID AS "Product ID",
p.ProductName AS "Product Name",
s.CompanyName AS "Supplier Name",
s.Country AS "Supplier Country",
p.QuantityPerUnit AS "Quantity Per Unit",
p.UnitPrice AS "Unit Price",
p.UnitsInStock AS "Units In Stock",
p.UnitsOnOrder AS "Reorder Level",
p.Discontinued
FROM Products p
INNER JOIN Suppliers s ON p.SupplierID = s.SupplierID 
WHERE p.QuantityPerUnit LIKE '%bottles';

-- 1.4	Write an SQL Statement that shows how many products there are in each category. Include Category Name in result set and list the highest number first.

SELECT 
c.CategoryName AS "Category Name",
COUNT(p.ProductID) AS "Number of products in that category" 
FROM Products p
RIGHT JOIN Categories c ON p.CategoryID=c.CategoryID
GROUP BY c.CategoryName
ORDER BY "Number of products in that category" DESC

-- 1.5	List all UK employees using concatenation to join their title of courtesy, first name and last name together. Also include their city of residence.

SELECT 
e.TitleOfCourtesy + ' ' + FirstName + ' ' + LastName AS "Employee Name",
e.Address + ' , ' + e.City + ' , ' + e.Country + ' , ' + e.PostalCode AS "Full UK Address" 
FROM Employees e 
WHERE e.Country='UK';

-- 1.6	List Sales Totals for all Sales Regions (via the Territories table using 4 joins) with a Sales Total greater than 1,000,000. Use rounding or FORMAT to present the numbers. 

SELECT 
ROUND(SUM((od.UnitPrice * od.Quantity) - (od.UnitPrice * od.Discount * od.Quantity)), 2) AS "Total Sales",
r.RegionDescription AS "Region Description"
FROM [Order Details] od 
INNER JOIN Orders o on o.OrderID = od.OrderID
INNER JOIN EmployeeTerritories et ON et.EmployeeID = o.EmployeeID
INNER JOIN Territories t ON t.TerritoryID = et.TerritoryID
INNER JOIN Region r ON r.RegionID= t.RegionID
GROUP BY r.RegionDescription
HAVING ROUND(SUM((od.UnitPrice * od.UnitPrice) - (od.UnitPrice * od.Discount * od.Quantity)), 2) > 1000000

-- 1.7	Count how many Orders have a Freight amount greater than 100.00 and either USA or UK as Ship Country.

SELECT COUNT(*) AS "Frieght amount greater the 100.00"
FROM Orders o 
WHERE o.Freight > 100.00 AND o.ShipCountry IN ('USA','UK');

-- 1.8	Write an SQL Statement to identify the Order Number of the Order with the highest amount(value) of discount applied to that order.

SELECT TOP 1 OrderID as "Order ID",
FORMAT(SUM(UnitPrice * Quantity * Discount), 'C') AS 'Discount Amount'
FROM [Order Details]
GROUP BY OrderID
ORDER BY SUM(UnitPrice * Quantity * Discount) DESC;

USE malik_db;

-- 2.1 Write the correct SQL statement to create the following table:
-- Spartans Table – include details about all the Spartans on this course. 
-- Separate Title, First Name and Last Name into separate columns,
-- and include University attended, course taken and mark achieved.
-- Add any other columns you feel would be appropriate. 
-- IMPORTANT NOTE: For data protection reasons do NOT include date of birth
-- in this exercise.

DROP TABLE Spartans
CREATE TABLE Spartans
(
    spartanID INT IDENTITY(1,1) PRIMARY KEY,
    title VARCHAR(10),
    firstname VARCHAR(100),
    lastname VARCHAR(100),
    university VARCHAR(100),
    degreeType VARCHAR(5),
    course VARCHAR(100),
    marksAchieved VARCHAR(20)
);

-- Exercise 2.2: Write SQL statements to add the details of the Spartans 
-- in your course to the table you have created.

INSERT INTO Spartans VALUES ('Mr', 'Malik', 'Shams', 'Queen Mary University of London', 'MSc', 'Computer Science', 'Distintion');
INSERT INTO Spartans VALUES ('Mr', 'Aaron', 'Banjoko', '', 'BSc', 'Computer Science', 'Distintion');
INSERT INTO Spartans VALUES ('Mr', 'Wahdel', 'Woodhouse', '', 'BSc', 'Computer Science', 'Distintion');
INSERT INTO Spartans VALUES ('Mr', 'Bradley', 'Williams', '', 'BSc', 'Computer Science', 'Distintion');
INSERT INTO Spartans VALUES ('Mr', 'Kurtis', 'Hanson', '', 'BSc', 'Computer Science', 'Distintion');
INSERT INTO Spartans VALUES ('Mr', 'Joel', 'Fright', '', 'BSc', 'Computer Science', 'Distintion');
INSERT INTO Spartans VALUES ('Mr', 'Domonic', '', '', 'MSc', 'Computer Science', 'Distintion');

--Write SQL statements to extract the data required for the following charts (create these in Excel):
--3.1 List all Employees from the Employees table and who they report to. No Excel required. (5 Marks)

SELECT 
e.TitleOfCourtesy + ' ' + e.FirstName + ' ' + e.LastName AS "Employee Name",
(SELECT TitleOfCourtesy + ' ' + FirstName + ' ' + LastName 
FROM Employees 
WHERE EmployeeID=e.ReportsTo) AS "Report To" 
FROM Employees e

--3.2 List all Suppliers with total sales over $10,000 in the Order Details table. Include the Company Name from the Suppliers Table and present as a bar chart as below: (5 Marks)

SELECT 
s.CompanyName,
SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) AS "Supplier Total"
FROM [Order Details] od 
INNER JOIN Products p ON od.ProductID=p.ProductID
INNER JOIN Suppliers s ON p.SupplierID=s.SupplierID
GROUP BY s.CompanyName
HAVING SUM(od.UnitPrice*OD.Quantity*(1-OD.Discount))>10000
ORDER BY SUM(od.UnitPrice*od.Quantity*(1-od.Discount)) DESC;

--3.3 List the Top 10 Customers YTD for the latest year in the Orders file. Based on total value of orders shipped. No Excel required. (10 Marks)

SELECT TOP 10 
c.CustomerID AS "Customer ID",
c.CompanyName AS "Company",
FORMAT(SUM(UnitPrice*Quantity*(1-Discount)),'C')
AS "YTD Sales"
FROM Customers c 
INNER JOIN Orders o ON o.CustomerID=c.CustomerID
INNER JOIN [Order Details] od ON od.OrderID=O.OrderID
WHERE YEAR(OrderDate)=(SELECT MAX(YEAR(OrderDate)) FROM Orders)
AND o.ShippedDate IS NOT NULL
GROUP BY c.CustomerID, c.CompanyName
ORDER BY SUM(UnitPrice * Quantity * (1-Discount)) DESC;

--3.4 Plot the Average Ship Time by month for all data in the Orders Table using a line chart as below. (10 Marks)

SELECT 
CONCAT(YEAR(o.OrderDate),'-',MONTH(o.OrderDate)) AS "Year-Month",
AVG(DATEDIFF(d, o.OrderDate, o.ShippedDate)) AS "Average Ship Time"
FROM Orders o
GROUP BY CONCAT(YEAR(o.OrderDate),'-',MONTH(o.OrderDate))
ORDER BY CONCAT(YEAR(o.OrderDate),'-',MONTH(o.OrderDate)) ASC