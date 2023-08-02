use TEST

select * from ORDER_INFO
select * from ITEM


/* ����1: union���� ��ġ�� */
select
	OrderItemCd, sum(price) as 'SUM_PRICE'
	from ORDER_INFO A inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where OrderItemCd = 'A0001'
	group by OrderItemCd

union
select
	OrderItemCd, sum(price) as 'SUM_PRICE'
	from ORDER_INFO A inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where OrderItemCd = 'A0002'
	group by OrderItemCd
	
union
select
	OrderItemCd, sum(price) as 'SUM_PRICE'
	from ORDER_INFO A inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where OrderItemCd = 'A0003'
	group by OrderItemCd

union
select
	OrderItemCd, sum(price) as 'SUM_PRICE'
	from ORDER_INFO A inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where OrderItemCd = 'A0004'
	group by OrderItemCd

union
select
	OrderItemCd, sum(price) as 'SUM_PRICE'
	from ORDER_INFO A inner join ITEM B
	on A.OrderItemCd = B.ItemCd
	where OrderItemCd = 'A0005'
	group by OrderItemCd


/* ����2: ǰ�� �հ� ���� ǥ�� */
select 
	rank() over(order by sum(price) desc) as 'RANKING',
	ItemCd, ItemNm, sum(price) as 'SUM_PRICE'
	from ITEM A inner join ORDER_INFO B
	on A.ItemCd = B.OrderItemCd
	group by ItemCd, ItemNm


/* ����3: ���Ǻ� INSERT, DELETE */
select * from CUSTOMER
if not exists(select ID from CUSTOMER where ID = 'E258')
	begin
		insert into CUSTOMER values('E258', 'aiefjwe', '��5', '010-0000-9999')
	end
else
	begin
		delete from CUSTOMER where ID = 'E258'
	end


/* ����4: ����ں� ���ް���, ����ް���, �����ް��� */
use SAMPLE
select * from WORKIN_LEAVE
select * from GAM_NLS_USER

declare @DAYOFF int
select @DAYOFF = OCCURED_COUNT+ADDED_COUNT+CARRIED_COUNT+ADJUST_COUNT+INTERIM_ENTRY_LEAVE from WORKIN_LEAVE

select USER_NAME, ACCOUNT_YEAR, [����], [LEAVE_COUNT]
	from(select USER_NAME, ACCOUNT_YEAR,
				convert(nvarchar(10),@DAYOFF) as '���ް���', 
				convert(nvarchar(10),convert(numeric(18,2),USED_COUNT)) as '����ް���', 
				convert(nvarchar(10),convert(numeric(18,2),(@DAYOFF - USED_COUNT))) as '�����ް���' 
				from WORKIN_LEAVE A inner join GAM_NLS_USER B
				on A.USER_ID = B.USER_ID 
				where LCID = 1042 and ACCOUNT_YEAR = 2022) as A
	unpivot(LEAVE_COUNT for ���� in([���ް���], [����ް���], [�����ް���])) as unpvt

declare @DAYOFF int
select @DAYOFF = OCCURED_COUNT+ADDED_COUNT+CARRIED_COUNT+ADJUST_COUNT+INTERIM_ENTRY_LEAVE from WORKIN_LEAVE
select 
	USER_NAME, ACCOUNT_YEAR, @DAYOFF as '���ް���', USED_COUNT as '����ް���', (@DAYOFF - USED_COUNT) as '�����ް���' 
	from WORKIN_LEAVE A inner join GAM_NLS_USER B
	on A.USER_ID = B.USER_ID 
	where LCID = 1042 and ACCOUNT_YEAR = 2022