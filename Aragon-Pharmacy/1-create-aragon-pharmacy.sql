/* 
    Purpose: Creating database AragonPharmacy
	Developed by: Adrian, Mina, Tasha, Olek ATOM-Team
	Script Date: April 08, 2021	 
*/

-- when creating a database we must specify we are in master DB
-- Syntax: use  db_name;go

use master
;
go

--

/* 
Creating database : two files are required the data(.mdf) and log files (.ldf)
	
	syntax:
	create database database_name
		on primary
		(	--1) rows data logical filename
			name = 'Database_name',

			-- 2) rows data initial file size
			size = value MB|GB,

			-- 3) rows data auto growth size
			filegrowth = value MB|GB,

			-- 4) rows data maximum size
			maxsize = value MB|GB, -- unlimited

			-- 5) rows data path and file name
			filename = 'path' -> file ext .mdf
		)

		-- Transaction Log
		log on
		(
				-- 1) log logical filename 
				name = 'Database_name_log', -> must add _log

				-- 2) log initial file size (1/4 of the rows data file size)
				size = 3MB,

				-- 3) log auto growth size
				filegrowth = value%, 

				-- 4) log maximum size
				maxsize = value MB|GB,

				-- 5) log path and file name
				filename = 'path' -> file ext .mdf 
		)
*/

create database AragonPharmacy
	-- data file
	on primary
	(	--1) rows data logical filename
		name = 'AragonPharmacy',

		-- 2) rows data initial file size
		size = 20MB,

		-- 3) rows data auto growth size
		filegrowth = 12MB,

		-- 4) rows data maximum size
		maxsize = unlimited, 

		-- 5) rows data path and file name
		filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AragonPharmacy.mdf' -- -> file ext .mdf
	)
	-- Transaction log
	log on
		(
			-- 1) log logical filename 
			name = 'AragonPharmacy_log', -- -> must add _log

			-- 2) log initial file size (1/4 of the rows data file size)
			size = 5MB,

			-- 3) log auto growth size
			filegrowth = 10% , 

			-- 4) log maximum size
			maxsize = 250 MB,

			-- 5) log path and file name
			filename = 'C:\Program Files\Microsoft SQL Server\MSSQL15.MSSQLSERVER\MSSQL\DATA\AragonPharmacy_log.mdf' -- -> file ext .ldf 	
		)
;
go

