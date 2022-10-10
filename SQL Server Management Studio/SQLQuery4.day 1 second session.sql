
CREATE TABLE DEPT (
DEPTNO              int NOT NULL,
DNAME               VARCHAR(14),
LOC                 VARCHAR(13),
CONSTRAINT DEPT_PRIMARY_KEY PRIMARY KEY (DEPTNO));

INSERT INTO DEPT VALUES (10,'ACCOUNTING','NEW YORK');
INSERT INTO DEPT VALUES (20,'RESEARCH','DALLAS');
INSERT INTO DEPT VALUES (30,'SALES','CHICAGO');
INSERT INTO DEPT VALUES (40,'OPERATIONS','BOSTON');

CREATE TABLE EMP (
EMPNO               int NOT NULL,
ENAME               VARCHAR(10),
JOB                 VARCHAR(9),
MGR                 int CONSTRAINT EMP_SELF_KEY REFERENCES EMP (EMPNO),
HIREDATE            DATE,
SAL                 int,
COMM                int,
DEPTNO              int NOT NULL,
CONSTRAINT EMP_FOREIGN_KEY FOREIGN KEY (DEPTNO) REFERENCES DEPT (DEPTNO),
CONSTRAINT EMP_PRIMARY_KEY PRIMARY KEY (EMPNO));

INSERT INTO EMP VALUES (7839,'KING','PRESIDENT',NULL,'17-NOV-81',5000,NULL,10);
INSERT INTO EMP VALUES (7698,'BLAKE','MANAGER',7839,'1-MAY-81',2850,NULL,30);
INSERT INTO EMP VALUES (7782,'CLARK','MANAGER',7839,'9-JUN-81',2450,NULL,10);
INSERT INTO EMP VALUES (7566,'JONES','MANAGER',7839,'2-APR-81',2975,NULL,20);
INSERT INTO EMP VALUES (7654,'MARTIN','SALESMAN',7698,'28-SEP-81',1250,1400,30);
INSERT INTO EMP VALUES (7499,'ALLEN','SALESMAN',7698,'20-FEB-81',1600,300,30);
INSERT INTO EMP VALUES (7844,'TURNER','SALESMAN',7698,'8-SEP-81',1500,0,30);
INSERT INTO EMP VALUES (7900,'JAMES','CLERK',7698,'3-DEC-81',950,NULL,30);
INSERT INTO EMP VALUES (7521,'WARD','SALESMAN',7698,'22-FEB-81',1250,500,30);
INSERT INTO EMP VALUES (7902,'FORD','ANALYST',7566,'3-DEC-81',3000,NULL,20);
INSERT INTO EMP VALUES (7369,'SMITH','CLERK',7902,'17-DEC-80',800,NULL,20);
INSERT INTO EMP VALUES (7788,'SCOTT','ANALYST',7566,'09-DEC-82',3000,NULL,20);
INSERT INTO EMP VALUES (7876,'ADAMS','CLERK',7788,'12-JAN-83',1100,NULL,20);
INSERT INTO EMP VALUES (7934,'MILLER','CLERK',7782,'23-JAN-82',1300,NULL,10);


SELECT * FROM EMP

------------------------------------------------------------------------------------------------------------------------------------
create procedure GetEmpDetails(@EMPID INT)
as
begin
select * from emp where EMPNO = @EMPID
end
exec GetEmpDetails @EMPID = 7788



UPDATE EMP

create procedure updatenames (@empno int, @newname varchar(50))
as
begin
update emp
set ename=@newname
where empno=@empno
end

exec updatenames 7499, 'Sheela'

select * from emp where empno=7499



HELLO WORLD

create function helloworld()
returns varchar(50)
begin
return 'hello world'
end

select dbo.helloworld()



ADDING OF 2 NUMBERS

create function sum(@a int , @b int)
returns int
begin 
return @a + @b
end
select dbo.sum(4,5)


















ANNUAL SALARY


create function getannualsalarybyempno(@empno int)
returns int
begin
declare @sal int
select @sal=sal from emp where empno=@empno
return @sal*14
end

select* from emp

select dbo.getannualsalarybyempno(7499)

-------------------------------------------------------------------------------------------------------------------------


DELETE THAT PERSOM EMP TABLE

CREATE PROCEDURE DELETEEMPLOYEE(@EMPNO INT)
AS
BEGIN
DELETE FROM EMP WHERE EMPNO=@EMPNO
END

EXEC DELETEEMPLOYEE 7369


SELECT* FROM EMP WHERE EMPNO=7369


------------------------------------------------------------------------------------------------------------------------

EARNING SALARY FOR EACH PERSON

declare empcursor cursor for select empno,ename,sal from emp
declare @name varchar(10),@sal int,@empno int
open empcursor 
--print @@fetch_status
fetch next from empcursor into @empno,@name,@sal
while @@fetch_status=0
begin
print @name + 'is earning ' + cast(@sal as varchar)
fetch next from empcursor into @empno,@name,@sal
end
close empcursor
deallocate empcursor


USE TRAINING

SELECT * FROM EMP

SELECT ENAME+ 'IS EARNING' + CAST(SAL AS VARCHAR)FROM EMP





---------------------------------------------------------------------------------------------------------------------------------


CREATE TABLE Employee_Test
(
Emp_ID INT Identity,-- starts with one increments by 1
Emp_name Varchar(100),
Emp_Sal Decimal (10,2)
)
INSERT INTO Employee_Test VALUES ('Anees',1000);
INSERT INTO Employee_Test VALUES ('Rick',1200);
INSERT INTO Employee_Test VALUES ('John',1100);
INSERT INTO Employee_Test VALUES ('Stephen',1300);
INSERT INTO Employee_Test VALUES ('Maria',1400);

SELECT * FROM EMPLOYEE_TEST

CREATE TABLE Employee_Test_Audit
(
Emp_ID int,
Emp_name varchar(100),
Emp_Sal decimal (10,2),
Audit_Action varchar(100),
Audit_Timestamp datetime
)
SELECT * FROM EMPLOYEE_TEST_AUDIT

----------------------------------------------------------------------------------------------------------------------------------
--THIS TRIGGER IS FIRED AFTER AN INSERT ON THE TABLE


CREATE TRIGGER trgAfterInsert on Employee_Test
FOR INSERT
AS
     declare @empid int;
	 declare @empname varchar(100);
	 declare @empsal decimal(10,2);
	 declare @audit_action varchar(100);
	 select @empid=i.Emp_ID from inserted i;
	 select @empname=i.Emp_Name from inserted i;
	 select @empsal=i.Emp_Sal from inserted i;
	 set @audit_action='Inserted record -- After Insert Trigger.'
	 insert into Employee_Test_Audit
	 values(@empid,@empname,@empsal,@audit_action,getdate());
	 print 'AFTER INSERT TRIGGER FIRED.'
	 GO

	 
	 SELECT * FROM EMPLOYEE_TEST



	
	----------------------------------------------------------------------------------------------------------------------------


	 CREATE TRIGGER trgAfterDelete on Employee_Test
FOR delete
AS
     declare @empid int;
	 declare @empname varchar(100);
	 declare @empsal decimal(10,2);
	 declare @audit_action varchar(100);
	 select @empid=i.Emp_ID from deleted i;
	 select @empname=i.Emp_Name from deleted i;
	 select @empsal=i.Emp_Sal from deleted i;
	 set @audit_action='delete record -- After delete Trigger.'
	 insert into Employee_Test_Audit
	 values(@empid,@empname,@empsal,@audit_action,getdate());
	 print 'AFTER delete TRIGGER FIRED.'
	 GO

	 delete from Employee_Test where EMP_ID = 6
	 SELECT * FROM Employee_Test

	 SELECT * FROM Employee_Test_Audit


----------------------------------------------------------------------------------------------------------------------------------------------------

create TRIGGER trgDELETE on emp
INSTEAD OF DELETE
	 as
		declare @empno int;
		declare @job varchar(100);
		select @job=d.job from deleted d;
		select @empno=d.empno from deleted d;
		BEGIN
	       if(@job='PRESIDENT')
		   begin
		   RAISERROR('cannot delete this person who is vvip',16,1);
		   end
		   else 
		   begin
		        delete from emp where empno=@empno;
				print 'record deleted -- instead of delete trigger.'
			end
		end
GO

	DELETE from emp where EMPNO = 7499

			SELECT * FROM EMP WHERE EMPNO=7369

---------------------------------------------------------------------------------------------------------------------------


			--update salary



	UPDATE EMP SET SAL=10 WHERE EMPNO=7369

	SELECT * FROM EMP WHERE EMPNO =7566


---------------------------------------------------------------------------------------------------------------------------------


CREATE TRIGGER TRGEMPSALUPDATE ON EMP
INSTEAD OF UPDATE
AS
DECLARE @CURRENTSAL INT;
DECLARE @PROPOSEDSAL INT;
DECLARE @EMPNO INT;
SELECT @CURRENTSAL=D.SAL FROM DELETED D;
SELECT @PROPOSEDSAL=I.SAL FROM INSERTED I;
SELECT @EMPNO=E.EMPNO FROM INSERTED E;
BEGIN
IF(@CURRENTSAL>@PROPOSEDSAL)
BEGIN
RAISERROR('CANNOT UPDATE THIS SAL',16,1);
END 
BEGIN
 UPDATE EMP SET SAL=@PROPOSEDSAL WHERE EMPNO=@EMPNO;
PRINT'RECORD UPDATED -- INSTEAD OF UPDATE TRIGGER.'
END 
END

UPDATE EMP SET SAL=3000 WHERE EMPNO=7566

SELECT * FROM EMP WHERE EMPNO =7566







--------------------------------------------------------------------------------------------------------------------------


CREATE TABLE Person (
  id INT,
  Securityno INT,
  Sal numeric(18,9),
  DOB DATETIME,
  Name VARCHAR(80)
);
GO
----------------------------------------------------------------------------------------------------------------------------- 

 -- Insert rows with random values
DECLARE @row INT;
DECLARE @string VARCHAR(80), @length INT, @code INT;
SET @row = 0;
WHILE @row < 100000 BEGIN
   SET @row = @row + 1;

-------------------------------------------------------------------------------------------------------------------------------- 

   -- Build the random string
   SET @length = ROUND(80*RAND(),0);
   
   SET @string = 'Name';
   WHILE @length > 0 BEGIN
      SET @length = @length - 1;
      SET @code = ROUND(32*RAND(),0) - 6;     
         SET @string = @string + CHAR(ASCII('a')+@code-1);     
   END 

 -------------------------------------------------------------------------------------------------------------------------------

   -- Ready for the record
   SET NOCOUNT ON;
   INSERT INTO person VALUES (
      @row,
      ROUND(2000000*RAND()-1000000,0),
      ROUND(2000000*RAND()-1000000,9),
      CONVERT(DATETIME, ROUND(60000*RAND()-30000,9)),
      @string
   )
END

-----------------------------------------------------------------------------------------------------------------------------------------
 

update person set name='John' where id between 1 and 5000
update person set name='Peter' where id between 5001 and 10000
update person set name='Mark' where id between 10001 and 15000
update person set name='Gray' where id between 15001 and 20000
update person set name='Levy' where id between 20001 and 25000
update person set name='Chris' where id between 25001 and 30000
update person set name='Jason' where id > 30000

-----------------------------------------------------------------------------------------------------------------------------------
create clustered index name_idx
on person(name)

select * from person
where name = 'john'

set statistics io, time off

create clustered index name1_idx
on name1(sal)


------------------------------------------------------------------------------------------------------------------------------------------------

begin try 
  insert into emp(empno) values (1234)
  end try 
  begin catch
  begin
  print @@error
  end
  end catch

-------------------------------------------------------------------------------------------------------------------------------

  begin try 
  insert into emp(empno,deptno) values (1234,10)
  print 'completed'
  end try 
  begin catch
  print @@error
  end catch

  -------------------------------------------------------------------------------------------------------------------------------

  end catch;
  exec usp Exampleproc


  select * from master .dbo. sysmessages where error =515 and msdlangid=1033

  insert into emp(empno) values(5555)

-------------------------------------------------------------------------------------------------------------------------------

--nested try catch block
begin try 
print 'at outer try block'
insert into emp(empno)
 values(5689)
 begin try
   print 'at inner try block'
   end try 
   begin catch
     print ' at inner catch block'
	 end catch
end try
begin catch
  print ' at outer catch block'
  end catch

----------------------------------------------------------------------------------------------------------------------------------