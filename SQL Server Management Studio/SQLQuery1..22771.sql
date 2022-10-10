--create database training

use training


--TSQL




declare @name varchar(50), @dept varchar(50)
set @name='Bhanu'
set @dept='Training'
--print @name
select @name
select @dept



declare @presentage INT = 21
if @presentage >=45
print 'you are old'
if @presentage <=25
print 'you are young'


declare @age int=22
if @age <=21
print 'you are young'
else
print 'you are old'


declare @presentage int=33
if @presentage <=44
print 'old age'
else if @presentage <=33
print 'old age'
else if @presentage <=23
print 'young age'



DECLARE @TEST INT
SET @TEST=60
SELECT 
CASE 
WHEN @TEST>1 AND @TEST<=20 THEN 'FAIL'
WHEN @TEST>20 AND @TEST<50 THEN 'PASS'
WHEN @TEST>50  THEN 'DESTINCTION'
ELSE 'OTHER'
END;
 



declare @presentage int=24
while @presentage <=50
begin
print 'young age '
if @presentage = 49
set @presentage = @presentage +1
end



declare @name varchar(40)
set @name='Bhanu'
select upper(@name) as name

select lower('BHANU') as name

select ename, lower(ename) lowername from emp



select REVERSE('BHANU') as profile

select left('bhanu',3) as letters

select concat ('bhanu', 'teja') as name

select lower ( 'BHANU') as small

select LTRIM ( '           bhanu ') as leftTrimmedfunction

select UPPER ( 'bhanu') as caps

select trim ( '@$ 'from '@Teja$') AS TRIMMED

select rtrim ('BHANU        ') AS RIGHTTRIMMEDSTRING

SELECT REPLACE ('BHANU','A','J') AS MERGED

SELECT SUBSTRING ('BHANU',1,4) AS SUB

SELECT GETDATE() 

SELECT DATENAME(MONTH,'2022/08/19')

SELECT DATEPART(MONTH, '2022/08/19')

SELECT DAY ('2022/08/19')

SELECT MONTH ('2022/08/19')

SELECT YEAR ('2022/08/18')

SELECT DATEDIFF(MONTH,'2022/08/19','2025/09/20')

SELECT DATEADD (YEAR , 5, '2022/08/18')

SELECT CAST(44.8 as int)

select convert (int , 97.43)









