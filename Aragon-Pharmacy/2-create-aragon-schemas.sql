/* 
	Purpose: Creating schemas for table objects in AragonPharmacy databse
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 08, 2021	 
*/

/* Partial Syntax:
create schema schema_name authorization owner_name
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

-- Switch to AragonPharmacy in order to create schemas in the user defined database
use AragonPharmacy
;
go

-- HumanResources Schema
create schema HumanResources authorization dbo
;
go

-- Sales Schema
create schema Sales authorization dbo
;
go

-- Production Schema
create schema Production authorization dbo
;
go

-- MedicalTeam Schema
create schema MedicalTeam authorization dbo
;
go


