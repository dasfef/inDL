/* WHILE 문 */
declare @num int = 1
while @num <= 10
	begin
		print @num
		set @num = @num + 1
	end


/* while문 활용 구구단 */
declare @dan int = 2
declare @num int = 1

while @dan < 10
	begin
		print convert(nvarchar(10), @dan) + '단'
		set @num = 1
	
	while @num < 10
		begin
			print convert(nvarchar(10), @dan) + ' X ' + convert(nvarchar(10), @num) + ' = ' + convert(nvarchar(10), @dan * @num)
			set @num = @num + 1
		end
		set @dan = @dan + 1
		print ''
	end


/* STUFF, FOR XML 활용하여 옆으로 배열시키기 */
use SAMPLE

select distinct TYPE, 
	STUFF(
		(select ',' + CUSTOMER_ID
			from sales
			where TYPE = s.TYPE
			for XML PATH(''))
		,1,1,'') as Name
	from sales as s


/* with 구문 */
with TEMP_TABLE as
(
	SELECT E.ORG_NAME, A.USER_NAME
	FROM GAM_NLS_USER A
	JOIN GAM_USER_INNER B ON A.USER_ID = B.USER_ID AND B.HT_NO=1
	LEFT JOIN GAM_ORG_USER C ON C.USER_ID = A.USER_ID
	LEFT JOIN GAM_ORG D ON D.ORG_ID = C.ORG_ID
	JOIN GAM_NLS_ORG E ON E.ORG_ID = D.ORG_ID AND E.LCID = 1042 AND E.ORG_NAME IS NOT NULL
	WHERE A.LCID = 1042
)

select distinct ORG_NAME,
	stuff(
		(select ',' + USER_NAME
			from TEMP_TABLE
			where ORG_NAME = s.ORG_NAME
			for XML PATH(''))
		,1,1,'') as USER_NAME
	from TEMP_TABLE as s
		
		
/* PROCEDURE */
select * from sales

create procedure getSaleByType
	@type = nvarchar(max)
	as
		begin
			select TYPE, CUSTOMER_ID, PRICE
			from sales
			where TYPE = @type;
		end

exec getSaleByType @type = 반팔


/* 동적쿼리 */
select * from emp

declare @query nvarchar(max),
		@where nvarchar(max),
		@parameter nvarchar(max),
		@output nvarchar(max)
set @parameter ='20'

--set @where = 'deptno =' +  @parameter
set @query = 'select * from emp where deptno =' + @parameter 

exec sp_executesql @query
