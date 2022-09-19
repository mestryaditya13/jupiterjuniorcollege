------------------DimRegion-----------------------
create table Dim_Region(
Region_id int identity(1,1) not null primary key,
CITY nvarchar(50) NOT NULL,
STATE nvarchar(50) NOT NULL,
COUNTRY nvarchar(50) NOT NULL)

select * from Dim_Region
------------------Dim_Emp------------------
create table Dim_Employee(
EMPLOYEE_ID tinyint NOT NULL primary key,
EMPLOYEE_NAME nvarchar(50) NOT NULL,
GENDER nvarchar(50) NOT NULL,
DOB datetime2 NOT NULL,
BLOOD_GROUP nvarchar(50) NOT NULL,
CONTACT_NO bigint NOT NULL,
EMAIL_ID nvarchar(50) NOT NULL,
QUALIFICATION nvarchar(50) NOT NULL,
DESIGNATION nvarchar(50) NOT NULL,
DEPARTMENT nvarchar(50) NOT NULL,
SUBJECT nvarchar(50)
)

select * from Dim_Employee

-------------DimSubject-------
create table Dim_Subject(
Sub_id int identity(1,1) primary key,
SUBJECT nvarchar(50)
)

select * from  Dim_Subject
-------------Dimension_Academics-------

Create table Dim_academics(
Academic_id int identity(1,1) primary key,
Stream nvarchar(50) NOT NULL,
Class nvarchar(50) NOT NULL,
Division nvarchar(50) NOT NULL
)
select * from Dim_academics
-------------DIM_STUDENT-------

CREATE TABLE Dim_student(
STUD_id INT PRIMARY KEY IDENTITY(1,1),
ROLL_NO tinyINT,
NAME NVARCHAR(50),
GENDER NVARCHAR(50),
BLOOD_GROPUP NVARCHAR(50),
CONTACT_NO bigINT,
EMAIL_ID NVARCHAR(50)
)

select * from Dim_student


-----------------------------------facts----------------------------------------
--------------------------------Fact_Emp-----------------------------------------
 create table Fact_Emp(
   Fact_Employee_SKey int identity(1,1),
   Employee_ID tinyint,
   Foreign key (Employee_id) references Dim_employee(Employee_id),
   Region_Skey int,
   Foreign key (Region_Skey) references Dim_Region(Region_Skey),
   Subject_Key int,
   Foreign key (Subject_Key) references Dim_subject(Subject_Key),
   DOB date,
   DOJ Date,
   )
   select * from Fact_Emp
 --------------------------------Fact_Monthly_Defaulters--------------------
 Create table Fact_Monthly_Defaulters(
       Fact_Monthly_Defaulter_Skey int identity(1,1),
	   stud_Skey int,
	   Foreign key (Stud_Skey) references Dim_student(Stud_Skey),
	   Acad_Skey int,
	   Foreign key (Acad_Skey) references Dim_academics(Acad_skey),
	   DateKey int,
	    Foreign Key (DateKey) References DimDate(DateKey)
      ,[Months] int
      ,[End_of_Month] date
      ,[present] int
      ,[Total_presents] int
      ,[Monthly_Percentage] nvarchar(24)
      ,[Monthly_Defaulters] varchar(13)
         )

   select * from Fact_Monthly_Defaulters


   ------------------------------------FACT_SUBJECTWISE_DEFAULTERS-------------------------------------------------------------------
	    CREATE TABLE FACT_SUBJECTWISE_DEFAULTERS(
	   FACT_SUBJECTWISE_DEFAULTERS_SKEY INT IDENTITY(1,1), 
      stud_Skey int,
	   Foreign key (Stud_Skey) references Dim_student(Stud_Skey),
	   Acad_Skey int,
	   Foreign key (Acad_Skey) references Dim_academics(Acad_skey),
        Subject NVARCHAR(50),
        [present] INT
      ,[Total_presents] INT
      ,[Subjectwise_Percentage] NVARCHAR(24)
      ,[Subjectwise_Defaulters_NON_D] NVARCHAR(13) 
	  )
	  select * from FACT_SUBJECTWISE_DEFAULTERS

-----------------------------fact_result--------------------------------------
CREATE TABLE [Fact_Result](
	[Fact_Result_skey] [int] IDENTITY(1,1) NOT NULL,
	[Stud_Skey] [int] NOT NULL,
	FOREIGN KEY (Stud_Skey) REFERENCES DIM_STUDENT(Stud_Skey), 
	[Acad_Skey] [int] NOT NULL,
	FOREIGN KEY (Acad_Skey) REFERENCES Dim_academics(Acad_Skey),
	[Subject_key] [int] NOT NULL,
	FOREIGN KEY (SUBJECT_KEY) REFERENCES Dim_SUBJECT(SUBJECT_KEY),
	[Internal_Marks] [tinyint] NOT NULL,
	[Internal_Outoff] [tinyint] NOT NULL,
	[INTERNAL_PERCENTAGE] [nvarchar](56) NULL,
	[INTERNAL_STATUS] [nvarchar](4) NOT NULL,
	[Theory_Marks] [tinyint] NOT NULL,
	[Theory_Outoff] [tinyint] NOT NULL,
	[THEORY_PERCENTAGE] [nvarchar](56) NULL,
	[THEORY_STATUS] [nvarchar](4) NOT NULL,
	[TOTAL_MARKS_OBTAINED] [tinyint] NULL,
	[TOTAL_MARKS] [tinyint] NULL,
	[SUBJECT_WISE_PERCENTAGE] [nvarchar](56) NULL,
	[OVERALL_MARKS_TOTAL] [float] NULL,
	[TOTAL] [int] NULL,
	[SUBJECT_WISE_STATUS] [nvarchar](4) NOT NULL,
	[OVERALL_PERCENTAGE] [nvarchar](501) NULL,
	[Result_status] [nvarchar](4) NOT NULL
 )
 select * from [Fact_Result]
		
----------------------[Fact_Student]------------------------------------------
	
	CREATE TABLE [Fact_Student](
	[Fact_Student] [int] IDENTITY(1,1) NOT NULL,
	stud_Skey int,
	Foreign key (Stud_Skey) references Dim_student(Stud_Skey),
	Acad_Skey int,
	Foreign key (Acad_Skey) references Dim_academics(Acad_skey),
	Region_Skey int,
    Foreign key (Region_Skey) references Dim_Region(Region_Skey),
	[Subject_key] [int] NOT NULL,
	FOREIGN KEY (SUBJECT_KEY) REFERENCES Dim_SUBJECT(SUBJECT_KEY),
	DateKey int,
	Foreign Key (DateKey) References DimDate(DateKey),
	[DOB] [datetime2](7) NOT NULL,
	[Admission_Date] [datetime2](7) NOT NULL
)

select * from [Fact_Student]
------------------------------------Fact_Salary----------------------------------------------------------
Create table Fact_Salary(
       Fact_Salary_Skey int identity(1,1),
       [Employee_ID] tinyint,
	   Foreign Key (Employee_ID) References Dim_Emp(Employee_ID),
		 DateKey int,
		 Foreign Key (DateKey) References DimDate(DateKey),
		 [YEARS] int 
		 ,[MONTHS] int 
	, [End_OF_Month] nvarchar(255)
      ,[Total_Half_Day] int
      ,[Leaves_Taken] int
      ,[Number_Of_Leaves] int
      ,[Pending_Leaves] int
	  ,[Salary] int
      ,[Total_Deduction] int
      ,[Revised_Salary] int
      )
	  select * from Fact_Salary