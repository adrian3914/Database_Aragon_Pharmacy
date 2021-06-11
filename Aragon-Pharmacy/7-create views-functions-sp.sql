/* 
	Purpose: Creating views objects for AragonPharmacy databse as business requirements
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 10, 2021	 
*/


/* 5.	SpeakSpanishView 
   Maria has another problem she wants to work on next. Paul asked Maria to look into the possibility
  of scheduling at least one employee in the pharmacy who is fluent in Spanish for all shifts. She thinks she can create a query that uses broader criteria than the exact match criteria she’s used so far to help with Paul’s scheduling request. Maria is ready to turn to Paul’s scheduling request. Because many of the pharmacy’s clientele speak Spanish, he wants to schedule at least one Spanish-speaking employee for each shift. 
 If an employee speaks Spanish (or any other language besides English and French), it is noted in the Comments field of tblEmployee. Because the Memo field data type allows for lengthy text or combinations of text and numbers, it is often best using wildcards in criteria that involve comments fields. Maria creates a view and saves it as SpeakSpanishView. 
*/

use AragonPharmacy
;
go


if OBJECT_ID('HumanResources.SpeakSpanishView', 'V') is not null
	drop view HumanResources.SpeakSpanishView
;
go

create view HumanResources.SpeakSpanishView
as
select 
	e.EmpID,
	CONCAT_WS(' ',e.EmpFirst,coalesce(' ',e.EmpMI),e.EmpLast) as 'Full Name',
	e.Address,
	e.Cell,
	e.Phone,
	l.Description as 'Language',
	ls.Spoken,
	ls.Written,
	ls.fluent
from HumanResources.tblEmployee as e
join HumanResources.tblLangStatus as ls
	on e.EmpID = ls.EmpID
join HumanResources.tblLanguages as l
	on ls.LangID = l.LangID
where ls.LangID = 'ES' and ls.Fluent = 'yes'
;
go




/* Creating view for employee with languages other than English and French */

if OBJECT_ID('HumanResources.SpeakOtherLanguagesView', 'V') is not null
	drop view HumanResources.SpeakOtherLanguagesView
;
go

Create view HumanResources.SpeakOtherLanguagesView
as
select top 100 percent
	e.EmpID,
	CONCAT_WS(' ',e.EmpFirst,coalesce(' ',e.EmpMI),e.EmpLast) as 'Full Name',
	e.Address,
	e.Cell,
	e.Phone,
	l.Description as 'Language',
	ls.Spoken,
	ls.Written,
	ls.fluent
from [HumanResources].[tblLangStatus] as ls
join [HumanResources].[tblLanguages] as l
	on ls.LangID = l.LangID
join [HumanResources].[tblEmployee] as e
	on ls.EmpID = e.EmpID
where ls.LangID not in ('EN','FR')
order by l.Description
;
go


/* 13 EmployeeTrainingView
The EmployeeTrainingView produces a list that includes employees and the classes they’ve attended and employees who have not attended any classes. Maria wants to base a new query on EmployeeTrainingView to see if employees taking required classes are up to date on their certifications in Adult CPR, Child/Infant CPR, and Defibrillator Use. Each type of certification needs to be renewed at different intervals, so she needs to set the criteria carefully to produce the results she needs.
*/
if OBJECT_ID('HumanResources.EmployeeTrainingView', 'V') is not null
	drop view HumanResources.EmployeeTrainingView
;
go

create view HumanResources.EmployeeTrainingView
as
select 
	e.EmpID,
	CONCAT_WS(' ',e.EmpFirst,coalesce(' ',e.EmpMI),e.EmpLast) as 'Full Name',
	case 
	when c.Description is null then 'No course taken'
	else c.Description
	end as 'Course',
	IIF(format(et.Date, 'MM/dd/yyyy') is null, '-', format(et.Date, 'MM/dd/yyyy') ) as 'Date last Taken',
	IIF(format(dateadd(year, c.Renewal, et.Date), 'MM/dd/yyyy') is null, '-', format((dateadd(year, c.Renewal, et.Date)), 'MM/dd/yyyy') ) as 'Renewal Date',
	case
		when  getdate() > (dateadd(year, c.Renewal, et.Date)) and c.Required = 1 then 'Expired'
		when  getdate() < (dateadd(year, c.Renewal, et.Date)) and c.Required = 1 then 'Up to date'
		else '-'
	end as 'Status'
from HumanResources.tblEmployee as e
left join [HumanResources].[tblEmployeeTraining] as et
	on e.EmpID = et.EmpID
left join [HumanResources].[tblClass] as c
	on et.ClassID = c.ClassID
order by e.EmpID offset 0 rows
;
go



/* 14.	UpToDateView
Maria decides to save EmployeeTrainingView as UpToDateView and then modify it. The view already includes field lists for tblEmployee, tblEmployeeTraining, and tblClass, with outer joins specified so that all employees are listed in the results, even if they have not attended a class. The EmpLast and EmpFirst fields from tblEmployee and the Description field from tblClass already appear in the query. To determine whether an employee’s certification is up to date, she needs the Date field from tblEmployeeTraining and she inserts this field between the EmpFirst and Description fields. To determine whether a particular class is required for certification, she needs to include the Required field from tblClass. She also decides to include the ClassID field from tblClass to make setting up the criteria easier—all she will have to do is specify the ID of the class rather than the long description. She adds the three fields—Date, Required, and ClassID—to the view. Next, she will specify the criteria for selecting information about only the classes required for certification. Pharmacy employees must take the five classes listed in Table 4.
The first two classes—Adult CPR and Child/Infant CPR—are the comprehensive classes employees take to receive CPR certification for the first time. Employees complete these comprehensive classes only once, and do not need to renew them. Instead, they need to complete classes with IDs 3 and 6, which are refresher courses for recertification. ClassID 5 provides certification for defibrillator use and must be taken every year. First, Maria adds a criterion to determine which employees are current in their Adult CPR certification. These employees would have completed the Adult CPR or the Adult CPR Recertification classes (ClassIDs 1 or 3) in the past year. She can use the logical operator OR to select employees who have completed ClassID 1 or 3. To narrow the criteria and select only those employees who have taken these courses in the past year, Maria can use the Between…And comparison operator, which you use to specify two Date fields. She needs to specify the time period from January 1, 2020 to December 31, 2020, so she types Between ‘1/1/2020’ And ‘12/31/2020’ in the Where clause for the Date field.
*/
if OBJECT_ID('HumanResources.UpToDateView', 'V') is not null
	drop view HumanResources.UpToDateView
;
go

create view HumanResources.UpToDateView
as
select 
	e.EmpID,
	CONCAT_WS(' ',e.EmpFirst,coalesce(' ',e.EmpMI),e.EmpLast) as 'Full Name',
	format(et.Date, 'MM/dd/yyyy') as 'Date last Taken',
	c.Description as 'Course',
	c.Required,
	c.ClassID,
	format((dateadd(year, c.Renewal, et.Date)), 'MM/dd/yyyy') as 'Expiration Date',
	case
		when  getdate() > (dateadd(year, c.Renewal, et.Date)) and c.Required = 1 then 'Expired'
		when  getdate() < (dateadd(year, c.Renewal, et.Date)) and c.Required = 1 then 'Up to date'
		else '-'
	end as 'Status'
from HumanResources.tblEmployee as e
left join [HumanResources].[tblEmployeeTraining] as et
	on e.EmpID = et.EmpID
left join [HumanResources].[tblClass] as c
	on et.ClassID = c.ClassID
	where c.ClassID in (1,3) and et.date between '1/1/2020' And '12/31/2020'
order by e.EmpID offset 0 rows
;
go



/* 9.Using Queries to Find Unmatched Records */
select 
		Emp.EmpID as 'Employee ID',
		Emp.EmpLast as 'Last Name',
		Emp.EmpFirst as 'First Name',
		Emp.JobID as 'Job ID',
		format(Emp.StartDate, 'MM/dd/yyyy') as 'Hired Date',
		Emp.Phone as 'Phone',
		Emp.Cell as 'Cell Phone'
		
		from
			HumanResources.tblEmployeeTraining  as Tr
right join	HumanResources.tblEmployee as Emp
	 
	 on Emp.EmpID = Tr.EmpID
where Tr.ClassID is null
;
go


/* 11.Create EmployeeClassesView */

/* drop the  EmployeeClassesView if exists and then re-create it */
if OBJECT_ID('EmployeeClassesView', 'V') is not null
	drop view  EmployeeClassesView
;
go


create view EmployeeClassesView
as
select 
		Top 100 percent
		Emp.EmpID as 'Employee ID',
		Emp.EmpLast as 'Last Name',
		Emp.EmpFirst as 'First Name',
		format(Tr.Date, 'MM/dd/yyyy') as 'Date',
		Tr.ClassID as 'Class ID'
from
HumanResources.tblEmployee as Emp
	inner join HumanResources.tblEmployeeTraining as Tr
	 on Emp.EmpID = Tr.EmpID
	order by Emp.EmpID

;
go


/* ********************************************************** */

/* 12.EmployeeClassesDescriptionView */

/* drop the  EmployeeClassesDescriptionView if exists and then re-create it */
if OBJECT_ID('EmployeeClassesDescriptionView', 'V') is not null
	drop view  EmployeeClassesDescriptionView
;
go

create view EmployeeClassesDescriptionView
as
select 
		Emp.EmpLast as 'Last Name',
		Emp.EmpFirst as 'First Name',
		format(Tr.Date, 'MM/dd/yyyy') as 'Date',
		Cl.Description as 'Class Description'
from
HumanResources.tblEmployee as Emp
	inner join HumanResources.tblEmployeeTraining as Tr
	 on Emp.EmpID = Tr.EmpID
	inner join HumanResources.tblClass as Cl
	 on Tr.ClassID = Cl.ClassID
order by emp.EmpLast
offset 0 rows
;
go



/* ********************************************************* */


/* 16. YearsOfServiceFn */

if OBJECT_ID('HumanResources.YearsOfServiceFn', 'Fn') is not null
	drop function YearsOfServiceFn
;
go

create function HumanResources.YearsOfServiceFn
(
	
	-- declare a parameter with itd data_type
	@HireDate as datetime
)
-- returns data_type
returns int
	as
		begin
			-- declare the returned variable as data_type
			declare @seniority as int
			-- compute the returned value
			select @seniority = abs(dateDiff(year, @HireDate, getDate() ))
			-- return the result value to the function caller
			return @seniority
		end
;
go


/* Testing the function HumanResources.YearsOfServiceFn */
select HumanResources.YearsOfServiceFn('2029/06/21')
;
go


/* Query that returns the employee years of service in descended order using HumanResources.YearsOfServiceFn */
select
	EmpID as 'Employee ID',
	Concat_WS(' ',EmpFirst, COALESCE(Null,EmpMI),EmpLast) as 'Employee Full Name',
	format(StartDate, 'MM/dd/yyyy')  as 'Hired Date',
	HumanResources.YearsOfServiceFn(StartDate) as 'Years of Service'

from HumanResources.tblEmployee
order by 'Years of Service' desc
;
go


/* optional view for Years of service */

if OBJECT_ID('EmployeeYearsOfServiceView', 'V') is not null
	drop view  EmployeeYearsOfServiceView
;
go

create view EmployeeYearsOfServiceView
as
select
	EmpID as 'Employee ID',
	Concat_WS(' ',EmpFirst, COALESCE(Null,EmpMI),EmpLast) as 'Employee Full Name',
	format(StartDate, 'MM/dd/yyyy')  as 'Hired Date',
	HumanResources.YearsOfServiceFn(StartDate) as 'Years of Service'

from HumanResources.tblEmployee
order by 'Years of Service' desc
offset 0 rows
;
go



/* 4. HourlyRateAnalysisView
Paul Ferrino, the owner of 4Corners Pharmacy, periodically reviews the wages he pays to his employees 
so he can budget for upcoming pay raises. He has recently increased the salaries of the two pharmacists 
at 4Corners, but he needs to check the hourly rates he pays to the other employees. He asks Maria to list 
the wages for pharmacy technicians and cashiers, ranked from highest to lowest so he can quickly see the 
full range of pay for non-salaried employees. Maria creates a view and saves it as HourlyRateAnalysisView. */

/* Use Job ID 3 and 4 for pharmacy technicians and cashiers */
if OBJECT_ID('HumanResources.HourlyRateAnalysisView', 'V') is not null
	drop view HumanResources.HourlyRateAnalysisView
;
go

create view HumanResources.HourlyRateAnalysisView
as
	select 
		HRC.EmpID, 
		HRC.JobID, 
		tblJobTitle.Title, 
		HRC.EmpFirst, HRC.
		EmpLast, 
		HRC.HourlyRate
	from [HumanResources].[tblEmployee] as HRC
	join [HumanResources].[tblJobTitle] on HRC.JobID = tblJobTitle.JobID
	where HRC.JobID in (3,4)
	order by HourlyRate desc offset 0 rows
;
go


/* 7. CarpoolView 
To conserve gasoline and other vehicle maintenance costs, employees have asked Maria to help them 
coordinate carpools. One of her tasks will be to help employees determine how they can share rides to work. 
She will create a carpool list identifying those employees who live in the same city. Maria can create a 
list of employees who live in the same city. She can post this list so that employees can form carpools. */

if OBJECT_ID('HumanResources.CarPoolView', 'V') is not null
	drop view HumanResources.CarPoolView
;
go

create view HumanResources.CarPoolView
as
	select 
		HRC.EmpID,
		HRC.EmpFirst as 'First Name',
		HRC.EmpLast as 'Last Name', 
		HRC.City
	from [HumanResources].[tblEmployee] as HRC
	order by HRC.City offset 0 rows
;
go


-- Changed city data for employee #1 to Laval for testing purposes

UPDATE [HumanResources].[tblEmployee]
   SET
      [City] = 'Laval'  
 WHERE EmpID = 5
;
GO


/*  Paul asks Maria to work on a view that returns the hourly rate summary that returns the minimum, and maximum of hourly rate related to the job position. Maria creates a view and saves it as HourlyRateSummaryView. */

-- creating the view HumanResources.HourlyRateSummaryView
create view HumanResources.HourlyRateSummaryView
as 
select J.Title as 'Job Title',
min(E.HourlyRate) as 'Minimum Hourly Rate', max(E.HourlyRate) as 'Maximum Hourly Rate'
from [HumanResources].[tblEmployee] as E
join [HumanResources].[tblJobTitle] as J
on E.JobID=J.JobID
where E.HourlyRate > 0.00
group by J.Title;
go


/* Maria needs to calculate the minimum, maximum, and average hourly rates for each job ID. She creates a view, adding the JobID and HourlyRate fields from the tblEmployee table and setting criteria to display only records for technicians and cashiers, so she adds the criteria 3 or 4 in the JobID field. Because she wants to calculate three types of statistics on the HourlyRate field, she adds that field to the design grid two more times. She names the view MaxMinAvgHourlyRateView, and then runs it. */

-- creating the view HumanResources.MaxMinAvgHourlyRateView
create view HumanResources.MaxMinAvgHourlyRateView
as 
select 
	J.Title as 'Job Title',
	min(E.HourlyRate) as 'Minimum Hourly Rate',
	max(E.HourlyRate) as 'Maximum Hourly Rate',
	round(avg(E.HourlyRate),2) as 'Average Hourly Rate'
from [HumanResources].[tblEmployee] as E
join [HumanResources].[tblJobTitle] as J
on E.JobID=J.JobID
where J.Title in ('Cashier','Technician')
group by J.Title;
go


/*10. Using Parameter Values | getSubstituteListFn
When you need to run a query multiple times with changes to the criteria, 
you can enter a parameter value. A parameter value is a phrase, usually in the form of a 
question or instruction, such as @jobID. The parameter value serves as a prompt to the user
to enter a value. Maria decides to create a user-define function (UDF) with parameter by specifying 
a parameter value in the @JobID field. She begins creating the function using tblEmployee. 
She chooses EmpLast, EmpFirst, Phone, Cell, JobID, and EndDate as fields for the query. 
She sorts the data in alphabetical order by last name. She remembers to include the EndDate 
criterion Is Null. She saves the query as getSubstituteListFn.  */


-- creating the function HumanResources.getSubstituteListFn
create function HumanResources.getSubstituteListFn(@Jobid smallint)
returns table
as
return
(
	select
		e.EmpLast as 'Last Name', 
		e.EmpFirst as 'First Name', 
		e.Phone, 
		e.Cell, 
		e.JobID,
		jt.Title as 'Job Description',
		e.EndDate as 'End date'
	from [HumanResources].[tblEmployee] as e
	join HumanResources.tblJobTitle as jt
		on e.JobID = jt.JobID
	where e.JobId = @JobId and EndDate is null
	order by EmpLast asc
	offset 0 rows
)
;
go


-- Example of store procedure
create procedure getSubstituteListSP
@JobID int
as 
select 
	EmpLast, 
	EmpFirst, 
	Phone, 
	Cell, 
	JobID, 
	format(EndDate, 'MM/dd/yyyy') as 'End Date'
from [HumanResources].[tblEmployee]
where JobID=@JobID
order by EmpLast asc
;
go

exec getSubstituteListSP 1
;
go


/* create a procedure, Sales.getCustomersDublicationSP, that returns dublicate records */

create procedure Sales.getCustomersDublicationSP
as
	begin
		select  
			CustFirst,
			CustLast, 
			DOB
		from [Sales].[tblCustomers]
		group by CustFirst, CustLast, DOB
		having count(*)>1
	end
;
go

/* call (execute) the Sales.getCustomersDublicationSP */
execute Sales.getCustomersDublicationSP
;
go


/* create a procedure, HumanResources.getEmployeeDuplicateSP, that returns dublicate records */

create procedure HumanResources.getEmployeeDuplicateSP
as
	begin
		select  EmpLast as 'Last Name'
		,EmpFirst as 'First Name'
		, DOB as 'Date of Birth'
		from HumanResources.tblEmployee
		group by EmpLast,EmpFirst, DOB
		having count(*)>1
	end
;
go

/* call (execute) the Sales.getCustomersDublicationSP */
execute HumanResources.getEmployeeDuplicateSP
;
go