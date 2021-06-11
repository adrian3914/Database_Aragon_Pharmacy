/* 
	Purpose: Creating tables objects in AragonPharmacy databse
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 08, 2021	 
*/



/*	1.HumanResources
		a) tblEmployee
		b) tblClass
		c) tblJobTitle
		d) tblEmployeeTraining
		e) tblAbsentee 
		f) tblAbsenteeCategory
		g) tblLangStatus
		h) tblLanguages

		

	2. Sales
		a) tblCustomers
		b) tblHealthPlan
		c) tblHouseHold 
		d) tblRx
		e) tblRefill
		f) tblAllergies

	3. Production
		a) tblDrug
		b) tblOrders --
		c) tblOrderItems --
		d) tblSuppliers --


	4. MedicalTeam
		a) tblDoctor
		b) tblClinic
*/

-- Switch to AragonPharmacy databse in order to create tables objects
use AragonPharmacy
;
go

/* ***** Table No. 1 - HumanResources.tblEmployee ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblEmployee', 'U') is not null
	drop table HumanResources.tblEmployee
;
go

create table HumanResources.tblEmployee
(
	-- column_name data_type constraint(s)
	EmpID smallint not null,	-- Primary key, unique numbers are assigned by the pharmacy
	EmpFirst nvarchar(30) not null,
	EmpMI nvarchar(2) null,
	EmpLast nvarchar(30) not null,
	SIN nchar(11) not null, --  Canadian Social insurance number,format: ###-###-###
	DOB date not null, -- Date of Birth
	StartDate date not null, 
	EndDate date null, 
	Address nvarchar(255) not null, -- street number and name
	City nvarchar(55) not null,
	Province nchar(2) not null, 
	PostalCode nchar(7) not null,
	Country nvarchar(55) not null,
	JobID smallint not null, -- Foreign key reference HumanResources.tblJobTitle
	Memo nvarchar(450) not null, -- Other information about employees
	Phone nvarchar(15) not null,
	Cell nvarchar(15) not null,
	Email nvarchar(255) null,
	Salary money null, -- annual salary 
	HourlyRate money null,
	Review datetime null, -- Annual review date

	-- Primary key constraint 
	constraint pk_tblEmployee primary key clustered(EmpID asc)
)
;
go

/* ***** Table No. 2 - HumanResources.tblClass ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblClass', 'U') is not null
	drop table HumanResources.tblClass
;
go

create table HumanResources.tblClass
(
	-- column_name data_type constraint(s)
	ClassID smallint identity(1,1) not null, -- Primary key tblClass
	Description nvarchar(255) not null,
	Cost smallmoney not null,
	Renewal smallint null, -- Renewal requirement (in years)
	Required nvarchar(5) not null, -- Requirement status
	Provider nvarchar(50) not null,

	-- Primary key constraint 
	constraint pk_tblClass primary key clustered(ClassID asc)
)
;
go

/* ***** Table No. 3 - HumanResources.tblJobTitle ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblJobTitle', 'U') is not null
	drop table HumanResources.tblJobTitle
;
go

create table HumanResources.tblJobTitle
(
	-- column_name data_type constraint(s)
	JobID smallint identity(1,1) not null, -- Primary key tblJobTitle
	Title nvarchar(30) not null,

	-- Primary key constraint 
	constraint pk_tblJobTitle primary key clustered(JobID asc)
)
;
go

/* ***** Table No. 4 - HumanResources.tblEmployeeTraining ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblEmployeeTraining', 'U') is not null
	drop table HumanResources.tblEmployeeTraining
;
go

create table HumanResources.tblEmployeeTraining
(
	-- column_name data_type constraint(s)
	EmpID smallint not null, -- foreign key references HumanResources.tblEmployee
	Date date not null, -- Date of the training session
	ClassID smallint not null, -- foreign key references HumanResources.tblClass

	-- Composite primary key constraint
	constraint pk_tblEmployeeTraining primary key clustered(EmpID, ClassID asc)
)
;
go


/* ***** Table No. 5 - HumanResources.tblAbsentee ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblAbsentee', 'U') is not null
	drop table HumanResources.tblAbsentee
;
go



create table HumanResources.tblAbsentee
(
	AbsenteeID smallint identity(1,1) not null,
	EmpID smallint not null, -- Foreing key references[HumanResources].[tblEmployee]
	FromDate date not null,
	ToDate date not null,
	AbsenteeCode nchar(3) not null, -- Foreing key references [HumanResources].[tblAbsenteeCategory]
	Comments nvarchar(400) null,

	-- adding PK constraint
	constraint pk_tblAbsentee primary key clustered (AbsenteeID asc)
)
;
go

/* ***** Table No. 6 - HumanResources.tblAbsenteeCategory ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblAbsenteeCategory', 'U') is not null
	drop table HumanResources.tblAbsenteeCategory
;
go

create table HumanResources.tblAbsenteeCategory
(
	AbsenteeCode nchar(3) not null, -- PK
	Description nvarchar(55) not null,


	-- adding PK constraint
	constraint pk_tblAbsenteeCategory primary key clustered(AbsenteeCode asc)
)
;
go

/* ***** Table No. 7 - HumanResources.tblLangStatus ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblLangStatus', 'U') is not null
	drop table HumanResources.tblLangStatus
;
go

create table HumanResources.tblLangStatus
(
	EmpID smallint not null, -- FK1 references [HumanResources].[tblEmployee]
	LangID nchar(2) not null, -- FK2 references [HumanResources].[Languages]
	Spoken nvarchar(5) not null,
	Written nvarchar(5) not null,
	Fluent nvarchar(5) not null, -- Yes or No


	-- adding composite PK constraint
	constraint pk_tblLangStatus primary key clustered(EmpID asc, LangID asc)
)
;
go

/* ***** Table No. 8 - HumanResources.tblLanguages ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('HumanResources.tblLanguages', 'U') is not null
	drop table HumanResources.tblLanguages
;
go

create table HumanResources.tblLanguages
(
	
	LangID nchar(2) not null, -- PK (ES,EN,FR,...)
	Description nvarchar(50) not null,

	-- adding composite PK constraint
	constraint pk_tblLanguages primary key clustered(LangID asc)
)
;
go


/* ***** Table No.9 - Sales.tblCustomers ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Sales.tblCustomers', 'U') is not null
	drop table Sales.tblCustomers
;
go

create table Sales.tblCustomers
(
	-- column_name data_type constraint(s)
	CustID smallint identity(1,1) not null, -- Primary Key in tblCustomers table
	CustFirst nvarchar(50) not null,
	CustLast nvarchar(50) not null,
	Phone nvarchar(15) not null,
	DOB date not null, -- Date of Birth
	Gender nvarchar(10) null,
	Email nvarchar(255) null,
	Balance smallmoney not null,
	ChildproofCap nvarchar(5) not null, -- Required (Yes or no)
	PlanID smallint not null, -- foreign key references Sales.tblHealthPlan
	HouseID smallint not null, -- foreign key references Sales.tblHouseHold
	HeadHH nvarchar(5) not null, -- Head of the houseHold (yes|no)
	MaritalStatus nvarchar(15) not null,
	Employer nvarchar(55) null, -- Name of employer if applicable
	Occupation nvarchar(55) null,
	EmergencyContactFirst nvarchar(55) not null,
	EmergencyContactLast nvarchar(55) not null,
	EmergencyContactTel nvarchar(15) not null,
	RelationShipToPatient nvarchar(55) not null, 
	SpouseNameFirst nvarchar(55) null, 
	SpouseNameLast	nvarchar(55) null, 

	-- Primary key constraint 
	constraint pk_tblCustomers primary key clustered(CustID asc)

)
;
go

/* ***** Table No.10 - Sales.tblHealthPlan ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Sales.tblHealthPlan', 'U') is not null
	drop table Sales.tblHealthPlan
;
go

create table Sales.tblHealthPlan
(
	PlanID smallint identity(1,1) not null, --PK
	PlanName nvarchar(50) not null,
	Address nvarchar(255) not null, -- street number and name
	City nvarchar(55) not null,
	Province nchar(2) not null, 
	PostalCode nchar(7) not null,
	Country nvarchar(55) not null,
	Phone nvarchar(24) not null,
	Days smallint not null,
	Website nvarchar(255) null,

	-- Primary key constraint 
	constraint pk_tblHealthPlan primary key clustered(PlanID asc)
)
;
go


/* ***** Table No.11 - Sales.tblHouseHold ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Sales.tblHouseHold', 'U') is not null
	drop table Sales.tblHouseHold
;
go

create table Sales.tblHouseHold
(
	HouseID smallint identity(1,1) not null,
	Address nvarchar(255) not null, -- street number and name
	City nvarchar(55) not null,
	Province nchar(2) not null, 
	PostalCode nchar(7) not null,
	Country nvarchar(55) not null,

	-- Adding constraint primary key
	constraint pk_tblHouseHold primary key clustered(HouseID asc)
)
;
go

/* ***** Table No.12  - Sales.tblRx ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Sales.tblRx', 'U') is not null
	drop table Sales.tblRx
;
go

create table Sales.tblRx
(
	PrescriptionID smallint identity(1,1) not null,
	DIN nchar(8) not null, -- FK Drug identificiation number
	Quantity decimal(10,2) not null,
	Unit nvarchar(10) not null, -- Unit of measure for a drug
	Date datetime not null,
	ExpireDate date not null,
	Refills smallint not null, -- Number of refills authorized
	AutoRefill nvarchar(5) not null, -- Preference for automatic refills (yes or no)
	RefillsUsed smallint null, -- I have added as per business rules, but this is a calculated field
	Instructions nvarchar(50) not null, -- Prescribing instructions
	CustID smallint not null, -- Foreign Key references Sales.tblCustomers table
	DoctorID smallint not null, -- Foreign Key references MedicalTeam.tblDoctor table

	-- Primary key
	constraint pk_PrescriptionID primary key clustered(PrescriptionID asc)
)
;
go

/* ***** Table No.13  - Sales.tblRefill ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Sales.tblRefill', 'U') is not null
	drop table Sales.tblRefill
;
go

create table Sales.tblRefill
(
	PrescriptionID smallint not null, -- foreign key references Sales.tblRx
	RefillDate datetime not null,
	EmpID smallint not null, -- foreign key references HumanResources.tblEmployee

	-- Composite primary key
	constraint pk_tblRefill primary key clustered(PrescriptionID asc, EmpID asc)
)
;
go

/* ***** Table No.14  - Sales.tblAllergies ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Sales.tblAllergies', 'U') is not null
	drop table Sales.tblAllergies
;
go

create table Sales.tblAllergies
(
	CustID smallint not null, -- FK1 references [Sales].[tblCustomers]
	DIN nchar(8) not null, -- FK2 references [Production].[tblDrug]

	-- Composite primary key
	constraint pk_tblAllergies primary key clustered(CustID asc, DIN asc)
)
;
go


/* ***** Table No.15  - Production.tblDrug ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Production.tblDrug', 'U') is not null
	drop table Production.tblDrug
;
go


create table Production.tblDrug
(
	DIN nchar(8) not null, -- Natural primary key (Drug identification number)
	Name nvarchar(30) not null,
	Generic nchar(1) not null, 
	Description nvarchar(255) not null, --Drug contraindications, generic equivalents, and recommended dosage.
	Unit nvarchar(10) not null, -- Drug unit of measure
	Dosage nvarchar(10) not null, -- drug’s strength
	DosageForm nvarchar(20) not null, -- Unit of measure for the drug strength
	Cost money not null, -- Cost of medication to buy
	Price money not null, -- Selling price
	DispenseFee money null, -- Overhead cost
	Interactions nvarchar(400) not null, -- Drug interactions and possible reactions
	SupplierID smallint not null, -- Fk references[Production].[tblSuppliers]
	-- Adding primary key constraint
	constraint pk_tblDrug primary key clustered(DIN asc)
)
;
go


/* ***** Table No.16  - Production.tblOrders ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Production.tblOrders', 'U') is not null
	drop table Production.tblOrders
;
go

create table Production.tblOrders
(
	OrderID smallint identity(1,1) not null, -- PK
	SupplierID smallint not null, -- Foreing key Production.tblSuppliers
	OrderDate datetime not null,
	ReceivedDate datetime null, 
	EmpID smallint not null, -- EmployeeID that places the order
	
	-- Adding primary key constraint
	constraint pk_tblOrders primary key clustered(OrderID asc)
)
;
go

/* ***** Table No.17  - Production.tblOrderItems ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Production.tblOrderItems', 'U') is not null
	drop table Production.tblOrderItems
;
go

create table Production.tblOrderItems
(
	TransactionID smallint identity(1,1) not null, -- PK
	DIN nchar(8) not null, -- FK references [Production].[tblDrug]
	Qty smallint not null, -- order qty per product
	OrderID smallint not null, -- FK references[Production].[tblOrders]

	-- Adding primary key constraint
	constraint pk_tblOrderItems primary key clustered(TransactionID asc)

)
;
go

/* ***** Table No.18  - Production.tblSuppliers ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('Production.tblSuppliers', 'U') is not null
	drop table Production.tblSuppliers
;
go

create table Production.tblSuppliers
(
	SupplierID smallint identity(1,1) not null, -- PK
	Name nvarchar(55) not null,
	Address nvarchar(255) not null,
	City nvarchar(55) not null,
	Province nchar(2) not null,
	PostalCode nchar(7) not null,
	Country nvarchar(55) not null,
	Email nvarchar(255) null,
	Website nvarchar(255) null, -- URl if applicable
	Phone nvarchar(15) not null,

	-- Adding primary key constraint
	constraint pk_tblSuppliers primary key clustered(SupplierID asc)
)
;
go

/* ***** Table No.19  - MedicalTeam.tblDoctor  ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('MedicalTeam.tblDoctor', 'U') is not null
	drop table MedicalTeam.tblDoctor
;
go

create table MedicalTeam.tblDoctor
(
	DoctorID smallint identity(1,1) not null, --PK
	DoctorFirst nvarchar(30) not null,
	DoctorLast nvarchar(30) not null,
	Phone nvarchar(15) not null,
	Cell nvarchar(15) null,
	Email nvarchar(255) null,
	ClinicID smallint not null, -- foreign key refences MedicalTeam.tblClinic

	-- Adding primary key constraint
	constraint pk_tblDoctor primary key clustered(DoctorID asc)
)
;
go

/* ***** Table No.20  - MedicalTeam.tblClinic  ***** */
-- Before creating table verify if object exist and drop in the case that does, not in production enviroment
if OBJECT_ID('MedicalTeam.tblClinic', 'U') is not null
	drop table MedicalTeam.tblClinic
;
go

create table MedicalTeam.tblClinic
(
	ClinicID smallint identity(1,1) not null, --PK
	ClinicName nvarchar(50)not null,
	Address1 nvarchar(40) not null,
	Address2 nvarchar(40) null,
	City nvarchar(40) not null,
	Province nchar(2) not null,
	PostalCode nchar(7) not null,
	Country nvarchar(55) not null,
	Phone nvarchar(15) not null,
	Email nvarchar(255) null,
	Website nvarchar(255) null,

	-- Adding primary key constraint
	constraint pk_tblClinic primary key clustered(ClinicID asc)

)
;
go