/* GROUP BY */
select count(*) as 'COUNT', CustomerId from ORDER_INFO group by CustomerId

/* LEFT, RIGHT, SUBSTRING */
select left(CustomerId, 1) as 'LEFT' from ORDER_INFO

select right(CustomerId, 2) as 'RIGHT' from ORDER_INFO

select substring(CustomerId,1,2) as 'SUB' from ORDER_INFO

/* CONVERT */
select * from ORDER_INFO
select CONVERT(char(10), OrderDate, 1) as 'DATE' from ORDER_INFO

/* CASE */
select 
	case when CustomerId like '%B%' then 'B'
		else CustomerId 
		end
	from ORDER_INFO

/* SUBQUERY */
select * from ITEM
select *, (select avg(price) from ITEM) as AVG_PRICE from ITEM

/* JOIN */
select * from ORDER_INFO
select * from ITEM

select * from ORDER_INFO A
inner join ITEM B
on A.OrderItemCd = B.ItemCd