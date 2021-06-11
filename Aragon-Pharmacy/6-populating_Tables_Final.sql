/* 
	Purpose: Populating data in tables objects for AragonPharmacy databse
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 09, 2021	 
*/

/* SYNTAX:
BULK INSERT
   { database_name.schema_name.table_or_view_name | schema_name.table_or_view_name | table_or_view_name }
      FROM 'data_file'
     [ WITH
    (
   [ [ , ] BATCHSIZE = batch_size ]
   [ [ , ] CHECK_CONSTRAINTS ]
   [ [ , ] CODEPAGE = { 'ACP' | 'OEM' | 'RAW' | 'code_page' } ]
   [ [ , ] DATAFILETYPE =
      { 'char' | 'native'| 'widechar' | 'widenative' } ]
   [ [ , ] DATA_SOURCE = 'data_source_name' ]
   [ [ , ] ERRORFILE = 'file_name' ]
   [ [ , ] ERRORFILE_DATA_SOURCE = 'data_source_name' ]
   [ [ , ] FIRSTROW = first_row ]
   [ [ , ] FIRE_TRIGGERS ]
   [ [ , ] FORMATFILE_DATA_SOURCE = 'data_source_name' ]
   [ [ , ] KEEPIDENTITY ]
   [ [ , ] KEEPNULLS ]
   [ [ , ] KILOBYTES_PER_BATCH = kilobytes_per_batch ]
   [ [ , ] LASTROW = last_row ]
   [ [ , ] MAXERRORS = max_errors ]
   [ [ , ] ORDER ( { column [ ASC | DESC ] } [ ,...n ] ) ]
   [ [ , ] ROWS_PER_BATCH = rows_per_batch ]
   [ [ , ] ROWTERMINATOR = 'row_terminator' ]
   [ [ , ] TABLOCK ]

 

   -- input file format options
   [ [ , ] FORMAT = 'CSV' ]
   [ [ , ] FIELDQUOTE = 'quote_characters']
   [ [ , ] FORMATFILE = 'format_file_path' ]
   [ [ , ] FIELDTERMINATOR = 'field_terminator' ]
   [ [ , ] ROWTERMINATOR = 'row_terminator' ]
    )]
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
		b) tblOrders 
		c) tblOrderItems 
		d) tblSuppliers 


	4. MedicalTeam
		a) tblDoctor
		b) tblClinic

*/



use AragonPharmacy
;
go

/* Schema HumanResources starts here */

/* Inserting data into HumanResources.tblEmployee */

bulk insert HumanResources.tblEmployee 
	from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Employees.csv'
	with
	(
	firstrow=2,
	rowterminator='\n',
	fieldterminator=','
	)
;
go


/* Inserting data into HumanResources.tblClass */

bulk insert HumanResources.tblClass
from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Class.csv'
with
	(
		firstrow=2,
		rowterminator='\n',
		fieldterminator=','
	)
;
go

/* inserting data into HumanResources.tblJobTitle */

bulk insert HumanResources.tblJobTitle
	from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\JobTitle.csv'
	with
	(
	firstrow=2,
	rowterminator='\n',
	fieldterminator=','
	)
;
go


/* inserting data into HumanResources.tblEmployeeTraining */

bulk insert HumanResources.tblEmployeeTraining
	from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\EmployeeTraining.csv'
	with
	(
	firstrow=2,
	rowterminator='\n',
	fieldterminator=','
	)
;
go



/* Inserting data into HumanResources.tblAbsentee */

bulk insert HumanResources.tblAbsentee
	from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Absentee.txt'
	with
	(
	firstrow=2,
	rowterminator='\n',
	fieldterminator=','
	)
;
go


/* inserting data into HumanResources.tblAbsenteeCategory */

bulk insert HumanResources.tblAbsenteeCategory
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\AbsenteeCategory.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go



/* Inserting data into HumanResources.tblLangStatus */

bulk insert HumanResources.tblLangStatus
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\LanguageStatus.csv'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go



/* Inserting data into HumanResources.tblLanguages */

bulk insert HumanResources.tblLanguages
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Language.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go


/* Schema HumanResources ends here */



/* Schema Sales starts here */

/* Inserting data into Sales.tblCustomers */

bulk insert Sales.tblCustomers 
    from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Customers.csv'
    with
    (
    firstrow=2,
    rowterminator='\n',
    fieldterminator=','
    )
;
go


-- adding dublication data to check it later with Stored Precedure

bulk insert Sales.tblCustomers 
    from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Customers_duplicates.csv'
    with
    (
    firstrow=2,
    rowterminator='\n',
    fieldterminator=','
    )
;
go


/* Inserting data intoSales.tblHealthPlan */

bulk insert sales.tblHealthPlan
    from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\HealthPlan.csv'
    with
    (
    firstrow=2,
    rowterminator='\n',
    fieldterminator=','
    )
;
go


/* inserting data into Sales.tblHouseHold  */

bulk insert Sales.tblHouseHold
    from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\HouseHold.csv'
    with
    (
    firstrow=2,
    rowterminator='\n',
    fieldterminator=','
    )
;
go


/* Inserting data into Sales.tblRx */

bulk insert Sales.tblRx
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Rx.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go


/* Inserting data into Sales.tblRefill */

bulk insert Sales.tblRefill
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Refill.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go

/* Inserting data into Sales.tblAllergies */

bulk insert Sales.tblAllergies
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Allergies.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go

/* Schema Sales ends here */

/* Schema Production starts here */
/* Inserting data into Production.tblDrug */

bulk insert Production.tblDrug 
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Drug.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go

/* Inserting data into Production.tblOrders */

bulk insert Production.tblOrders
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Order.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go

/* Inserting data into Production.tblOrderItems */

bulk insert Production.tblOrderItems
    from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\OrderItems.csv'
    with
    (
    firstrow=2,
    rowterminator='\n',
    fieldterminator=','
    )
;
go

/* Inserting data into Production.tblSuppliers */

bulk insert Production.tblSuppliers
    from 'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Suppliers.csv'
    with
    (
    firstrow=2,
    rowterminator='\n',
    fieldterminator=','
    )
;
go


/* Schema Production ends here */

/* Schema MedicalTeam starts here */

/* Inserting data into MedicalTeam.tblDoctor */

bulk insert MedicalTeam.tblDoctor 
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Doctor.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go

/* Inserting data into MedicalTeam.tblClinic */

bulk insert MedicalTeam.tblClinic 
from 
'C:\Users\adria\OneDrive\Documents\Education\John Abbot College\Internet Programming Development\9. DATABASE\DATABASE - II\3. Team Project\Aragon-Pharmacy-Files\Populating_Tables\Clinic.txt'
with
(
	FirstRow = 2,
	RowTerminator = '\n',
	FieldTerminator = ','
)
;
go
