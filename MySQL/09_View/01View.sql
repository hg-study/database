-- =======================================
-- VIEW
-- select 결과를 저장한 가상 테이블. view 생성, 조회, 수정(or replace), 조인 view의 insert 제한
-- =======================================
-- ---------------------------
-- View (참고: https://coding-factory.tistory.com/224)
-- ---------------------------
-- View(뷰)는 복잡한 쿼리를 재사용하거나,
-- 보안 상 사용자에게 제한된 열만 제공할 때 사용하는 가상 테이블

use shopdb;
select * from usertbl;
select * from buytbl;

-- 1. 기본 뷰 생성 (사용자 ID, 이름, 주소, 연락처)
create view view_01   
as 
select userid, name, addr, concat(mobile1,'-',mobile2) as 'phone' from usertbl;

select * from view_01; -- 데이터 조회
show create view view_01; -- 소스코드 확인
select * from information_schema.views where table_schema= 'shopdb'; -- 메타데이터 조회
desc view_01; -- 구조 확인

-- 2. WHERE 조건이 포함된 뷰 (서울/경기 거주자만)
-- or replace: 없으면 새로 만들고, 있으면 덮어씌운다.
create or replace view view_02
as 
select userid, name, addr, concat(mobile1,'-',mobile2) as 'phone' 
from usertbl
where addr in ('서울','경기');

select * from view_02;

-- 두 테이블 조인해 view 만들기

create view view_03  
as 
select U.userid, name, addr, concat(mobile1,'-',mobile2) as 'phone', prodName, price, amount 
from usertbl U
inner join buytbl B
on U.userid = B.userid;

select * from view_03;

-- 세 테이블 조인해 view 만들기

create view view_04
as 
select C.name  as 'countryname', CT.name, C.region, CT.population, C.Capital, CL.Language
from world.country C

inner join world.city CT
on C.Code = CT.countryCode

inner join world.countrylanguage CL
on C.Code = CL.countryCode
order by C.name asc
;

select * from view_04;

-- 두 테이블을 조인한 view에는 값을 넣을 수 있는지 확인
drop table tbl_a;
drop table tbl_b;

create table tbl_a(
	col1 int  primary key,
    col2 int 
);
create table tbl_b(
	col3 int  primary key,
    col4 int 
);

create or replace view view_a_b
as
select col1, col3
from tbl_a
inner join tbl_b;

desc tbl_a;
desc tbl_b;
select * from tbl_a;
select * from tbl_b;
select * from view_a_b;

-- 각 테이블 값 넣기
insert into tbl_a values(1,10);
insert into tbl_b values(2,20);

-- view통해 값 넣기
-- join된 view table은 insert 불가(단일 view table은 제약조건 만족하면 가능)
-- insert into view_a_b (col1, col3) values(3,4); -- 오류
insert into view_a_b (col1) values(3);
insert into view_a_b (col3) values(4);
