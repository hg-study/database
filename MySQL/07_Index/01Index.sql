-- =======================================
-- INDEX
-- 클러스터형, 보조, 결합 인덱스 생성과 삭제, 인덱스 유무에 따른 조회 성능 비교(employees)
-- =======================================
-- -----------------
-- INDEX
-- -----------------
-- 데이터 베이스 테이블의 검색 성능을 향상시키기 위해 사용되는 데이터 구조
-- where 이하 조건절열에 index로 지정된 열을 사용한다
-- index로 지정된 열은 기본적으로 정렬 처리가 된다(모든 DBMS는 아님)

-- -----------------
-- MYSQL INDEX 검색 알고리즘 종류
-- -----------------
-- B-Tree : 기본값 , 대부분의 데이터 index에 잘 적용되어 사용
-- Hash : 해시 함수를 이용한 index , 정확한 일치 검색에 사용(포함검색에는 다소 성능이 저하될수 있다)
-- Full-text : 전체 텍스트 검색에 사용되는 index , 텍스트 검색기능 향상시 유리
-- Spatial : 공간데이터(위도/경도등을 담는 지도데이터)을 처리하기 위한 Index, 지리 정보 검색에 유리

-- -----------------
-- MYSQL INDEX TYPE 
-- -----------------
-- 클러스터형 인덱스	: PK열에 기본적으로 적용되는 index , 사전편찬 순서에 맞게 정렬이 된다. [기본 : B-Tree]
-- 						: 한테이블에 한개만 생성
-- 						: 실제 데이터의 정렬이 인덱스의 순서로 정렬
-- 						: 보조인덱스보다 빠른 속도
                        
-- 보조(Secondary) 인덱스	: PK이외 다른 제약조건이나 수동으로 설정시 적용 [기본 : B-Tree]
-- 						: 한테이블에 여러 Index를 생성



-- 01 제약조건 PK 설정시 unique index 확인
use testdb;
create table tbl_a(     	-- 기본키: 중복 불가, NULL 불가
	col1 int primary key,	-- 고유키: 중복 불가, NULL 허용 (클러스터형 인덱스 생성)
    col2 int 				-- 일반 컬럼: 제약 조건 없음
);

desc tbl_a;
show index from tbl_a;  -- 생성된 인덱스 목록 테이블 형태 출력

-- MySQL은 PK 설정 시 입력 순서대로 쌓지 않고 PK 기준 오름차순으로 정렬한다. 
-- 따라서 3을 나중에 넣었더라도 정렬되어 3,1이 먼저 출력된다.
insert into tbl_a values(5,1);
insert into tbl_a values(3,1);
select * from tbl_a;


-- 02 제약조건 unique 설정시 unique index 확인
create table tbl_b
(
	col1 int primary key, 	-- 클러스터형 인덱스 (정렬 기준점)
	col2 int unique,		-- 보조 인덱스
    col3 int
);
desc tbl_b;
show index from tbl_b;

-- col1(기준점) 기준 오름차순 정렬됨.
insert into tbl_b values(6,5,1);	-- 1번째
insert into tbl_b values(4,7,1);	-- 2번째
insert into tbl_b values(1,2,1);	-- 3번째

select * from tbl_b;

-- 03 index 삭제
use testdb;
show index from tbl_b; 	-- col1에 PRIMARY KEY 인덱스, col2에 UNIQUE 인덱스 생성된 상태
desc tbl_b;
alter table tbl_b drop primary key; -- 기본키 삭제
show index from tbl_b; -- 사라져 있음을 확인
alter table tbl_b drop constraint col2; -- 고유키 삭제
-- alter table tbl_b drop index [인덱스명]; -- 위 또는 아래 사용
desc tbl_b;
show index from tbl_b;

-- 보조 인덱스 추가
-- 클러스터 인덱스, 보조 인덱스와 같은 값 중복 불가
create table tbl_c
(
	col1 int primary key, -- PK 클러스터형 인덱스
    col2 int,
    col3 int,
    unique index col2_index(col2) -- 보조 인덱스 생성,인덱스 이름 직접 지정
);
show index from tbl_c;

-- 결합 인덱스 추가
-- 각각 컬럼 값은 중복될 수 있지만 클러스터 인덱스, 결합 인덱스는 중복 불가.
-- 1,2 추가 후 1,2 추가 불가. 1,3이나 2, 2는 추가 가능.
create table tbl_d
(
	col1 int primary key, -- PK 클러스터형 인덱스
    col2 int,
    col3 int,
    unique index col2_3_index(col2,col3) -- 둘 결합해 보조 인덱스 생성
);
show index from tbl_d;

-- 테이블 먼저 생성 후 인덱스 추가 생성
-- 보조 인덱스 추가

create table tbl_e
(
	col1 int primary key,
    col2 int,
    col3 int 
);
show index from tbl_e;
create index col2_idx on tbl_e(col2); -- 중복 허용 보조 인덱스 생성 (UNIQUE:중복불허 미포함)
show index from tbl_e;

-- 외래키 설정 -> 그로 인해 참조 무결성 위해 인덱스 자동생성

create table tbl_f
(
	col1 int primary key,
    tbl_e_col1 int,
    col3 int,
    constraint Fk_tbl_f_tbl_e foreign key(tbl_e_col1) references tbl_e(col1)
    on update cascade
    on delete cascade
);
show index from tbl_f; -- 인덱스 확인



-- --------------------------------
-- Index 성능확인
-- --------------------------------
use employees;
select count(*) from employees.salaries;    -- 전체 행 개수 확인
SELECT * FROM employees.salaries;			-- 전체 데이터 조회
SELECT * FROM employees.salaries where to_date = '1986-01-01';	-- 인덱스 없는 상태에서 모든 행 조회
create index to_date_idx on employees.salaries(to_date);	-- 인덱스 생성
show index from employees.salaries;							-- 인덱스 확인
alter table employees.salaries drop index to_date_idx;		-- 인덱스 삭제
SELECT * FROM employees.salaries where to_date = '1986-12-01';  -- 다시 조회
