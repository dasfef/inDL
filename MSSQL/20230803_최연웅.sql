/* 과제1: 입력 수만큼 별표 출력하기 */
declare @cnt int = 1
declare @num int = 20
declare @X int = 1
declare @star nvarchar(max) = '*'

while @cnt <= @num
begin
	while @X <= @cnt
	begin
		print @star
		set @star = @star + '*'
		set @X = @X + 1
	end
	set @cnt = @cnt + 1
end


/* 과제2: 삽입, 조회, 삭제, 수정 프로시저 작성 */
use TEST
select * from CUSTOMER

create procedure crudData
	@CRUD nvarchar(2)
as
	if @CRUD='C'		-- @CRUD가 C일때
		begin
			insert into CUSTOMER values('F369', 'poiu', '디엘5', '010-1212-3434')
		end
	else if @CRUD='R'	-- @CRUD가 R일때
		begin
			select * from CUSTOMER
		end
	else if @CRUD='U'	-- @CRUD가 U일때
		begin
			update CUSTOMER set ID='A321' where ID='A123'
		end
	else				-- @CRUD가 D일때
		begin
			delete from CUSTOMER where ID='E258'
		end

exec crudData 'C'
exec crudData 'R'
exec crudData 'U'
exec crudData 'D'


/* 과제3: 프로시저 작성 */
select * from CUSTOMER
select * from ITEM

create procedure SQL_TEST
	@TYPE nvarchar(2)			-- 프로시저 매개변수 선언
	as
		-- 변수 선언
		declare @QUERY nvarchar(max)
		declare @WHERE nvarchar(max)
		declare @FROM nvarchar(max)

		if @TYPE='C'			-- @TYPE = C 일때
			begin
				set @WHERE = 'ID=''B456'''
				set @FROM = 'from CUSTOMER where ' + @WHERE
				set @QUERY = 'select ID ' + @FROM
			
				exec SP_EXECUTESQL @QUERY
			end
		
		else if @TYPE='I'		-- @TYPE = I 일때
			begin
				set @WHERE = 'where ItemCd=''A0002'''
				set @FROM = 'from ITEM ' + @WHERE
				set @QUERY = 'select ItemNm ' + @FROM

				exec SP_EXECUTESQL @QUERY
			end

exec SQL_TEST 'C'
exec SQL_TEST 'I'




/* 과제4: 직군별 년월별 입사 건수 동적쿼리 작성 */
-- [[ 프로세스 선행 ]] --
use SAMPLE
select * from emp

-- 조건에 충족하는 job, hiredate 출력
select job, hiredate from emp where hiredate between '1981-01-01' and '1981-06-30'

-- datetime 형식 변환(yyyyMM)
select convert(nvarchar(6), hiredate, 112) as 'hire_month' from emp where hiredate between '1981-01-01' and '1981-06-30'

-- pivot 연습 진행
select * from
	(select job, convert(nvarchar(6),hiredate,112) as 'hire_month'
	from emp
	where hiredate between '1981-01-01' and '1981-06-30') as X
	pivot (count(hire_month) for hire_month in ([198101], [198102], [198103], [198104], [198105], [198106])) as pvt

----------------------------------------------------------------------------------------------------------
-- [[ 동작 확인 ]]
-- 변수 선언
declare @SQL nvarchar(max)
declare @QUERY nvarchar(max)
declare @SUBQUERY nvarchar(max)
declare @PIVOT nvarchar(max)

-- 변수 내 들어갈 서브쿼리문 생성
set @SUBQUERY = '(select job, convert(nvarchar(6),hiredate,112) as hire_month
				from emp
				where hiredate between ''1981-01-01'' and ''1981-06-30'')'

-- with, stuff, XML PATH 로 컬럼에 들어갈 컬럼명 지정(1981-01-01 ~ 1981-06-30)
;with hTable as
(	
	select distinct
		stuff(
			(select distinct',' + '[' + convert(nvarchar(6),hiredate,112) + ']'
				from emp
				where hiredate between '1981-01-01' and '1981-06-30'
				for XML PATH(''))
			,1,1,'') as hire_month
	from emp as x
)

select @SQL = hire_month from hTable												-- with 구문 내 컬럼명 선택
set @PIVOT = 'pivot(count(hire_month) for hire_month in (' + @SQL + ')) as pvt'		-- pivot 진행
set @QUERY = 'select * from ' + @SUBQUERY + ' as X ' + @PIVOT						-- 최종 select 문 통합

-- 동적쿼리 실행
exec SP_EXECUTESQL @QUERY
