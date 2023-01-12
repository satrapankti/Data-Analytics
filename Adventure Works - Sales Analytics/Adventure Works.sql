CREATE DATABASE adventureworks;
USE adventureworks;

CREATE TABLE Dimcustomer(
CustomerKey	INT,
GeographyKey INT,
CustomerAlternateKey VARCHAR(20),
Title VARCHAR(10),
FirstName VARCHAR(20),
MiddleName VARCHAR(20),
LastName VARCHAR(20),
NameStyle VARCHAR(10),
BirthDate INT,
MaritalStatus VARCHAR(10),
Suffix VARCHAR(5),
Gender VARCHAR(2),
EmailAddress TEXT,
YearlyIncome INT,
TotalChildren INT,
NumberChildrenAtHome INT,
EnglishEducation TEXT,
SpanishEducation TEXT,
FrenchEducation	TEXT,
EnglishOccupation TEXT,
SpanishOccupation TEXT,
FrenchOccupation TEXT,
HouseOwnerFlag	INT,
NumberCarsOwned	INT,
AddressLine1 TEXT,
AddressLine2 TEXT,
Phone VARCHAR(30),
DateFirstPurchase INT,
CommuteDistance VARCHAR(10)
);

CREATE TABLE Dimdate(
DateKey	INT,
FullDateAlternateKey VARCHAR(20),	
DayNumberOfWeek	INT,
EnglishDayNameOfWeek VARCHAR(20),	
SpanishDayNameOfWeek VARCHAR(20),
FrenchDayNameOfWeek	VARCHAR(20),
DayNumberOfMonth INT,
DayNumberOfYear	INT,
WeekNumberOfYear INT,
EnglishMonthName VARCHAR(20),
SpanishMonthName VARCHAR(20),
FrenchMonthName	VARCHAR(20),
MonthNumberOfYear INT,
CalendarQuarter	INT,
CalendarYear INT,
CalendarSemester INT,	
FiscalQuarter INT,
FiscalYear	INT,
FiscalSemester INT
);

CREATE TABLE Dimproduct(
ProductKey INT,
Unitprice TEXT,
ProductAlternateKey TEXT,
ProductSubcategoryKey TEXT,
WeightUnitMeasureCode TEXT,
SizeUnitMeasureCode TEXT,
EnglishProductName TEXT,
SpanishProductName TEXT,
FrenchProductName TEXT,
StandardCost TEXT,
FinishedGoodsFlag TEXT,
Color TEXT,
SafetyStockLevel TEXT,
ReorderPoint INT,
ListPrice TEXT,
Size TEXT,
SizeRange TEXT,
Weight TEXT,
DaysToManufacture INT,
ProductLine TEXT,
DealerPrice TEXT,
Class TEXT,
Style TEXT,
ModelName TEXT,
EnglishDescription TEXT,
FrenchDescription TEXT,
ChineseDescription TEXT,
ArabicDescription TEXT,
HebrewDescription TEXT,
ThaiDescription TEXT,
GermanDescription TEXT,
JapaneseDescription TEXT,
TurkishDescription TEXT,
StartDate TEXT,
EndDate TEXT,
Status TEXT
);

CREATE TABLE Dimproductcategory(
ProductCategoryKey INT,
ProductCategoryAlternateKey INT,
EnglishProductCategoryName VARCHAR(30),
SpanishProductCategoryName VARCHAR(30),
FrenchProductCategoryName VARCHAR(30)
);

CREATE TABLE Dimproductsubcategory(
ProductSubcategoryKey INT,
ProductSubcategoryAlternateKey INT,
EnglishProductSubcategoryName VARCHAR(30),
SpanishProductSubcategoryName VARCHAR(30),
FrenchProductSubcategoryName VARCHAR(30),
ProductCategoryKey INT
);

CREATE TABLE Dimsalesterritory(
SalesTerritoryKey INT,
SalesTerritoryAlternateKey INT,	
SalesTerritoryRegion VARCHAR(30),
SalesTerritoryCountry VARCHAR(30),
SalesTerritoryGroup VARCHAR(30)
);

CREATE TABLE actinternetsales(
  ProductKey INT,
  OrderDateKey INT,
  DueDateKey INT,
  ShipDateKey INT,
  CustomerKey INT,
  PromotionKey INT,
  CurrencyKey INT,
  SalesTerritoryKey INT,
  SalesOrderNumber TEXT,
  SalesOrderLineNumber INT,
  RevisionNumber INT,
  OrderQuantity INT,
  UnitPrice DOUBLE,
  ExtendedAmount DOUBLE,
  UnitPriceDiscountPct INT,
  DiscountAmount INT,
  ProductStandardCost DOUBLE,
  TotalProductCost DOUBLE,
  SalesAmount DOUBLE,
  TaxAmt DOUBLE,
  Freight DOUBLE,
  CarrierTrackingNumber TEXT,
  CustomerPONumber TEXT,
  OrderDate INT,
  DueDate INT,
  ShipDate INT
);

select count(*) from Dimcustomer;
select count(*) from Dimdate;
select count(*) from Dimproduct;
select count(*) from Dimproductcategory;
select count(*) from Dimproductsubcategory;
select count(*) from Dimsalesterritory;
select count(*) from Factinternetsales;

CREATE TABLE Employee (
    empno INT PRIMARY KEY,
    ename VARCHAR(30),
    job VARCHAR(20) DEFAULT 'Clerk',
    mgr INT,
    hiredate DATE,
    sal FLOAT CHECK (sal >= 0),
    comm FLOAT,
    deptno INT,
    FOREIGN KEY (deptno)
        REFERENCES Dept(deptno)
);

CREATE TABLE Dept (
    deptno INT UNIQUE,
    dname VARCHAR(20),
    loc VARCHAR(15)
);

INSERT INTO Employee VALUES 
(7369,"SMITH","CLERK",7902,"1890-12-17",800.00,NULL,20),
(7499,"ALLEN","SALESMAN",7698,"1981-02-20",1600.00,300.00,30),
(7521,"WARD","SALESMAN",7698,"1981-02-22",1250.00,500.00,30),
(7566,"JONES","MANAGER",7839,"1981-04-02",2975.00,NULL,20),
(7654,"MARTIN","SALESMAN",7698,"1981-09-28",1250.00,1400.00,30),
(7698,"BLAKE","MANAGER",7839,"1981-05-01",2850.00,NULL,30),
(7782,"CLARK","MANAGER",7839,"1981-06-09",2450.00,NULL,10),
(7788,"SCOTT","ANALYST",7566,"1987-04-19",3000.00,NULL,20),
(7839,"KING","PRESIDENT",NULL,"1987-11-17",5000.00,NULL,10),
(7844,"TURNER","SALESMAN",7698,"1981-09-08",1500.00,0.00,30),
(7876,"ADAMS","CLERK",7788,"1987-05-23",1100.00,NULL,20),
(7900,"JAMES","CLERK",7698,"1981-12-03",950.00,NULL,30),
(7902,"FORD","ANALYST",7566,"1981-12-03",3000.00,NULL,20),
(7934,"MILLER","CLERK",7782,"1982-01-23",1300.00,NULL,10);

INSERT INTO Dept VALUES
(10,"OPERATIONS","BOSTON"),
(20,"RESEARCH","DALLAS"),
(30,"SALES","CHICAGO"),
(40,"ACCOUNTING","NEW YORK");

-- Create the Employee Table
SELECT * FROM Dept;

-- Create the Dept Table
SELECT * FROM Employee;

-- List the Names and salary of the employee whose salary is greater than 1000
SELECT ename,sal FROM Employee WHERE sal >= 1000;

-- List the details of the employees who have joined before end of September 81.
SELECT * FROM Employee WHERE hiredate < ("1981-10-01");

-- List Employee Names having I as second character
SELECT * FROM Employee WHERE ename LIKE "_I%";

-- List Employee Name,Salary,Allowances (40% of Sal),P.F.(10 % of Sal)and Net Salary.Also assign the alias name for the columns
SELECT ename,sal,(0.4*sal) AS "Allowances",(0.1 * sal) AS "PF",(sal+(0.4*sal)-(0.1 * sal)) AS "NetSal" FROM Employee;

-- List Employee Names with designations who does not report to anybody
SELECT * FROM Employee WHERE mgr IS NULL;

-- List Empno, Ename and Salary in the ascending order of salary.
SELECT empno,ename,sal FROM Employee ORDER BY sal ASC;

-- How many jobs are available in the Organization?
SELECT DISTINCT job FROM Employee;
SELECT COUNT(DISTINCT JOB) FROM Employee;

-- Determine total payable salary of salesman category
SELECT job,SUM(sal) AS "Total Payable Salary" FROM Employee WHERE job = "SALESMAN" GROUP BY job;

-- List average monthly salary for each job within each department   
SELECT job,ROUND(AVG(sal)) AS "Average Salary" FROM Employee GROUP BY job;

-- Use the Same EMP and DEPT table used in the Case study to Display EMPNAME, SALARY and DEPTNAME in which the employee is working.
SELECT a.ename,a.sal,b.dname FROM Employee AS a JOIN Dept AS b ON a.deptno = b.deptno;

-- Create the Job Grades Table as below
CREATE TABLE Job_Grade (
grade VARCHAR(3),
lowest_sal INT,
highest_sal INT
);

INSERT INTO Job_Grade VALUES 
("A",0,999),
("B",1000,1999),
("C",2000,2999),
("D",3000,3999),
("E",4000,5000);

SELECT * FROM Job_Grade;

-- Display the last name, salary and Corresponding Grade.
SELECT a.ename,a.sal,b.grade FROM Employee AS a JOIN Job_Grade AS b ON a.sal BETWEEN b.lowest_sal AND b.highest_sal;

-- Display the Emp name and the Manager name under whom the Employee works in the below format.Emp Report to Mgr.
SELECT CONCAT(ename," report to ",mgr) AS "Reporting" FROM Employee WHERE mgr IS NOT NULL;

-- Display Empname and Total sal where Total Sal (sal + Comm)
SELECT ename,(sal+ IFNULL(comm,0)) AS "Total Sal" FROM Employee;

-- Display Empname and Sal whose Empno is an odd number
SELECT ename,sal FROM Employee WHERE empno % 2 <> 0;

-- Display Empname, Rank of sal in Organisation, Rank of Sal in their department
SELECT DENSE_RANK() OVER (ORDER BY sal DESC) AS "Organisation_Rank",ename,deptno,sal,
DENSE_RANK() OVER (PARTITION BY deptno ORDER BY sal DESC) AS "Department_Rank" 
FROM Employee ORDER BY sal DESC;

-- Display Top 3 Empname based on their Salary
SELECT DENSE_RANK() OVER (ORDER BY sal DESC) AS "Rank",ename,sal FROM Employee LIMIT 3;

-- Display Empname who has highest Salary in Each Department.
SELECT deptno,ename,MAX(sal) AS Salary FROM Employee GROUP BY deptno;

-- Create the Salespeople 
CREATE TABLE Salespeople (
    snum INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    sname VARCHAR(30),
    city VARCHAR(30),
    comm FLOAT
);

INSERT INTO Salespeople VALUES
(1001,"PeeL","London",0.12),
(1002,"Serres","San Jose",0.13),
(1003,"Axelrod","New York",0.10),
(1004,"Motika","London",0.11),
(1007,"Rafkin","Barcelona",0.15);

SELECT * FROM Salespeople;

-- Create the Cust Table 
CREATE TABLE Cust (
    cnum INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    cname VARCHAR(20),
    city VARCHAR(20),
    rating INT,
    snum INT,
    FOREIGN KEY (snum)
        REFERENCES Salespeople (snum)
);

INSERT INTO Cust VALUES
(2001,"Hoffman","London",100,1001),
(2002,"Giovanne","Rome",200,1003),
(2003,"Liu","San Jose",300,1002),
(2004,"Grass","Berlin",100,1002),
(2006,"Clemens","London",300,1007),
(2007,"Pereira","Rome",100,1004),
(2008,"James","London",200,1007);

SELECT * FROM Cust;

-- Create orders table 
CREATE TABLE Orders (
    onum INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    amt FLOAT,
    odate DATE,
    cnum INT,
    snum INT,
    FOREIGN KEY (cnum)
        REFERENCES Cust (cnum),
    FOREIGN KEY (snum)
        REFERENCES Salespeople (snum)
);

INSERT INTO Orders Values
(3001,18.69,"1994-10-03",2008,1007),
(3002,1900.10,"1994-10-03",2007,1004),
(3003,767.19,"1994-10-03",2001,1001),
(3005,5160.45,"1994-10-03",2003,1002),
(3006,1098.16,"1994-10-04",2008,1007),
(3007,75.75,"1994-10-05",2004,1002),
(3008,4723.00,"1994-10-05",2006,1001),
(3009,1713.23,"1994-10-04",2002,1003),
(3010,1309.95,"1994-10-06",2004,1002),
(3011,9891.88,"1994-10-06",2006,1001);

SELECT * FROM Orders;

-- Write a query to match the salespeople to the customers according to the city they are living.
SELECT a.sname AS "Sales Person",b.cname AS "Customer Name",b.city FROM Salespeople AS a JOIN Cust AS b ON a.city = b.city;

-- Write a query to select the names of customers and the salespersons who are providing service to them.
SELECT b.cname AS "Customer Name",a.sname AS "Sales Person" FROM Salespeople AS a JOIN Cust AS b ON a.snum = b.snum;

-- Write a query to find out all orders by customers not located in the same cities as that of their salespeople
SELECT a.onum,b.cname FROM Orders AS a,Cust AS b,Salespeople AS c WHERE b.city <> c.city AND a.cnum = b.cnum AND a.snum = c.snum;

-- Write a query that lists each order number followed by name of customer who made that order
SELECT a.onum,b.cname FROM Orders AS a JOIN Cust AS b ON a.cnum=b.cnum ORDER BY a.onum;

-- Write a query that finds all pairs of customers having the same rating
SELECT a.cname, b.cname,a.rating FROM Cust AS a JOIN Cust AS b WHERE a.rating = b.rating AND a.cnum != b.cnum AND a.cnum < b.cnum ORDER BY a.rating;

-- Write a query to find out all pairs of customers served by a single salesperson
SELECT a.cname,b.cname,c.sname,c.snum FROM Cust AS a,Cust AS b,Salespeople AS c WHERE a.snum = c.snum  AND a.cnum < b.cnum  ORDER BY c.snum ASC;

-- Write a query that produces all pairs of salespeople who are living in same city
SELECT a.sname, b.sname,a.city FROM Salespeople AS a JOIN Salespeople AS b WHERE a.city = b.city AND a.snum != b.snum;

-- Write a Query to find all orders credited to the same salesperson who services Customer 2008
SELECT * FROM Orders WHERE cnum = 2008;

-- Write a Query to find out all orders that are greater than the average for Oct 4th
SELECT * FROM Orders WHERE amt > (SELECT AVG(amt) FROM Orders WHERE odate= "1994-10-04");

-- Write a Query to find all orders attributed to salespeople in London.
SELECT * FROM Orders AS a JOIN Salespeople AS b ON a.snum = b.snum WHERE b.city = "London" ORDER BY a.onum;

-- Write a query to find all the customers whose cnum is 1000 above the snum of Serres. 
select cname from cust where cnum> 1000 and snum in (select snum from salespeople where sname='Serres');
Select cnum, cname from cust
where cnum > ( select snum+1000
                          from salespeople
                          where sname = 'Serres');
-- Write a query to count customers with ratings above San Jose’s average rating.
SELECT COUNT(cnum) FROM Cust WHERE rating > (SELECT AVG(rating) FROM Cust WHERE city = "San Jose");

-- Write a query to show each salesperson with multiple customers.
SELECT a.cname,b.sname FROM Cust AS a JOIN Salespeople AS b ON a.snum = b.snum WHERE a.cname <> a.cname AND a.snum = b.snum ; 
