create	 database project12;
use project12;
-- 2
CREATE TABLE Dept (
    Deptno INT PRIMARY KEY,           -- Unique Department Number
    Dname VARCHAR(50) NOT NULL,       -- Department Name
    Location VARCHAR(50)              -- Department Location (optional)
);
INSERT INTO Dept (Deptno, Dname, Location) VALUES
(10, 'Operations', 'New York'),
(20, 'Research', 'Dallas'),
(30, 'Sales', 'Chicago'),
(40, 'Accounting', 'Boston');
select * from Dept;
-- 1
CREATE TABLE Employee (
    Empno INT PRIMARY KEY,               -- Empno cannot be NULL or duplicate
    Ename VARCHAR(50) NOT NULL,          -- Assuming employee name is required
    Job VARCHAR(30) DEFAULT 'Clerk',     -- Default Job should be Clerk
    mgr int,
    hiredate date,
    Salary DECIMAL(10, 2) CHECK (Salary > 0), -- Salary must be greater than 0
    Deptno INT,                          -- Foreign key
    comm int,
    CONSTRAINT fk_dept FOREIGN KEY (Deptno) REFERENCES Dept(Deptno)
);
insert	into Employee (Empno,Ename ,Job ,mgr ,hiredate ,Salary , comm, Deptno ) values
 (7369,"Smith",default,7902,"1890-12-17",800,null,20),
 (7499,"Allen","Salesman",7698,"1981-02-20",1600,300,30),
(7521, 'WARD', 'SALESMAN', 7698, '1981-02-22', 1250.00, 500.00, 30),
(7566, 'JONES', 'MANAGER', 7839, '1981-04-02', 2975.00, NULL, 20),
(7654, 'MARTIN', 'SALESMAN', 7698, '1981-09-28', 1250.00, 1400.00, 30),
(7698, 'BLAKE', 'MANAGER', 7839, '1981-05-01', 2850.00, NULL, 30),
(7782, 'CLARK', 'MANAGER', 7839, '1981-06-09', 2450.00, NULL, 10),
(7788, 'SCOTT', 'ANALYST', 7566, '1987-04-19', 3000.00, NULL, 20),
(7839, 'KING', 'PRESIDENT', NULL, '1981-11-17', 5000.00, NULL, 10),
(7844, 'TURNER', 'SALESMAN', 7698, '1981-09-08', 1500.00, 0.00, 30),
(7876, 'ADAMS', default, 7788, '1987-05-23', 1100.00, NULL, 20),
(7900, 'JAMES', default, 7698, '1981-12-03', 950.00, NULL, 30),
(7902, 'FORD', 'ANALYST', 7566, '1981-12-03', 3000.00, NULL, 20),
(7934, 'MILLER', null, 7782, '1982-01-23', 1300.00, NULL, 10);
select * from Employee;
-- 3
SELECT Ename, Salary
FROM Employee
WHERE Salary > 1000;
-- 4
SELECT *
FROM Employee
WHERE hiredate < '1981-09-30';
-- 5
SELECT Ename
FROM Employee
WHERE Ename LIKE '_I%';
-- 6
SELECT 
    Ename AS "Employee Name",
    Salary AS "Salary",
    Salary * 0.40 AS "Allowances",
    Salary * 0.10 AS "P.F.",
    (Salary + Salary * 0.40 - Salary * 0.10) AS "Net Salary"
FROM Employee;
-- 7
SELECT Ename AS "Employee Name", job AS "Designation"
FROM Employee
WHERE mgr IS NULL;
-- 8
SELECT Empno AS "Emp No",
       Ename AS "Employee Name",
       salary AS "Salary"
FROM Employee
ORDER BY salary ASC;
-- 9
SELECT COUNT(DISTINCT job) AS "Total Jobs"
FROM Employee;
-- 10
SELECT SUM(salary) AS "Total Payable Salary"
FROM Employee
WHERE job= 'Salesman';
-- 11
SELECT Deptno AS "Department ID",
       job AS "Job Title",
       AVG(salary) AS "Avg Monthly Salary"
FROM Employee
GROUP BY Deptno, job;
-- 12
SELECT e.Ename   AS "Employee Name",
       e.Salary     AS "Salary",
       d.Dname   AS "Department Name"
FROM Employee e
JOIN Dept d 
    ON e.Deptno = d.Deptno;
    -- 13
    CREATE TABLE job_grades (
    grade CHAR(1) NOT NULL,
    lowest_sal DECIMAL(10,2) NOT NULL,
    highest_sal DECIMAL(10,2) NOT NULL
);

INSERT INTO job_grades (grade, lowest_sal, highest_sal) VALUES
('A', 0,      999),
('B', 1000,   1999),
('C', 2000,   2999),
('D', 3000,   3999),
('E', 4000,   4999);
select * from job_grades;
-- 14
SELECT e.Ename AS "Last Name",
       e.salary   AS "Salary",
       j.grade    AS "Grade"
FROM Employee e
JOIN job_grades j
  ON e.salary BETWEEN j.lowest_sal AND j.highest_sal;
  -- 15
  SELECT CONCAT(e.Ename, ' reports to ', IFNULL(m.Ename, 'No Manager')) AS "Emp Report to Mgr"
FROM Employee e
LEFT JOIN Employee m
       ON e.mgr = m.Empno;
 -- 16
 SELECT Ename AS "Employee Name",
       (salary + IFNULL(comm, 0)) AS "Total Salary"
FROM Employee;
-- 17
SELECT Ename AS "Employee Name",
         Salary
FROM Employee
WHERE Empno % 2 <> 0;
-- 18
SELECT Ename AS "Employee Name",
       Salary,
       Deptno AS "Dept No",
       RANK() OVER (ORDER BY salary DESC) AS "Org Salary Rank",
       RANK() OVER (PARTITION BY Deptno ORDER BY salary DESC) AS "Dept Salary Rank"
FROM Employee;
-- 19
SELECT Ename AS "Employee Name",
     Salary
FROM Employee
ORDER BY salary DESC
LIMIT 3;
-- 20
SELECT e.Ename AS "Employee Name",
       e.salary   AS "Salary",
       e.Deptno AS "Dept No"
FROM Employee e
JOIN (
    SELECT Deptno, MAX(salary) AS max_sal
    FROM Employee
    GROUP BY Deptno
) m
ON e.Deptno = m.Deptno
AND e.salary = m.max_sal;

-- project 2

create database project2;
use project2;
CREATE TABLE Salespeople (
    snum INT PRIMARY KEY,
    sname VARCHAR(50),
    city VARCHAR(50),
    comm DECIMAL(4,2)
);
INSERT INTO Salespeople (snum, sname, city, comm) VALUES
(1001, 'Peel', 'London', 0.12),
(1002, 'Serres', 'San Jose', 0.13),
(1003, 'Axelrod', 'New york', 0.10),
(1004, 'Motika', 'London', 0.11),
(1007, 'Rafkin', 'Barcelona', 0.15);
select * from Salespeople;
-- 2
CREATE TABLE Customers (
    cnum INT PRIMARY KEY,
    cname VARCHAR(50),
    city VARCHAR(50),
    rating INT,
    snum INT,
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);
INSERT INTO Customers (cnum, cname, city, rating, snum) VALUES
(2001, 'Hoffman', 'London', 100, 1001),
(2002, 'Giovanne', 'Rome', 200, 1003),
(2003, 'Liu', 'San Jose', 300, 1002),
(2004, 'Grass', 'Berlin', 100, 1002),
(2006, 'Clemens', 'London', 300, 1007),
(2007, 'Pereira', 'Rome', 100, 1004),
(2008, 'James', 'London', 200, 1007);
select * from Customers;
-- 3
CREATE TABLE Orders (
    onum INT PRIMARY KEY,
    amt DECIMAL(10,2),
    odate DATE,
    cnum INT,
    snum INT,
    FOREIGN KEY (cnum) REFERENCES Customers(cnum),
    FOREIGN KEY (snum) REFERENCES Salespeople(snum)
);
INSERT INTO Orders (onum, amt, odate, cnum, snum) VALUES
(3001, 18.69,  '1994-10-03', 2008, 1007),
(3002, 1900.10,'1994-10-03', 2007, 1004),
(3003, 767.19, '1994-10-03', 2001, 1001),
(3005, 5160.45,'1994-10-03', 2003, 1002),
(3006, 1098.16,'1994-10-04', 2008, 1007),
(3007, 75.75,  '1994-10-05', 2004, 1002),
(3008, 4723.00,'1994-10-05', 2006, 1001),
(3009, 1713.23,'1994-10-04', 2002, 1003),
(3010, 1309.95,'1994-10-06', 2004, 1002),
(3011, 989.88, '1994-10-06', 2006, 1001);
select * from Orders;
-- 4
SELECT 
    s.Sname AS Salesperson,
    c.Cname AS Customer,
    s.City
FROM 
    Salespeople s
JOIN 
    Customers c
    ON s.City = c.City;
-- 5
SELECT 
    c.Cname AS Customer,
    s.Sname AS Salesperson
FROM 
    Customers c
JOIN 
    Salespeople s
    ON c.Snum = s.Snum;
    -- 6
    SELECT 
    o.Onum AS OrderNumber,
    c.Cname AS Customer,
    c.City AS CustomerCity,
    s.Sname AS Salesperson,
    s.City AS SalespersonCity
FROM 
    Orders o
JOIN 
    Customers c ON o.Cnum = c.Cnum
JOIN 
    Salespeople s ON c.Snum = s.Snum
WHERE 
    c.City <> s.City;
    -- 7
    SELECT 
    o.Onum AS OrderNumber,
    c.Cname AS Customer
FROM 
    Orders o
JOIN 
    Customers c
    ON o.Cnum = c.Cnum;
    -- 8
    SELECT 
    c1.Cname AS Customer1,
    c2.Cname AS Customer2,
    c1.Rating
FROM 
    Customers c1
JOIN 
    Customers c2
    ON c1.Rating = c2.Rating
   AND c1.Cnum < c2.Cnum
ORDER BY 
    c1.Rating;
    -- 9
    SELECT 
    c1.Cname AS Customer1,
    c2.Cname AS Customer2,
    s.Sname AS Salesperson
FROM 
    Customers c1
JOIN 
    Customers c2
    ON c1.Snum = c2.Snum
   AND c1.Cnum < c2.Cnum
JOIN 
    Salespeople s
    ON c1.Snum = s.Snum
ORDER BY 
    s.Sname;

    -- 10
    SELECT 
    s1.Sname AS Salesperson1,
    s2.Sname AS Salesperson2,
    s1.City
FROM 
    Salespeople s1
JOIN 
    Salespeople s2
    ON s1.City = s2.City
   AND s1.Snum < s2.Snum
ORDER BY 
    s1.City;
    -- 11
    SELECT 
    o.Onum AS OrderNumber,
    o.Cnum AS CustomerNumber
FROM 
    Orders o
JOIN 
    Customers c
    ON o.Cnum = c.Cnum
WHERE 
    c.Snum = (
        SELECT Snum
        FROM Customers
        WHERE Cnum = 2008
    );
    -- 12
    SELECT 
    Onum,
    Odate,
    Amt
FROM 
    Orders
WHERE 
    Amt > (
        SELECT AVG(Amt)
        FROM Orders
        WHERE Odate = '1990-10-04'
    );
    -- 13
    SELECT 
    o.Onum AS OrderNumber,
    c.Cname AS Customer,
    s.Sname AS Salesperson,
    s.City
FROM 
    Orders o
JOIN 
    Customers c ON o.Cnum = c.Cnum
JOIN 
    Salespeople s ON c.Snum = s.Snum
WHERE 
    s.City = 'London';
    -- 14
    SELECT 
    c.Cnum,
    c.Cname,
    c.Snum
FROM 
    Customers c
WHERE 
    c.Cnum = (
        SELECT Snum + 1000
        FROM Salespeople
        WHERE Sname = 'Serres'
    );
    SELECT 
    c.Cnum,
    c.Cname,
    s.Sname AS Salesperson
FROM 
    Customers c
JOIN 
    Salespeople s ON c.Snum = s.Snum
WHERE 
    c.Cnum = (
        SELECT Snum + 1000
        FROM Salespeople
        WHERE Sname = 'Serres'
    );
    -- 15
    SELECT 
    COUNT(*) AS CustomersAboveSanJoseAvg
FROM 
    Customers
WHERE 
    Rating > (
        SELECT AVG(Rating)
        FROM Customers
        WHERE City = 'San Jose'
    );
    SELECT 
    Cname,
    City,
    Rating
FROM 
    Customers
WHERE 
    Rating > (
        SELECT AVG(Rating)
        FROM Customers
        WHERE City = 'San Jose'
    );
    -- 16
    SELECT 
    s.Sname AS Salesperson,
    COUNT(c.Cnum) AS NumberOfCustomers
FROM 
    Salespeople s
JOIN 
    Customers c ON s.Snum = c.Snum
GROUP BY 
    s.Snum, s.Sname
HAVING 
    COUNT(c.Cnum) > 1;
    