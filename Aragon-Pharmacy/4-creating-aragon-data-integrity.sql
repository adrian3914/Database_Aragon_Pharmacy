/* 
	Purpose: Creating constraints in tables objects for AragonPharmacy databse
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 08, 2021	 
*/	 


/* Schemas

	1.HumanResources
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


/* Integrity Types:
	1. Domain (column)
	2. Entity (row)
	3. Referential (between two columns or tables)

Constraint Types:
1. Primary Key (pk_)
	alter table schema_name.table_name
		add constraint pk_table_name primary key clustered (column_name asc)

2. Foreign key (fk_)
	alter table schema_name.table_name
		add constraint fk_first_table_name_second_table_name foreign key (fk_column_name) references second_table_name (pk_column_name)

3. Default (df_)
	alter table schema_name.table_name
		add constraint df_column_name_table_name default (value) for column_name

4. Check (ck_)
	alter table schema_name.table_name
		add constraint ck_column_name_table_name check (condition)

5. Unique (uq_)
alter table schema_name.table_name
		add constraint uq_column_name_table_name unique (column_name)
*/

-- Switch to AragonPharmacy databse in order to create tables objects

use AragonPharmacy
;
go

/***** Table No. 1 - HumanResources.tblEmployee  *****/

-- Foreign key constraints
/* 1) Between  HumanResources.tblEmployee and HumanResources.tblJobTitle */
alter table HumanResources.tblEmployee
	add constraint fk_tblEmployee_tblJobTitle foreign key (JobID)
		references HumanResources.tblJobTitle (JobID)
;
go

/* 2) Between  HumanResources.tblLangStatus and HumanResources.tblEmployee   */
alter table HumanResources.tblLangStatus
	add constraint fk_tblLangStatus_tblEmployee foreign key (EmpID)
		references HumanResources.tblEmployee (EmpID)
;
go


/* 3) Between  HumanResources.tblLangStatus and HumanResources.tblLanguages  */
alter table HumanResources.tblLangStatus
	add constraint fk_tblLangStatus_tblLanguages foreign key (LangID)
		references HumanResources.tblLanguages (LangID)
;
go






-- Check constraint -> Display format: ###-###-### for column SIN
alter table HumanResources.tblEmployee
	with check -- check values if any stored
		add constraint ck_SIN_tblEmployee check
		(
			SIN like '[0-9][0-9][0-9]-[0-9][0-9][0-9]-[0-9][0-9][0-9]'
		)
;
go

-- Unique constraint for SIN
alter table HumanResources.tblEmployee
	with check
		add constraint uq_SIN_tblEmployee unique (SIN)
;
go

-- Check constraint for DOB
alter table HumanResources.tblEmployee
	with check
		add constraint ck_DOB_tblEmployee check
			(DOB < getdate())
;
go

-- Check constraint for EndDate > StartDate
alter table HumanResources.tblEmployee
	with check
		add constraint ck_StartDate_EndDate_tblEmployee check
			(EndDate > StartDate)
;
go


-- Default constraint -> The default value for the City 'Montreal'
alter table HumanResources.tblEmployee
	with check
		add constraint df_City_tblEmployee default ('Montreal') for City
;
go

-- Default constraint -> The default value for the Province field is “QC” 
alter table HumanResources.tblEmployee
	with check
		add constraint df_Province_tblEmployee default 'QC' for Province
;
go



-- Default constraint -> The default value for Country 'Canada'
alter table HumanResources.tblEmployee
	with check
		add constraint df_Country_tblEmployee default ('Canada') for Country
;
go


-- Check constraint -> Only A-Z characters in province
alter table HumanResources.tblEmployee
	with check
		add constraint ck_Province_tblEmployee check 
		(
			Province like  '[A-Z][A-Z]'
		)
;
go


-- Check PostalCode  'A1A 1A1' where a is a character [a-z] and 1 [0-9]
alter table HumanResources.tblEmployee
	with check
		add constraint ck_PostalCode_tblEmployee check
		(
			PostalCode like '[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] [0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]'
			
		)
;
go


-- Check constraint -> format: (###) ###-#### for Phone and Cell

alter table HumanResources.tblEmployee
	with check -- check values if any stored
		add constraint ck_Phone_tblEmployee check
		(
			Phone like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
						
		)
;
go

alter table HumanResources.tblEmployee
	with check -- check values if any stored
		add constraint ck_Cell_tblEmployee check
		(
			Cell like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Cell like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Cell like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go




/***** Table No. 2 - HumanResources.tblClass  *****/
-- Check constraint for the Cost column in [HumanResources].[tblClass] table
alter table [HumanResources].[tblClass]
		add constraint ck_cost_tblClass check (Cost >= 0.00)
;
go

/* set the Description value to be unique because every Class should have a unique name */
alter table HumanResources.tblClass
	add constraint uq_Description_tblClass unique (Description)
;
go

/***** Table No. 3 - HumanResources.tblJobTitle  *****/
-- Unique constraint for Title
alter table HumanResources.tblJobTitle

		add constraint uq_Title_tblJobTitle unique (Title)
;
go




/***** Table No. 4 - HumanResources.tblEmployeeTraining  *****/
-- Foreign key constraints

/* 1) Between  HumanResources.tblEmployeeTraining and [HumanResources].[tblClass] */
alter table [HumanResources].[tblEmployeeTraining]
	add constraint fk_tblEmployeeTraining_tblClass foreign key([ClassID])
		references [HumanResources].[tblClass]([ClassID])
;
go

/* 1) Between  HumanResources.tblEmployeeTraining and HumanResources.tblEmployee */
alter table HumanResources.tblEmployeeTraining
	add constraint fk_tblEmployeeTraining_tblEmployee foreign key (EmpID)
		references HumanResources.tblEmployee (EmpID)
;
go



/***** Table No. 5 - HumanResources.tblAbsentee  *****/
-- Foreign key constraints

/* 1) Between  HumanResources.tblAbsentee and HumanResources.tblEmployee */
alter table HumanResources.tblAbsentee
	add constraint fk_tblAbsentee_tblEmployee foreign key (EmpID)
		references HumanResources.tblEmployee (EmpID)
;
go

/* 2) Between  HumanResources.tblAbsentee and HumanResources.tblAbsenteeCategory */
alter table HumanResources.tblAbsentee
	add constraint fk_tblAbsentee_tblAbsenteeCategory foreign key (AbsenteeCode)
		references HumanResources.tblAbsenteeCategory (AbsenteeCode)
;
go

-- Check constraint for the HourlyRate column in [HumanResources].[tblEmployee]
alter table [HumanResources].[tblEmployee]
		add constraint ck_hourlyRate_tblEmployee check (HourlyRate >= 0.00) -- in case of volunteering Hourly Rate can be 0.
;
go

-- Check constraint for the Salary column in [HumanResources].[tblEmployee]
alter table [HumanResources].[tblEmployee]
		add constraint ck_salary_tblEmployee check (Salary >= 0.00)
;
go

/***** Table No. 6 - HumanResources.tblAbsenteeCategory  *****/
/* set the Description value to be unique because every Absentee code should be unique  */
alter table HumanResources.tblAbsenteeCategory
	add constraint uq_Description_tblAbsenteeCategory unique (Description)
;
go



/***** Table No. 7 - HumanResources.tblLanguages  *****/
/* set the Description value to be unique because every Language should be unique  */
alter table HumanResources.tblLanguages
	add constraint uq_Description_tblLanguages  unique (Description)
;
go


/***** Table No. 8 - Sales.tblCustomers  *****/
-- Foreign key constraints
/* 1) Between  Sales.tblCustomers and Sales.tblHealthPlan */
alter table Sales.tblCustomers
	add constraint fk_tblCustomers_tblHealthPlan foreign key (PlanID)
		references Sales.tblHealthPlan (PlanID)
;
go

/* 2) Between  Sales.tblCustomers and Sales.tblHouseHold */
alter table Sales.tblCustomers
	add constraint fk_tblCustomers_tblHouseHold foreign key (HouseID)
		references Sales.tblHouseHold (HouseID)
;
go

-- Index for column CustLast
-- create object_type object_name on table_name (column_name)
create nonclustered index ncl_CustLast on Sales.tblCustomers (CustLast)
;
go

-- Check constraint -> format: (###) ###-#### for Phone and Cell

alter table Sales.tblCustomers
	with check -- check values if any stored
		add constraint ck_Phone_tblCustomers check
		(
			Phone like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

alter table Sales.tblCustomers
	with check -- check values if any stored
		add constraint ck__EmergencyContactTel_tblCustomers check
		(
			EmergencyContactTel like '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			EmergencyContactTel like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			EmergencyContactTel like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

/***** Table No. 9 - Sales.tblHealthPlan  *****/

-- Default constraint -> The default value for the Province field is “QC” 
alter table Sales.tblHealthPlan
	with check
		add constraint df_Province_tblHealthPlan default 'QC' for Province
;
go

-- Default constraint -> The default value for the City 'Montreal'
alter table Sales.tblHealthPlan
	with check
		add constraint df_City_tblHealthPlan default ('Montreal') for City
;
go

-- Default constraint -> The default value for Country 'Canada'
alter table Sales.tblHealthPlan
	with check
		add constraint df_Country_tblHealthPlan default ('Canada') for Country
;
go

-- Check constraint -> Only A-Z characters in province
alter table Sales.tblHealthPlan
	with check
		add constraint ck_Province_tblHealthPlan check 
		(
			Province like  '[A-Z][A-Z]'
		)
;
go

-- Check PostalCode  'A1A 1A1' where a is a character [a-z] and 1 [0-9]
alter table Sales.tblHealthPlan
	with check
		add constraint ck_PostalCode_tblHealthPlan check
		(
			PostalCode like '[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] [0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]'
		)
;
go

-- Check constraint -> format: (###) ###-#### for Phone
alter table Sales.tblHealthPlan
	with check -- check values if any stored
		add constraint ck_Phone_tblHealthPlan check
		(
			Phone like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

/* set the PlanName value to be unique because every Plan name should be unique  */
alter table Sales.tblHealthPlan 
	add constraint uq_PlanName_tblHealthPlan unique (PlanName)
;
go

/***** Table No. 10 - Sales.tblHouseHold  *****/
-- Default constraint -> The default value for the Province field is “QC” 
alter table Sales.tblHouseHold
	with check
		add constraint df_Province_tblHouseHold default 'QC' for Province
;
go

alter table Sales.tblHouseHold
	with check
		add constraint df_City_tblHouseHold default ('Montreal') for City
;
go

-- Default constraint -> The default value for Country 'Canada'
alter table Sales.tblHouseHold
	with check
		add constraint df_Country_tblHouseHold default ('Canada') for Country
;
go

-- Check constraint -> Only A-Z characters in province
alter table Sales.tblHouseHold
	with check
		add constraint ck_Province_tblHouseHold check 
		(
			Province like  '[A-Z][A-Z]'
		)
;
go

-- Check PostalCode  'A1A 1A1' where a is a character [a-z] and 1 [0-9]
alter table Sales.tblHouseHold
	with check
		add constraint ck_PostalCode_tblHouseHold check
		(
			PostalCode like '[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] [0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]'
		)
;
go

/***** Table No. 11 - Sales.tblRx  *****/
-- Foreign key constraints

/* 1) Between  Sales.tblRx and Production.tblDrug */
alter table Sales.tblRx
		add constraint fk_tblRx_tblDrug foreign key(DIN)
			references [Production].[tblDrug] (DIN)
;
go


/* 2) Between Sales.tblRx and Sales.tblCustomers */
alter table Sales.tblRx
		add constraint fk_tblRx_tblCustomers foreign key(CustID)
			references Sales.tblCustomers (CustID)
;
go


/* 3) Between Sales.tblRx and MedicalTeam.tblDoctor */
alter table Sales.tblRx
		add constraint fk_tblRx_tblDoctor foreign key(DoctorID)
			references MedicalTeam.tblDoctor (DoctorID)
;
go

-- Default constraint for column [AutoRefill] to 'No' in Sales.tblRx
alter table Sales.tblRx
	add constraint  df_AutoRefill_tblRx default ('No') for AutoRefill
;
go

/***** Table No. 12 - Sales.tblRefill  *****/
-- Foreign keys constraint

/* 1) Between Sales.tblRefill and Sales.tblRx */
alter table Sales.tblRefill
	add constraint  fk_tblRefill_tblRx foreign key(PrescriptionID)
		references Sales.tblRx (PrescriptionID)
;
go

/* 2) Between Sales.tblRefill and HumanResources.tblEmployee */
alter table Sales.tblRefill
	add constraint  fk_tblRefill_tblEmployee foreign key(EmpID)
		references HumanResources.tblEmployee (EmpID)
;
go

/***** Table No. 13 - Sales.tblAllergies  *****/
-- Foreign keys constraint

/* 1) Between Sales.tblAllergies and Sales.tblCustomers */
alter table Sales.tblAllergies
	add constraint fk_tblAllergies_tblCustomers foreign key (CustID)
		references Sales.tblCustomers (CustID)
;
go

/* 2) Between Sales.tblAllergies and Production.tblDrug */
alter table Sales.tblAllergies
	add constraint fk_tblAllergies_tblDrug foreign key (DIN)
		references Production.tblDrug (DIN)
;
go


/***** Table No. 14 - Production.tblDrug    *****/
-- Only composite primary key

/* 1) Between Production.tblDrug and Production.tblSuppliers */
alter table Production.tblDrug
	add constraint  fk_tblDrug_tblSuppliers foreign key(SupplierID)
		references Production.tblSuppliers (SupplierID)
;
go


-- Creating ncl index for column Name
-- create object_type object_name on table_name (column_name)
create nonclustered index 
	ncl_Name on Production.tblDrug (Name)
;
go

-- Check constraint for the Cost column in [Production].[tblDrug] table
alter table [Production].[tblDrug]
		add constraint ck_cost_tblDrug check (Cost >= 0.00)
;
go

-- Check constraint for the Price column in [Production].[tblDrug] table
alter table [Production].[tblDrug]
		add constraint ck_price_tblDrug check (Price >= 0.00)
;
go

/* set the Name value to be unique because every Drug has a unique name */
alter table Production.tblDrug
	add constraint uq_Name_tblDrug unique (Name)
;
go
	

/***** Table No. 15 - Production.tblOrders    *****/
-- Foreing keys constraint

/* 1) Between Production.tblOrders and Production.tblSuppliers  */
alter table Production.tblOrders
	add constraint  fk_tblOrders_tblSuppliers foreign key(SupplierID)
		references Production.tblSuppliers (SupplierID)
;
go

/* 2) Between Production.tblOrders and HumanResources.tblEmployee  */
alter table Production.tblOrders
	add constraint  fk_tblOrders_tblEmployee foreign key([EmpID])
		references HumanResources.tblEmployee ([EmpID])
;
go

/***** Table No. 16 - Production.tblOrderItems    *****/
-- Foreing keys constraint

/* 1) Between Production.tblOrderItems and Production.tblDrug  */
alter table Production.tblOrderItems
	add constraint  fk_tblOrderItems_tblDrug foreign key(DIN)
		references Production.tblDrug (DIN)
;
go

/* 2) Between Production.tblOrderItems and Production.tblOrders */
alter table Production.tblOrderItems
	add constraint  fk_tblOrderItems_tblOrders foreign key(OrderID)
		references Production.tblOrders (OrderID)
;
go

/***** Table No. 17 - Production.tblSuppliers    *****/

-- Default constraint -> The default value for the Province field is “QC” 
alter table Production.tblSuppliers
	with check
		add constraint df_Province_tblSuppliers default 'QC' for Province
;
go

-- Default constraint -> The default value for City 'Montreal'
alter table Production.tblSuppliers
	with check
		add constraint df_City_tblSuppliers default ('Montreal') for City
;
go

-- Default constraint -> The default value for Country 'Canada'
alter table Production.tblSuppliers
	with check
		add constraint df_Country_tblSuppliers default ('Canada') for Country
;
go

-- Check constraint -> Only A-Z characters in province
alter table Production.tblSuppliers
	with check
		add constraint ck_Province_tblSuppliers check 
		(
			Province like  '[A-Z][A-Z]'
		)
;
go

-- Check PostalCode  'A1A 1A1' where a is a character [a-z] and 1 [0-9]
alter table Production.tblSuppliers
	with check
		add constraint ck_PostalCode_tblSuppliers check
		(
			PostalCode like '[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] [0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]'
		)
;
go


-- Check constraint -> format: (###) ###-#### for Phone
alter table Production.tblSuppliers
	with check -- check values if any stored
		add constraint ck_Phone_tblSuppliers check
		(
			Phone like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

/* set the Name value to be unique because every Supplier has a unique name */
alter table Production.tblSuppliers
	add constraint uq_Name_tblSuppliers unique (Name)
;
go


/***** Table No. 19 - MedicalTeam.tblDoctor    *****/

/* 1) Between MedicalTeam.tblDoctor and MedicalTeam.tblClinic */
alter table MedicalTeam.tblDoctor
	add constraint fk_tblDoctor_tblClinic foreign key([ClinicID])
		references MedicalTeam.tblClinic([ClinicID])
;
go


-- Check constraint for phone and Cell collumns
alter table MedicalTeam.tblDoctor
	with check
		add constraint ck_Phone_tblDoctor check
		(
			Phone like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

alter table MedicalTeam.tblDoctor
	with check
		add constraint ck_Cell_tblDoctor check
		(
			Cell like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Cell like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Cell like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

/***** Table No. 20 - MedicalTeam.tblClinic    *****/

-- Deafult City 'Montreal'
alter table MedicalTeam.tblClinic
	with check
		add constraint df_City_tblClinic default ('Montreal') for City
;
go

-- Deafult Province 'QC'
alter table MedicalTeam.tblClinic
	with check
		add constraint df_Province_tblClinic default ('QC') for Province
;
go

-- Deafult Country 'Canada'
alter table MedicalTeam.tblClinic
	with check
		add constraint df_Country_tblClinic default ('Canada') for Country
;
go

-- Check constraint -> Only A-Z characters in province
alter table MedicalTeam.tblClinic
	with check
		add constraint ck_Province_tblClinic check 
		(
			Province like  '[A-Z][A-Z]'
		)
;
go

-- Check PostalCode  'A1A 1A1' where a is a character [a-z] and 1 [0-9]
alter table MedicalTeam.tblClinic
	with check
		add constraint ck_PostalCode_tblClinic check
		(
			PostalCode like '[ABCEGHJKLMNPRSTVXY][0-9][ABCEGHJKLMNPRSTVWXYZ] [0-9][ABCEGHJKLMNPRSTVWXYZ][0-9]'
		)
;
go

-- Check constraint for phone 
alter table MedicalTeam.tblClinic
	with check
		add constraint ck_Phone_tblClinic check
		(
			Phone like  '(514) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(450) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]' or
			Phone like '(438) [0-9][0-9][0-9]-[0-9][0-9][0-9][0-9]'
		)
;
go

/* set the ClinicName value to be unique because every Clinic has a unique name */
alter table MedicalTeam.tblClinic
	add constraint uq_ClinicName_tblClinic unique (ClinicName)
;
go