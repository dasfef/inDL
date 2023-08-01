select * from ORDER_INFO
select * from ITEM
select * from CUSTOMER

select * from ORDER_INFO A
	inner join ITEM B
	on A.OrderItemCd = B.ItemCd

select * from ORDER_INFO A
	full outer join ITEM B
	on A.OrderItemCd = B.ItemCd

/* ����1-1: ����ں� ���� �Ѿ� */
select CustomerId, SUM(Price) as 'SUM_PRICE'
	from ORDER_INFO A
	inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	group by CustomerId

/* ����1-2: 'B456' ���� ���� �Ѿ� */
select CustomerId, SUM(Price) as 'SUM_PRICE'
	from ORDER_INFO A
	inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where CustomerId = 'B456'
	group by CustomerId

/* ����2: ����ǰ���ڵ��� ǰ�� �հ�, �Ѱ踦 ������ �࿡ ǥ�� */
select 
	case grouping(OrderItemCd) 
		when 1 then '�հ�'
		else OrderItemCd end as OrderItemCd,
	sum(Price) as PRICE_TOTAL
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd
	group by OrderItemCd
	with rollup
	
/* ����3: OrderDate �� ��¥���� ���� �ݾ��� �� �հ� ǥ�� */
select 
	convert(char(10), OrderDate, 23) as 'OrderDate',
	sum(price) as '�հ�'
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd
	group by OrderDate

/* ����4-1: SALE_YN �÷��� BOOLEAN ǥ�� */
select
	OrderId, CustomerId, OrderItemCd, OrderDate, 
	case OrderItemCd
		when 'A0001' then 'Y'
		else 'N' end as 'SALE_YN'
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd

/* ����4-2: SALE_YN �� Y�� ��ǰ�� 10% ���� */
select
	OrderId, CustomerId, OrderItemCd, ItemNm, Price,
	case OrderItemCd
		when 'A0001' then 'Y'
		else 'N' end as 'SALE_YN',
	case OrderItemCd
		when 'A0001' then price - (price * 10 / 100)
		else price end as 'SALE_PRICE'
	from ORDER_INFO A inner join ITEM B on A.OrderItemCd = B.ItemCd
	