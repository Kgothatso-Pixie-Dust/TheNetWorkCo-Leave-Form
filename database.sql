CREATE DATABASE NetWorkCoDB;

USE NetWorkCoDB;


CREATE TABLE EMPLOYEE(
    EMPLOYEE_ID INT PRIMARY KEY,
    FULL_NAME CHAR(30) NOT NULL,
    DOB DATE,
    GENDER ENUM("Male", "Female"),
    DEPARTMENT_ID INT,
    SALARY DECIMAL(10, 2),
    HIREDATE DATE,    
    ADDRESS CHAR(35),
    CITY CHAR(35),
    STATE CHAR(2),
    POSTAL_CODE CHAR(5),
    PHONE VARCHAR(20),

);

CREATE TABLE EMPLOYEE_LOGIN(
    USER_ID INT PRIMARY KEY,
    USERNAME  VARCHAR(50) NOT NULL UNIQUE,
    EMAIL VARCHAR(100) NOT NULL UNIQUE,
    PASSWORD  VARCHAR(255) NOT NULL
);

CREATE TABLE JOB_DETAILS( 
    EMPLOYEE_ID INT NOT NULL,
    FULL_NAME CHAR(30) NOT NULL,
    INTERN_POS VARCHAR(255) NOT NULL,
    COMP_POSITION VARCHAR(255) NOT NULL,
    SUPER_NAME VARCHAR(255) NOT NULL,
    DEPART VARCHAR(255) NULL,
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID),
    FOREIGN KEY (FULL_NAME) REFERENCES EMPLOYEE(FULL_NAME)     

);
CREATE TABLE LEAVE_REQUEST (  
    LEAVE_REQUEST_NUM INT AUTO_INCREMENT PRIMARY KEY,  
    EMPLOYEE_ID INT NOT NULL,  
    FULL_NAME CHAR(30) NOT NULL,  
    INTERN_POS CHAR(255) NOT NULL,  
    COMP_NAME CHAR(255) NOT NULL,  
    SUPER_NAME CHAR(255) NOT NULL,  
    START_DATE DATE,  
    END_DATE DATE,  
    DAYS_ABSENT INT,
    REMAIN_LEAVE_DAYS INT,
    ACADEM_COMMIT BOOLEAN DEFAULT FALSE,    
    PERSONAL_REAS BOOLEAN DEFAULT FALSE,  
    MEDICAL_REAS BOOLEAN DEFAULT FALSE,  
    OTHER CHAR(255), 
    WORK_HAND_PLAN CHAR(100),  
    CREATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  
    UPDATED_AT TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,  
    FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE(EMPLOYEE_ID) 
);

INSERT INTO EMPLOYEE
VALUES
(101,'Northfold Liam','9 Old Mill Rd.','Londonderry','NH','03053','603-555-7563');
INSERT INTO EMPLOYEE
VALUES
(102,'Ocean Arnold','2332 South St. Apt 3','Springfield','MA','01101','413-555-3212');
INSERT INTO EMPLOYEE
VALUES
(103,'Kasuma Sujata','132 Main St. #1','East Hartford','CT','06108','860-555-0703');
INSERT INTO EMPLOYEE
VALUES
(104,'Goff Ryan','164A South Bend Rd.','Lowell','MA','01854','781-555-8423');
INSERT INTO EMPLOYEE
VALUES
(105,'McLean Kyle','345 Lower Ave.','Wolcott','NY','14590','585-555-5321');
INSERT INTO EMPLOYEE
VALUES
(106,'Morontoia Joseph','156 Scholar St.','Johnston','RI','02919','401-555-4848');
INSERT INTO EMPLOYEE
VALUES
(107,'Marchand Quinn','76 Cross Rd.','Bath','NH','03740','603-555-0456');

INSERT INTO JOB_DETAILS (EMPLOYEE_ID, FULL_NAME, INTERN_POS, COMP_NAME, SUPER_NAME, DEPART) VALUES  
(101, 'Northfold Liam','Software Intern', 'Junior Developer', 'John Smith', 'Development'), 
(102,'Ocean Arnold','Marketing Intern', 'Marketing Coordinator', 'Jane Doe', 'Marketing'),  
(103, 'Kasuma Sujata','Data Analyst Intern', 'Data Analyst', 'Alice Johnson', 'Analytics'),  
(104, 'Goff Ryan','Research Intern', 'Researcher', 'Bob Brown', 'Research and Development'),  
(105, 'McLean Kyle','Design Intern', 'Graphic Designer', 'Charlie Davis', 'Design'),  
(106, 'Morontoia Joseph','HR Intern', 'HR Assistant', 'Diana Prince', 'Human Resources'),  
(107,'Marchand Quinn','Finance Intern', 'Financial Analyst', 'Edward White', 'Sales');  

INSERT INTO LEAVE_REQUEST (EMPLOYEE_ID, FULL_NAME, INTERN_POS, COMP_NAME, SUPER_NAME, START_DATE, END_DATE,DAYS_ABSENT, REMAIN_LEAVE_DAYS, ACADEM_COMMIT, PERSONAL_REAS, MEDICAL_REAS, OTHER, WORK_HAND_PLAN) VALUES   
(101, 'Northfold Liam', 'Software Intern', 'Junior Developer', 'John Smith', '2025-03-20', '2025-03-25',  DATEDIFF('2025-03-25', '2025-03-20') + 1, 30 - (DATEDIFF('2025-03-25', '2025-03-20')) + 1, FALSE, TRUE, FALSE, 'Family Emergency', 'Plan to delegate tasks to the team.'),  
(102, 'Ocean Arnold', 'Marketing Intern', 'Marketing Coordinator', 'Jane Doe', '2025-04-01', '2025-04-05', DATEDIFF('2025-04-05', '2025-04-01') + 1, 30 - (DATEDIFF('2025-04-05', '2025-04-01')) + 1, FALSE, FALSE, TRUE, 'Doctor Appointment', 'Will inform the manager about my availability.'),  
(103, 'Kasuma Sujata', 'Data Analyst Intern', 'Data Analyst', 'Alice Johnson', '2025-04-10', '2025-04-15', DATEDIFF('2025-04-15', '2025-04-10') + 1, 30 - (DATEDIFF('2025-04-15', '2025-04-10'_)) + 1, TRUE, FALSE, FALSE, 'Academic Conference', 'I will check emails periodically.'),  
(105, 'McLean Kyle', 'Design Intern', 'Graphic Designer', 'Charlie Davis', '2025-05-01', '2025-05-07',DATEDIFF('2025-05-07', '2025-05-01') + 1, 30 - (DATEDIFF('2025-05-07', '2025-05-01')) + 1, TRUE, FALSE, FALSE, 'School Project Presentation', 'Coordinate with colleagues on project completion.'),  

SELECT user FROM mysql.user;
