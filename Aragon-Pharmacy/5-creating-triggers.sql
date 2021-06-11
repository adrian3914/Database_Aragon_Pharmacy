/* 
	Purpose: Creating triggers in tables objects for AragonPharmacy databse
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 08, 2021	 
*/


-- switch to AragonPharmacy database 
use AragonPharmacy
;
go -- include end of batch markers (go statement)


/* SYNTAX:
create object_type schema_name.object_name
CREATE [ OR ALTER ] TRIGGER [ schema_name . ]trigger_name   
ON { table | view } 
{ FOR | AFTER | INSTEAD OF }   
{ [ INSERT ] [ , ] [ UPDATE ] [ , ] [ DELETE ] } 
as 
sql statements

*/


/* Create Trigger ToUppercase PostalCode and Province starts here */

/* ***** HumanResources.Employee ***** */
Create Trigger HumanResources.PostalCProvToUpperCaseTr
on HumanResources.tblEmployee
after insert, update
as
	begin
		update HumanResources.tblEmployee
		set Province = upper(Province),  PostalCode = Upper(PostalCode)
		where EmpID
			in ( 
				select EmpID 
				from inserted
			)
	end
;
go


/* *****  MedicalTeam.tblClinic ***** */
Create Trigger MedicalTeam.PostalCProvToUpperCaseTr
on MedicalTeam.tblClinic
after insert, update
as
	begin
		update MedicalTeam.tblClinic
		set Province = upper(Province),  PostalCode = Upper(PostalCode)
		where ClinicID
			in ( 
				select ClinicID
				from inserted
			)
	end
;
go


/* *****  Production.tblSuppliers ***** */
Create Trigger  Production.PostalCProvToUpperCaseTr
on  Production.tblSuppliers
after insert, update
as
	begin
		update Production.tblSuppliers
		set Province = upper(Province),  PostalCode = Upper(PostalCode)
		where SupplierID
			in ( 
				select SupplierID
				from inserted
			)
	end
;
go

/* *****  Sales.tblHousehold ***** */
Create Trigger  Sales.PostalCProvToUpperCaseTr
on  Sales.tblHouseHold
after insert, update
as
	begin
		update Sales.tblHouseHold
		set Province = upper(Province),  PostalCode = Upper(PostalCode)
		where HouseID
			in ( 
				select HouseID
				from inserted
			)
	end
;
go


/* ***** Sales.tblHealthPlan ***** */
Create Trigger  Sales.PostalCoProvToUpperCaseTr
on  Sales.tblHealthPlan
after insert, update
as
	begin
		update Sales.tblHealthPlan
		set Province = upper(Province),  PostalCode = Upper(PostalCode)
		where PlanID
			in ( 
				select PlanID
				from inserted
			)
	end
;
go
/* Create Trigger ToUppercase PostalCode and Province ends here */
