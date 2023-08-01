select * from ORDER_INFO
select * from ITEM
select * from CUSTOMER

select * from ORDER_INFO A
	inner join ITEM B
	on A.OrderItemCd = B.ItemCd

select * from ORDER_INFO A
	full outer join ITEM B
	on A.OrderItemCd = B.ItemCd

/* 과제1-1: 사용자별 구매 총액 */
select CustomerId, SUM(Price) as 'SUM_PRICE'
	from ORDER_INFO A
	inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	group by CustomerId

/* 과제1-2: 'B456' 고객의 구매 총액 */
select CustomerId, SUM(Price) as 'SUM_PRICE'
	from ORDER_INFO A
	inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where CustomerId = 'B456'
	group by CustomerId

/* 과제2: 구매품목코드의 품목별 합계, 총계를 마지막 행에 표시 */
select 
	case grouping(OrderItemCd) 
		when 1 then '합계'
		else OrderItemCd end as OrderItemCd,
	sum(Price) as PRICE_TOTAL
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd
	group by OrderItemCd
	with rollup
	
/* 과제3: OrderDate 중 날짜별로 구매 금액의 총 합계 표시 */
select 
	convert(char(10), OrderDate, 23) as 'OrderDate',
	sum(price) as '합계'
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd
	group by OrderDate

/* 과제4-1: SALE_YN 컬럼에 BOOLEAN 표시 */
select
	OrderId, CustomerId, OrderItemCd, OrderDate, 
	case OrderItemCd
		when 'A0001' then 'Y'
		else 'N' end as 'SALE_YN'
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd

/* 과제4-2: SALE_YN 이 Y인 제품은 10% 할인 */
select
	OrderId, CustomerId, OrderItemCd, ItemNm, Price,
	case OrderItemCd
		when 'A0001' then 'Y'
		else 'N' end as 'SALE_YN',
	case OrderItemCd
		when 'A0001' then price - (price * 10 / 100)
		else price end as 'SALE_PRICE'
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd
	