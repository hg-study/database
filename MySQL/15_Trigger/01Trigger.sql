-- =======================================
-- TRIGGER
-- after update, after delete 트리거로 변경 전 데이터를 백업 테이블에 저장
-- =======================================
-- Trigger: 테이블에 insert, update, delete가 발생하면 자동으로 실행되는 프로시저
-- after는 변경 후, before는 변경 전에 실행하고, old는 변경 전 행, new는 변경 후 행을 가리킨다

use shopdb;
-- 01 After Trigger

drop table c_usertbl;
create table c_usertbl select * from usertbl;
select * from c_usertbl;
create table c_usertbl_bak like c_usertbl;
select * from c_usertbl_bak;
alter table c_usertbl_bak add column type char(5);
alter table c_usertbl_bak add column U_D_date char(5);
alter table c_usertbl_bak change column U_D_date U_D_date datetime;
desc c_usertbl_bak;
select * from c_usertbl_bak;


delimiter $$
create trigger trg_c_usertbl_update
after update
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,
    old.mDate,'수정',now()
    );
end $$
delimiter ;

show triggers;
show create trigger trg_c_usertbl_update;

select * from c_usertbl;
select * from c_usertbl_bak;
update c_usertbl set name='바비' where userid='BBK';
update c_usertbl set addr='경남' where userid='EJW';


-- 02 삭제 트리거
delimiter $$
create trigger trg_c_usertbl_delete
after delete
on c_usertbl
for each row
begin
	insert into c_usertbl_bak values(
    old.userid,old.name,old.birthyear,old.addr,old.mobile1,old.mobile2,old.height,
    old.mDate,'삭제',now()
    );
end $$
delimiter ;

delete from c_usertbl where userid='KKH';
select * from c_usertbl_bak;

-- 문제: buytbl로 같은 방식의 트리거 만들기
-- 1 buytbl을 c_buytbl로 구조와 값 복사
drop table if exists c_buytbl;
create table c_buytbl select * from buytbl;
-- 2 c_buytbl의 구조만 복사한 c_buytbl_bak 만들기
drop table if exists c_buytbl_bak;
create table c_buytbl_bak like c_buytbl;
-- 3 c_buytbl_bak에 type char(5)와 mDate datetime 열 추가
alter table c_buytbl_bak add column type char(5);
alter table c_buytbl_bak add column mDate datetime;
-- 4 c_buytbl의 update 시 c_buytbl_bak에 내용을 저장하는 트리거
delimiter $$
create trigger trg_c_buytbl_update
after update
on c_buytbl
for each row
begin
	insert into c_buytbl_bak values(
    old.num,old.userid,old.prodname,old.groupname,old.price,old.amount,'수정',now()
    );
end $$
delimiter ;
-- 5 c_buytbl의 delete 시 c_buytbl_bak에 내용을 저장하는 트리거
delimiter $$
create trigger trg_c_buytbl_delete
after delete
on c_buytbl
for each row
begin
	insert into c_buytbl_bak values(
    old.num,old.userid,old.prodname,old.groupname,old.price,old.amount,'삭제',now()
    );
end $$
delimiter ;
-- 확인
update c_buytbl set amount=amount+1 where num=1;
delete from c_buytbl where num=2;
select * from c_buytbl_bak;
