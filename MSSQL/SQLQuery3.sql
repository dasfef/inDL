use SAMPLE
select * from emp

set @name nvarchar(10) = 'DLIT'
declare @name nvarchar(10) = '�ֿ���'
select @name = ename from emp
print @name

print @name

select * from emp



declare @num int = 29

if(@num > 30)
	begin
		print '30�� �̻��Դϴ�'
	end
else
	begin
		print '30�� �̻��� �ƴմϴ�'
	end

set @num = 40


select * from sales

declare @price int

/* 0~100: LOW, 100~500: MIDDLE, 500: HIGH */
select *
	case  
		when price between 0 and 100 then 'LOW',
		when price between 100 and 500 then 'MIDDLE',
		when price >= 500 then 'HIGH'
	as 'PRICE_TYPE'
	from sales



if (select count(*) from sales where TYPE='����') >= 5
	begin
		print '��ǥ�޼�'
	end
else
	begin
		print '��ǥ�̴�'
	end


select * from emp

union 
select * from sales


select 
	case grouping(TYPE) when 1 then '�հ�' else TYPE end as TYPE,
	case grouping(TYPE_DETAIL) when 1 then '�Ұ�' else convert(nvarchar(10), TYPE_DETAIL) end as TYPE_DETAIL,
	sum(price) as '����'
from sales 
group by cube(sales.type, sales.type_detail) 
-- group by TYPE,TYPE_DETAIL with rollup
	

select * from emp

select *,RANK() OVER(order by sal desc) from emp

select *,dense_rank() over(order by sal desc) from emp

select *, row_number() over(order by sal desc) from emp

select * ,ntile(4) over(order by sal desc) from emp

select *, row_number() over(partition by job order by sal desc) from emp

select *
	from (select partname, price from part) as a pivot
	(avg(price) for partname in ([p1],[p2],[p3])) as pvt

