-- =======================================
-- TRANSACTION
-- start transaction, commit, rollback, savepoint, 예외 발생 시 rollback하는 프로시저
-- =======================================
-- Transaction: 여러 SQL을 하나의 작업 단위로 묶는다
-- commit: 변경 확정 / rollback: 변경 취소 / savepoint: 되돌아갈 지점 저장

create table  if not exists  tbl_test(
no	int primary key,
name varchar(20),
age int,
gender char(1)
);

delete from tbl_test;
insert into tbl_test values(1,'aa',66,'W');
insert into tbl_test values(2,'ab',66,'W');
insert into tbl_test values(3,'ac',66,'W');
select * from tbl_test;
commit;

start transaction;
	insert into tbl_test values(4,'aa',66,'W');
	insert into tbl_test values(5,'ab',66,'W');
	insert into tbl_test values(6,'ac',66,'W');
rollback;

start transaction;
	savepoint s1;
	insert into tbl_test values(4,'aa',66,'W');
	insert into tbl_test values(5,'ab',66,'W');
	insert into tbl_test values(6,'ac',66,'W');
    savepoint s2;
	insert into tbl_test values(7,'ac',66,'W');
	insert into tbl_test values(8,'ac',66,'W');
    savepoint s3;
    insert into tbl_test values(9,'ac',66,'W');
    insert into tbl_test values(10,'ac',66,'W');
    rollback to s3;
    rollback to s2;

select * from tbl_test;



-- 예외가 발생하면 rollback하는 트랜잭션 프로시저
drop procedure Tx_Test;
DELIMITER $$
create procedure TX_Test()
begin
	declare continue handler for SQLEXCEPTION
    begin
		show errors;
        rollback;
    end;
    start transaction;
		savepoint sp;
		insert into tbl_test values(4,'aa',66,'W');
		insert into tbl_test values(5,'ab',66,'W');
		insert into tbl_test values(5,'ac',66,'W');    
	commit;
    release savepoint sp;
end $$
DELIMITER ;

call TX_Test();
show procedure status;
select * from tbl_test;
 
 
