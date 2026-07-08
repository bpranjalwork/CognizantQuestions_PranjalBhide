-- =====================================================================
-- COGNIZANT DIGITAL NURTURE 5.0 - WEEK 2: STORED PROCEDURES (MYSQL)
-- =====================================================================

-- ---------------------------------------------------------------------
-- DATABASE SETUP & SAMPLE DATA
-- ---------------------------------------------------------------------
CREATE DATABASE IF NOT EXISTS EmployeeDB;
USE EmployeeDB;

-- Drop tables if they already exist to ensure a clean slate
DROP TABLE IF EXISTS Employees;
DROP TABLE IF EXISTS Departments;

-- Create Departments Table [cite: 4, 5, 6]
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
); [cite: 7, 8]

-- Create Employees Table [cite: 9, 10, 11]
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    DepartmentID INT,
    Salary DECIMAL(10,2),
    JoinDate DATE,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID) [cite: 12, 13, 14, 15, 16, 17]
);

-- Insert Sample Data into Departments [cite: 20, 21]
INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'HR'),
(2, 'Finance'),
(3, 'IT'),
(4, 'Marketing'); [cite: 22, 23, 24, 25]

-- Insert Sample Data into Employees [cite: 26, 27, 28]
INSERT INTO Employees (EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate) VALUES
(1, 'John', 'Doe', 1, 5000.00, '2020-01-15'),
(2, 'Jane', 'Smith', 2, 6000.00, '2019-03-22'), [cite: 29, 30]
(3, 'Michael', 'Johnson', 3, 7000.00, '2018-07-30'),
(4, 'Emily', 'Davis', 4, 5500.00, '2021-11-05'); [cite: 31]


-- ---------------------------------------------------------------------
-- EXERCISE 1: CREATE A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Retrieve employee details by department [cite: 34]
DROP PROCEDURE IF EXISTS sp_GetEmployeesByDepartment;

DELIMITER //

CREATE PROCEDURE sp_GetEmployeesByDepartment(IN p_DepartmentID INT) [cite: 36]
BEGIN
    SELECT EmployeeID, FirstName, LastName, JoinDate 
    FROM Employees
    WHERE DepartmentID = p_DepartmentID; [cite: 37]
END //

DELIMITER ;


-- ---------------------------------------------------------------------
-- EXERCISE 2: MODIFY A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Include employee salary in the result [cite: 49]
-- Note: In MySQL, modification is done by dropping and recreating.
DROP PROCEDURE IF EXISTS sp_GetEmployeesByDepartment;

DELIMITER //

CREATE PROCEDURE sp_GetEmployeesByDepartment(IN p_DepartmentID INT)
BEGIN
    SELECT EmployeeID, FirstName, LastName, JoinDate, Salary -- Added Salary column [cite: 52]
    FROM Employees
    WHERE DepartmentID = p_DepartmentID;
END //

DELIMITER ;


-- ---------------------------------------------------------------------
-- EXERCISE 4: EXECUTE A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Execute the procedure for a specific department [cite: 60]
-- Testing with DepartmentID = 3 (IT)
CALL sp_GetEmployeesByDepartment(3); 


-- ---------------------------------------------------------------------
-- EXERCISE 3: DELETE A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Delete the stored procedure created in Exercise 1 [cite: 55]
-- Commented out so it doesn't break subsequent steps, uncomment to use:
-- DROP PROCEDURE IF EXISTS sp_GetEmployeesByDepartment; [cite: 57]


-- ---------------------------------------------------------------------
-- EXERCISE 5: RETURN DATA FROM A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Returns the total number of employees in a department [cite: 65]
DROP PROCEDURE IF EXISTS sp_GetEmployeeCountByDepartment;

DELIMITER //

CREATE PROCEDURE sp_GetEmployeeCountByDepartment(IN p_DepartmentID INT) [cite: 68]
BEGIN
    SELECT COUNT(*) AS TotalEmployees 
    FROM Employees
    WHERE DepartmentID = p_DepartmentID; [cite: 69]
END //

DELIMITER ;

-- Test Execution:
CALL sp_GetEmployeeCountByDepartment(1);


-- ---------------------------------------------------------------------
-- EXERCISE 6: USE OUTPUT PARAMETERS IN A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Return the total salary of a department using an OUT parameter [cite: 72]
DROP PROCEDURE IF EXISTS sp_GetTotalSalaryByDepartment;

DELIMITER //

CREATE PROCEDURE sp_GetTotalSalaryByDepartment(
    IN p_DepartmentID INT, 
    OUT p_TotalSalary DECIMAL(10,2) [cite: 74]
)
BEGIN
    SELECT SUM(Salary) INTO p_TotalSalary [cite: 75]
    FROM Employees
    WHERE DepartmentID = p_DepartmentID;
END //

DELIMITER ;

-- Test Execution:
CALL sp_GetTotalSalaryByDepartment(1, @out_total_salary);
SELECT @out_total_salary AS DepartmentTotalSalary;


-- ---------------------------------------------------------------------
-- EXERCISE 7: CREATE A STORED PROCEDURE WITH MULTIPLE PARAMETERS
-- ---------------------------------------------------------------------
-- Goal: Create a stored procedure to update employee salary [cite: 78]
DROP PROCEDURE IF EXISTS sp_UpdateEmployeeSalary;

DELIMITER //

CREATE PROCEDURE sp_UpdateEmployeeSalary(
    IN p_EmployeeID INT, 
    IN p_NewSalary DECIMAL(10,2) [cite: 82]
)
BEGIN
    UPDATE Employees
    SET Salary = p_NewSalary
    WHERE EmployeeID = p_EmployeeID;
END //

DELIMITER ;

-- Test Execution from handbook template[cite: 84]:
CALL sp_UpdateEmployeeSalary(1, 5500.00); 


-- ---------------------------------------------------------------------
-- EXERCISE 8: CREATE A STORED PROCEDURE WITH CONDITIONAL LOGIC
-- ---------------------------------------------------------------------
-- Goal: Give a bonus to employees based on their department [cite: 86]
DROP PROCEDURE IF EXISTS sp_GiveBonus;

DELIMITER //

CREATE PROCEDURE sp_GiveBonus(
    IN p_DepartmentID INT, 
    IN p_BonusAmount DECIMAL(10,2) [cite: 90]
)
BEGIN
    UPDATE Employees
    SET Salary = Salary + p_BonusAmount
    WHERE DepartmentID = p_DepartmentID;
END //

DELIMITER ;

-- Test Execution from handbook template[cite: 92]:
CALL sp_GiveBonus(1, 500.00);


-- ---------------------------------------------------------------------
-- EXERCISE 9 & 11: TRANSACTIONS & ERROR HANDLING
-- ---------------------------------------------------------------------
-- Goal: Ensure data integrity via transactions and handle runtime errors [cite: 94, 106]
DROP PROCEDURE IF EXISTS sp_UpdateSalaryWithTransactionAndErrors;

DELIMITER //

CREATE PROCEDURE sp_UpdateSalaryWithTransactionAndErrors(
    IN p_EmployeeID INT, 
    IN p_NewSalary DECIMAL(10,2) [cite: 96, 109]
)
BEGIN
    -- Declare a handler to catch exceptions, rollback and exit [cite: 111]
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK; -- Undo changes if error occurs [cite: 98]
        SELECT 'An unexpected error occurred. Transaction rolled back.' AS StatusMessage;
    END;

    -- Custom rule processing (Exercise 11 handling negative bounds explicitly)
    IF p_NewSalary < 0 THEN
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Custom Error: Salary value cannot be negative.'; [cite: 111]
    END IF;

    -- Start explicit Transaction boundary [cite: 98]
    START TRANSACTION;
    
    UPDATE Employees
    SET Salary = p_NewSalary [cite: 97, 110]
    WHERE EmployeeID = p_EmployeeID;
        
    COMMIT; -- Save changes permanently
END //

DELIMITER ;

-- Test Execution:
CALL sp_UpdateSalaryWithTransactionAndErrors(2, 6200.00);


-- ---------------------------------------------------------------------
-- EXERCISE 10: USE DYNAMIC SQL IN A STORED PROCEDURE
-- ---------------------------------------------------------------------
-- Goal: Retrieve employee details based on a flexible runtime filter [cite: 101]
DROP PROCEDURE IF EXISTS sp_GetEmployeesDynamic;

DELIMITER //

CREATE PROCEDURE sp_GetEmployeesDynamic(
    IN p_FilterColumn VARCHAR(50), 
    IN p_FilterValue VARCHAR(50) [cite: 103]
)
BEGIN
    -- Safely prepare the dynamic string construct
    SET @sql_query = CONCAT('SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary, JoinDate FROM Employees WHERE ', p_FilterColumn, ' = ?'); [cite: 104]
    SET @target_val = p_FilterValue;
    
    -- Execute dynamic statements safely in MySQL
    PREPARE stmt FROM @sql_query;
    EXECUTE stmt USING @target_val;
    DEALLOCATE PREPARE stmt;
END //

DELIMITER ;

-- Test Execution:
CALL sp_GetEmployeesDynamic('LastName', 'Smith');