-------------- GROUP 3: BANK DATABASE -----------------------------------------------------------------------------------
-- name, email, addressno, street, district, city, region, home_addr, off_addr: use VARCHAR with length enough for sample data
-- code as primary key in table BRANCH, EMPLOYEE, CUSTOMER: use CHAR of fixed length 7
-- dob, serve_date, date: use DATE in format "DD/MM/YYYY"
-- number in ACCOUNT: use SERIAL type in Postgre (which is INT with AUTO_INCREMENT)
-- (code, type) in ACCOUNT_TYPE: indicate type of account (1, Saving Account), (2, Checking Account), (3, Loan Account)
-- balance in SAVING_ACCOUNT, CHECKING_ACCOUNT, LOAN_ACCOUNT: use NUMERIC(10, 2) for conveniently displaying and CHECK >= 0
-- insrate in SAVING_ACCOUNT, LOAN_ACCOUNT: use NUMBERIC(3, 2) and CHECK 0 <= insrate <= 100

--------------------------------------- Part 1A: Physical Database Design------------------------------------------------
DROP TABLE IF EXISTS Branch CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;
DROP TABLE IF EXISTS Customer CASCADE;
DROP TABLE IF EXISTS Account CASCADE;
DROP TABLE IF EXISTS Account_type CASCADE;
DROP TABLE IF EXISTS Saving_account CASCADE;
DROP TABLE IF EXISTS Checking_account CASCADE;
DROP TABLE IF EXISTS Loan CASCADE;
DROP TABLE IF EXISTS Branch_phone CASCADE;
DROP TABLE IF EXISTS Branch_fax CASCADE;
DROP TABLE IF EXISTS Employee_phone CASCADE;
DROP TABLE IF EXISTS Customer_phone CASCADE;


CREATE TABLE Branch (
	name			VARCHAR(20)		PRIMARY KEY,
	email			VARCHAR(30)		NOT NULL UNIQUE,
	addressno		VARCHAR(10),
	street			VARCHAR(20),
	district		VARCHAR(10),
	city			VARCHAR(20),
	region			VARCHAR(20),
	manager_code	CHAR(7)			NOT NULL,
	total_emp		INT				NOT NULL DEFAULT 0
);

CREATE TABLE Employee (
	code			CHAR(7)			PRIMARY KEY,
	fname			VARCHAR(15)		NOT NULL,
	lname			VARCHAR(15)		NOT NULL,
	email			VARCHAR(30)		NOT NULL UNIQUE,
	addressno		VARCHAR(10),
	street			VARCHAR(20),
	district		VARCHAR(10),
	city			VARCHAR(20),
	dob				DATE,
	branch_name		VARCHAR(20)		NOT NULL,
	CONSTRAINT fk_emp_branch FOREIGN KEY (branch_name)
							 REFERENCES Branch(name)
							 ON UPDATE CASCADE
							 ON DELETE CASCADE DEFERRABLE
);

ALTER TABLE Branch
ADD CONSTRAINT fk_branch_manager FOREIGN KEY (manager_code)
								 REFERENCES Employee(code)
								 ON UPDATE CASCADE
								 ON DELETE CASCADE DEFERRABLE;

CREATE TABLE Customer (
	code			CHAR(7)			PRIMARY KEY,
	fname			VARCHAR(15)		NOT NULL,
	lname			VARCHAR(15)		NOT NULL,
	email			VARCHAR(30)		NOT NULL UNIQUE,
	home_addr		VARCHAR(50),
	off_addr		VARCHAR(50),
	emp_code		CHAR(7),
	serve_date		DATE			DEFAULT CURRENT_DATE,
	CONSTRAINT fk_cust_emp_serve FOREIGN KEY (emp_code)
								 REFERENCES Employee(code)
								 ON UPDATE CASCADE
								 ON DELETE SET NULL DEFERRABLE
);

CREATE TABLE Account (
	number 			SERIAL 			PRIMARY KEY,
	acc_type_code	INT,
	cust_code		CHAR(7),
	CONSTRAINT unique_account_type UNIQUE (number, acc_type_code),
	CONSTRAINT fk_acc_cust_code FOREIGN KEY (cust_code)
								REFERENCES Customer(code)
								ON UPDATE CASCADE
								ON DELETE SET NULL DEFERRABLE
);

CREATE TABLE Account_type (
	code			INT					PRIMARY KEY,
	type			VARCHAR(20)			NOT NULL
);

ALTER TABLE Account
ADD CONSTRAINT fk_acc_type_code FOREIGN KEY (acc_type_code)
							REFERENCES Account_type(code)
							ON UPDATE CASCADE
							ON DELETE SET NULL DEFERRABLE;

CREATE TABLE Saving_account (
	number			SERIAL				PRIMARY KEY,
	code			INT					NOT NULL DEFAULT 1 CHECK(code = 1),		--Saving account
	date			DATE				DEFAULT CURRENT_DATE,
	balance			NUMERIC(10, 2)		DEFAULT 0,
	insrate			NUMERIC(5, 2)		DEFAULT 0,
	CHECK(insrate >= 0 AND insrate <= 100 AND balance >= 0),
	CONSTRAINT fk_saving_acc_code FOREIGN KEY (number, code)
								  REFERENCES Account(number, acc_type_code)
								  ON UPDATE CASCADE
								  ON DELETE CASCADE DEFERRABLE
);

CREATE TABLE Checking_account (
	number			SERIAL				PRIMARY KEY,
	code			INT					NOT NULL DEFAULT 2 CHECK(code = 2),		--Checking account,
	date			DATE				DEFAULT CURRENT_DATE,
	balance			NUMERIC(10, 2)		DEFAULT 0 CHECK(balance >= 0),
	CONSTRAINT fk_checking_acc_code FOREIGN KEY (number, code)
									REFERENCES Account(number, acc_type_code)
									ON UPDATE CASCADE
									ON DELETE CASCADE DEFERRABLE
);

CREATE TABLE Loan (
	number			SERIAL				PRIMARY KEY,
	code			INT					NOT NULL DEFAULT 3 CHECK(code = 3),		--Loan account,
	date			DATE				DEFAULT CURRENT_DATE,
	balance			NUMERIC(10, 2) 		DEFAULT 0,
	insrate			NUMERIC(5, 2)		DEFAULT 0,
	CHECK(insrate >= 0 AND insrate <= 100 AND balance >= 0),
	CONSTRAINT fk_loan_acc_code FOREIGN KEY (number, code)
								REFERENCES Account(number, acc_type_code)
								ON UPDATE CASCADE
								ON DELETE CASCADE DEFERRABLE
);

CREATE TABLE Branch_phone (
	branch_name		VARCHAR(20),
	phone			CHAR(10),
	PRIMARY KEY (branch_name, phone),
	CONSTRAINT fk_name_branch_phone FOREIGN KEY (branch_name)
									REFERENCES Branch(name)
									ON UPDATE CASCADE
									ON DELETE CASCADE DEFERRABLE
);

CREATE TABLE Branch_fax (
	branch_name		VARCHAR(20),
	fax				CHAR(10),
	PRIMARY KEY (branch_name, fax),
	CONSTRAINT fk_name_branch_fax FOREIGN KEY (branch_name)
								  REFERENCES Branch(name)
								  ON UPDATE CASCADE
								  ON DELETE CASCADE DEFERRABLE
);

CREATE TABLE Employee_phone (
	emp_code		CHAR(7),
	phone			CHAR(10),
	PRIMARY KEY (emp_code, phone),
	CONSTRAINT fk_code_emp_phone FOREIGN KEY (emp_code)
								 REFERENCES Employee(code)
								 ON UPDATE CASCADE
								 ON DELETE CASCADE DEFERRABLE
);

CREATE TABLE Customer_phone (
	cust_code		CHAR(7),
	phone			CHAR(10),
	PRIMARY KEY (cust_code, phone),
	CONSTRAINT fk_code_cust_phone FOREIGN KEY (cust_code)
								  REFERENCES Customer(code)
								  ON UPDATE CASCADE
								  ON DELETE CASCADE DEFERRABLE
);

-- Derived total number of employees in branch------------------------------------
-- Function ----------------------------------------------
CREATE OR REPLACE FUNCTION func_insert_employee()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
	$$
	BEGIN
		UPDATE Branch
		SET total_emp = total_emp + 1
		WHERE name = NEW.branch_name;

		RETURN NEW;
	END;
	$$;

CREATE OR REPLACE FUNCTION func_update_employee()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
	$$
	BEGIN
		UPDATE Branch
		SET total_emp = total_emp - 1
		WHERE name = OLD.branch_name;

		UPDATE Branch
		SET total_emp = total_emp + 1
		WHERE name = NEW.branch_name;

		RETURN NEW;
	END;
	$$;

CREATE OR REPLACE FUNCTION func_delete_employee()
	RETURNS TRIGGER
	LANGUAGE PLPGSQL
	AS
	$$
	BEGIN
		UPDATE Branch
		SET total_emp = total_emp - 1
		WHERE name = OLD.branch_name;

		RETURN NEW;
	END;
	$$;

-- Trigger ------------------------------------------------
CREATE TRIGGER Insert_employee
	AFTER INSERT
	ON Employee
	FOR EACH ROW
	EXECUTE PROCEDURE func_insert_employee();

CREATE TRIGGER Update_employee
	AFTER UPDATE
	ON Employee
	FOR EACH ROW
	EXECUTE PROCEDURE func_update_employee();

CREATE TRIGGER Delete_employee
	AFTER DELETE
	ON Employee
	FOR EACH ROW
	EXECUTE PROCEDURE func_delete_employee();

-------------------------------------------- Part 1B: Insert Data ------------------------------------------------------
SET CONSTRAINTS fk_emp_branch  DEFERRED;
SET CONSTRAINTS fk_branch_manager  DEFERRED;
SET CONSTRAINTS fk_cust_emp_serve  DEFERRED;
SET CONSTRAINTS fk_acc_cust_code  DEFERRED;
SET CONSTRAINTS fk_saving_acc_code  DEFERRED;
SET CONSTRAINTS fk_checking_acc_code  DEFERRED;
SET CONSTRAINTS fk_loan_acc_code  DEFERRED;
SET CONSTRAINTS fk_name_branch_phone  DEFERRED;
SET CONSTRAINTS fk_name_branch_fax  DEFERRED;
SET CONSTRAINTS fk_code_emp_phone  DEFERRED;
SET CONSTRAINTS fk_code_cust_phone  DEFERRED;
SET CONSTRAINTS fk_acc_type_code  DEFERRED;

SET datestyle = "ISO, DMY";

-- Set account type
INSERT INTO Account_type VALUES (1, 'Saving Account');
INSERT INTO Account_type VALUES (2, 'Checking Account');
INSERT INTO Account_type VALUES (3, 'Loan Account');

INSERT INTO Branch VALUES ('MCK' , 'mck@bank.com' , '225', 'LTK' , 'Orange' , 'California' , 'Asian','emp0001');
INSERT INTO Branch VALUES ('GDK' , 'gdk@bank.com' , '275', 'THT' , 'District 5' , 'New York' , 'North America', 'emp0002');
INSERT INTO Branch VALUES ('RPT' , 'rpt@bank.com' , '3625', 'THD' , 'Bronz' , 'London' , 'Europe', 'emp0002');
INSERT INTO Branch VALUES ('BKIT' , 'bkit@bank.com' , '2547', 'TT' , 'Vux Daij' , 'Wakanda' , 'Africa', 'emp0003');
INSERT INTO Branch VALUES ('OISP' , 'oisp@bank.com' , '1103', 'BV' , 'Kanzz' , 'Melbourne' , 'Australia', 'emp0004');

INSERT INTO Employee VALUES ('emp0001', 'John', 'Smith', 'john@smith.com', '236', 'Fondren', 'Houston', 'M City', '07/01/1998','MCK');
INSERT INTO Employee VALUES ('emp0002', 'T', 'Wong', 'wong@gmail.com', '638', 'Voss', 'Houston', 'M City', '08/12/1955','GDK');
INSERT INTO Employee VALUES ('emp0003', 'Alicia', 'Zelaya', 'zelaya@gmail.com', '3321', 'Castle', 'Spring', 'TX', '19/07/1968','BKIT');
INSERT INTO Employee VALUES ('emp0004', 'Jennifer', 'Wallace', 'jenn@gmail.com', '291', 'Berry', 'Bellaire', 'TX', '20/06/1941','OISP');
INSERT INTO Employee VALUES ('emp0005', 'K', 'Narayan', 'k@gmail.com', '23', 'Oak', 'Humble', 'TX', '20/06/1941','MCK');
INSERT INTO Employee VALUES ('emp0006', 'Joyce', 'English', 'joyce@gmail.com', '5631', 'Rice', 'Houston', 'F', '31/07/1972','RPT');
INSERT INTO Employee VALUES ('emp0007', 'Ahmad', 'Jabbar', '987987987@gmail.com', '980', 'Dallas', 'Houston', 'TX', '29/03/1969','OISP');
INSERT INTO Employee VALUES ('emp0008', 'James', 'Nhuan', '888665555@gmail.com', '450', 'Stone', 'Houston', 'TX', '10/11/1973','GDK');

INSERT INTO Customer VALUES ('cus0001', 'Hieu', 'Le', 'trunghieult1807@gmail.com', '290/1 Ap Chien Luoc, Binh Hung Hoa District, HCMC', '268 Ly Thuong Kiet, District 10, HCMC', 'emp0001');
INSERT INTO Customer VALUES ('cus0002', 'Thanh', 'Nguyen', 'thanhnguyen2612@gmail.com', '123 CC An Lac, Go Vap District, HCMC', '26	8 Ly Thuong Kiet, District 10, HCMC', 'emp0006');
INSERT INTO Customer VALUES ('cus0003', 'Huy', 'Le', 'leduchuy@gmail.com', 'New Town, HCMC', 'Vinpearl Land', 'emp0002');
INSERT INTO Customer VALUES ('cus0004', 'Nhi', 'Hoai', 'hoainhicutephomaique@gmail.com', 'Bun Bo Co Bi, Truong Trinh Street', 'Sai Gon Cua Anh', 'emp0002');
INSERT INTO Customer VALUES ('cus0005', 'Naruto', 'Sasuke', 'pandaaaaa@gmail.com', 'Bellaire', 'Joy', 'emp0004');
INSERT INTO Customer VALUES ('cus0006', 'Tahm', 'Kench', 'besttahmkench@gmail.com', 'Stafford', 'Ramesh', 'emp0007');
INSERT INTO Customer VALUES ('cus0007', 'Siu', 'Nhan', 'siunhangao@gmail.com', '731 Fondren, Houston, TX', '5631 Rice, Houston, TX', 'emp0008');
INSERT INTO Customer VALUES ('cus0008', 'Xinchao', 'Moinguoi', 'xinchaomoinguoi1807@gmail.com', '3321 Castle, Spring, TX', '450 Stone, Houston, TX', 'emp0003');
INSERT INTO Customer VALUES ('cus0009', 'Nguyen Van', 'A', 'nguyenvanaaaaa@gmail.com', '213 Loneliness, Tlenen, TX', '450 Histen, Porkie, TX', 'emp0005');

INSERT INTO Account VALUES (1,1,'cus0001');
INSERT INTO Account VALUES (2,2,'cus0002');
INSERT INTO Account VALUES (3,3,'cus0003');
INSERT INTO Account VALUES (4,1,'cus0004');
INSERT INTO Account VALUES (5,3,'cus0005');
INSERT INTO Account VALUES (6,1,'cus0006');
INSERT INTO Account VALUES (7,2,'cus0007');
INSERT INTO Account VALUES (8,1,'cus0008');
INSERT INTO Account VALUES (9,1,'cus0009');
INSERT INTO Account VALUES (10,2,'cus0005');
INSERT INTO Account VALUES (11,3,'cus0005');
INSERT INTO Account VALUES (12,2,'cus0004');
INSERT INTO Account VALUES (13,2,'cus0009');
INSERT INTO Account VALUES (14,3,'cus0009');


INSERT INTO Saving_account VALUES (1,1,'10/12/2019','10500000', '11');
INSERT INTO Saving_account VALUES (4,1,'20/02/2019','40040000', '15');
INSERT INTO Saving_account VALUES (6,1,'11/12/2020','900000', '13');
INSERT INTO Saving_account VALUES (8,1,'28/12/2019','13004000', '20');
INSERT INTO Saving_account VALUES (9,1,'11/12/2020','50040000', '24');

INSERT INTO Checking_account VALUES  (2,2,'10/12/2019','10503000');
INSERT INTO Checking_account VALUES  (7,2,'10/11/2019','10500833');
INSERT INTO Checking_account VALUES  (10,2,'09/01/2019','20939000');
INSERT INTO Checking_account VALUES  (12,2,'29/02/2020','10000000');
INSERT INTO Checking_account VALUES  (13,2,'29/02/2020','10000000');

INSERT INTO Loan VALUES (3,3,'28/02/2019','1839000', '17');
INSERT INTO Loan VALUES (5,3,'11/02/2019','4099000', '29');
INSERT INTO Loan VALUES (11,3,'11/04/2019','8000000', '23');
INSERT INTO Loan VALUES (14,3,'11/04/2019','8000000', '23');

INSERT INTO Branch_fax VALUES ('MCK', '1118390');
INSERT INTO Branch_fax VALUES ('MCK', '1584848');
INSERT INTO Branch_fax VALUES ('GDK', '1293390');
INSERT INTO Branch_fax VALUES ('GDK', '1234567');
INSERT INTO Branch_fax VALUES ('GDK', '1357984');
INSERT INTO Branch_fax VALUES ('RPT', '1893290');
INSERT INTO Branch_fax VALUES ('BKIT', '1299211');
INSERT INTO Branch_fax VALUES ('OISP', '8218390');
INSERT INTO Branch_fax VALUES ('OISP', '7584562');

INSERT INTO  Employee_phone VALUES ('emp0001', '0979956863');
INSERT INTO  Employee_phone VALUES ('emp0002', '0919934263');
INSERT INTO  Employee_phone VALUES ('emp0002', '0905950847');
INSERT INTO  Employee_phone VALUES ('emp0003', '0123385290');
INSERT INTO  Employee_phone VALUES ('emp0004', '0988221113');
INSERT INTO  Employee_phone VALUES ('emp0005', '0834782071');
INSERT INTO  Employee_phone VALUES ('emp0006', '0919830022');
INSERT INTO  Employee_phone VALUES ('emp0007', '0922988900');
INSERT INTO  Employee_phone VALUES ('emp0007', '0905951234');
INSERT INTO  Employee_phone VALUES ('emp0008', '0929930933');

INSERT INTO Customer_phone VALUES ('cus0001','0974826472');
INSERT INTO Customer_phone VALUES ('cus0001','0389347683');
INSERT INTO Customer_phone VALUES ('cus0002','093627843');
INSERT INTO Customer_phone VALUES ('cus0002','013673920');
INSERT INTO Customer_phone VALUES ('cus0002','083469201');
INSERT INTO Customer_phone VALUES ('cus0003','083623912');
INSERT INTO Customer_phone VALUES ('cus0004','037233239');
INSERT INTO Customer_phone VALUES ('cus0007','037283791');
