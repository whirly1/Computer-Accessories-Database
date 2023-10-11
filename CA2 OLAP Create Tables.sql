USE CompAccInc_DWGLENN

CREATE TABLE ProductCategoryDIM 
(CATEGORY_ID INT NOT NULL,
CATEGORY_NAME VARCHAR(20) NOT NULL,
PRIMARY KEY (CATEGORY_ID))

CREATE TABLE ProductDIM
(PRODUCT_ID INT NOT NULL PRIMARY KEY,
QUANTITY INT,
PRODUCT_NAME VARCHAR(100) NOT NULL,
DESCRIPTION VARCHAR(200) NOT NULL,
CATEGORY_ID INT NOT NULL,
FOREIGN KEY (CATEGORY_ID) REFERENCES ProductCategoryDIM(CATEGORY_ID))

CREATE TABLE EmployeeDIM
(EMPLOYEE_ID INT NOT NULL,
FIRST_NAME VARCHAR(50) NOT NULL,
LAST_NAME VARCHAR(50) NOT NULL, 
EMAIL VARCHAR(100) NOT NULL,
PHONE VARCHAR(20) NOT NULL,
HIRE_DATE DATETIME NOT NULL,
MANAGER_ID INT,
JOB_TITLE VARCHAR(100) NOT NULL,
PRIMARY KEY (EMPLOYEE_ID))

CREATE TABLE OrderDIM
(ORDER_ID INT NOT NULL PRIMARY KEY,
STATUS VARCHAR(10) NOT NULL)

CREATE TABLE CustomerDIM
(CUSTOMER_ID INT NOT NULL PRIMARY KEY,
NAME VARCHAR(100) NOT NULL,
ADDRESS VARCHAR(255) NOT NULL,
WEBSITE VARCHAR(100) NOT NULL,
CREDIT_LIMIT DECIMAL(10,2) NOT NULL)

CREATE TABLE ContactDIM
(CONTACT_ID INT PRIMARY KEY,
FIRST_NAME VARCHAR(100) NOT NULL, 
LAST_NAME VARCHAR(100) NOT NULL,
EMAIL VARCHAR(100) NOT NULL,
PHONE VARCHAR(20) NOT NULL,
CUSTOMER_ID INT NOT NULL,
FOREIGN KEY (CUSTOMER_ID) REFERENCES CustomerDIM(CUSTOMER_ID))

CREATE TABLE TimeDIM
(TIME_ID INT NOT NULL PRIMARY KEY,
[DATE] DATETIME NOT NULL,
[DAYOFWEEK] CHAR(1) NOT NULL,
[DAYOFMONTH] VARCHAR(2) NOT NULL,
[MONTH] VARCHAR(2) NOT NULL,
[QUARTER] CHAR(1) NOT NULL,
[YEAR] CHAR(4) NOT NULL)

CREATE TABLE SalesFacts
(TIME_ID INT NOT NULL,
PRODUCT_ID INT NOT NULL,
ORDER_ID INT NOT NULL,
EMPLOYEE_ID INT NOT NULL,
CUSTOMER_ID INT NOT NULL,
ITEM_ID INT NOT NULL,
QUANTITY INT NOT NULL,
UNIT_PRICE DECIMAL(10,2) NOT NULL,
LIST_PRICE DECIMAL(10,2) NOT NULL,
STANDARD_COST DECIMAL(10,2) NOT NULL,
CONSTRAINT SALES_ID PRIMARY KEY (TIME_ID,PRODUCT_ID,ORDER_ID,EMPLOYEE_ID,CUSTOMER_ID,ITEM_ID),
FOREIGN KEY (TIME_ID) REFERENCES TimeDIM(TIME_ID),
FOREIGN KEY (PRODUCT_ID) REFERENCES ProductDIM(PRODUCT_ID),
FOREIGN KEY (ORDER_ID) REFERENCES OrderDIM(ORDER_ID),
FOREIGN KEY (EMPLOYEE_ID) REFERENCES EmployeeDIM(EMPLOYEE_ID),
FOREIGN KEY (CUSTOMER_ID) REFERENCES CustomerDIM(CUSTOMER_ID))