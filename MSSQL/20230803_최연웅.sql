/* ����1: �Է� ����ŭ ��ǥ ����ϱ� */
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


/* ����2: ����, ��ȸ, ����, ���� ���ν��� �ۼ� */
use TEST
select * from CUSTOMER
update set ID='A123' where ID='A321' from CUSTOMER
create procedure insertData
	declare @CRUD nvarchar(max)

	case @CRUD
		when 'C' then (insert into CUSTOMER values('F369'))
		when 'R' then (select * from CUSTOMER)
		when 'U' then (update set ID='A321' where ID='A123' from CUSTOMER)
	begin
		