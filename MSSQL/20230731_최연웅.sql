/* 과제1: 테이블생성 */
create table CUSTOMER(
	ID nvarchar(20) primary key,
	PassWord nvarchar(30),
	Name nvarchar(20),
	Tel_Num nvarchar(20)
);

create table ITEM(
	ItemCd nvarchar(20) primary key,
	ItemNm nvarchar(30),
	Price INT
);

create table ORDER_INFO(
	OrderId INT primary key identity(1,1),
	CustomerId nvarchar(20) foreign key references CUSTOMER(ID) on update cascade,
	OrderItemCd nvarchar(20) foreign key references ITEM(ItemCd) on update cascade,
	OrderDate datetime
);

/* 과제2: INSERT 쿼리문 작성 */
insert into CUSTOMER values('A123', 'dlit', '디엘', '010-1234-5678');
insert into CUSTOMER values
	('B456', 'test', '디엘2', '010-4567-8901'),
	('C789', 'dltest', '디엘3', '010-9876-5432'),
	('D147', 'qwer', '디엘4', '010-8765-4321')

insert into ITEM values
	('A0001', '선풍기', 10000),
	('A0002', '텀블러', 15000),
	('A0003', '볼펜', 1000),
	('A0004', '다이어리', 12000),
	('A0005', '시계', 50000);

insert into ORDER_INFO values
	('A123', 'A0001', getdate()),
	('B456', 'A0002', getdate()),
	('C789', 'A0001', getdate()),
	('D147', 'A0003', getdate()),
	('A123', 'A0004', getdate()),
	('A123', 'A0005', getdate()),
	('B456', 'A0001', getdate()),
	('C789', 'A0005', getdate()),
	('D147', 'A0001', getdate()),
	('B456', 'A0005', getdate())

/* 과제 2-1: 수정하는 쿼리 작성 */
update CUSTOMER set ID = 'A321' where ID='A123'

/* 과제3: 조건 SELECT 쿼리 작성 */
select * from ORDER_INFO where OrderItemCd='A0005' order by OrderId desc

select * from ORDER_INFO 
where OrderItemCd='A0001' or OrderItemCd='A0004' order by OrderItemCd asc

select * from ITEM where price >= 10000 and price <= 15000 order by price asc

select * from ORDER_INFO
drop table ITEM