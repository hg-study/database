-- =======================================
-- JOIN
-- inner join, left와 right outer join, union으로 full outer join, 3개 이상 테이블 조인
-- =======================================
create database testdb;

use testdb;

-- [참고] https://hongong.hanbit.co.kr/sql-%EA%B8%B0%EB%B3%B8-%EB%AC%B8%EB%B2%95-joininner-outer-cross-self-join/

-- --------------------
-- JOIN
-- --------------------
-- 두 개 이상의 테이블을 연결하여 하나의 결과셋으로 출력

-- --------------------
-- JOIN 종류
-- --------------------
-- INNER JOIN: ON 조건에 맞는 데이터만 조인
-- OUTER JOIN:
--   LEFT OUTER JOIN: 왼쪽 테이블 전체 + 오른쪽 조건 일치 행
--   RIGHT OUTER JOIN: 오른쪽 테이블 전체 + 왼쪽 조건 일치 행
--   FULL OUTER JOIN: 양쪽 테이블 전체 (MySQL은 직접 지원하지 않음 → UNION으로 구현)
-- CROSS JOIN: 모든 행끼리 조인 (조건 없음)
-- SELF JOIN: 자기 자신 테이블을 조인


-- 설명:
-- INNER JOIN: 교집합.
-- OUTER JOIN:
--   LEFT OUTER JOIN: 왼쪽의 모든 데이터 + 교집합. 
--   RIGHT OUTER JOIN: 오른쪽의 모든 데이터 + 교집합. 
--   FULL OUTER JOIN: 합집합(=둘의 모든 데이터).
-- CROSS JOIN: 곱하기(왼쪽과 오른쪽을 조인한 모든 경우의 수 출력) 
-- SELF JOIN: 자기 자신 테이블을 조인

-- --------------------
-- INNER JOIN 실습
-- --------------------
-- INNER JOIN: 교집합.

use shopdb;
select * from usertbl;
select * from buytbl;
desc buytbl;

-- innerjoin_ 구매한 고객에 대한 모든 정보
select * 
from usertbl -- user테이블과
inner join buytbl -- buy테이블의 innerjoin(교집합)
on usertbl.userid = buytbl.userid; -- 고객 정보에 대한

-- innerjoin_ 원하는 컬럼만 출력
select usertbl.userID, name, addr, mobile1, mobile2, prodname, price, amount -- 원하는 컬럼 지정
from usertbl -- user테이블과
inner join buytbl -- buy테이블의 innerjoin(교집합)
on usertbl.userid = buytbl.userid; -- 고객 정보에 대한

-- innerjoin_ 별칭 지정
select U.userID, name, addr, mobile1, mobile2, prodname, price, amount -- 원하는 컬럼 지정
from usertbl U-- u라는 별칭을 가진 user테이블과
inner join buytbl B-- b라는 별칭을 가진 buy테이블의 innerjoin(교집합)
on U.userid = B.userid; -- 고객 정보에 대한

-- innerjoin_ JOIN + WHERE
select U.userID, name, addr, mobile1, mobile2, prodname, price, amount -- 원하는 컬럼 지정
from usertbl U-- u라는 별칭을 가진 user테이블과
inner join buytbl B-- b라는 별칭을 가진 buy테이블의 innerjoin(교집합)
on U.userid = B.userid -- 고객 정보에 대한
where amount >= 5; -- 5개 이상 구매한 행

-- 문제

-- 1. 바비킴의 userID, birthYear, prodName, groupName을 출력하세요.
select * from usertbl;
select * from buytbl;

select U.userID, birthYear, prodName, groupName
from usertbl U
inner join buytbl B
on U.userID = B.userID
where name='바비킴';

-- 2. amount*price의 값이 100 이상인 행의 name, addr, prodname, mobile1 - mobile2를 (Concat()함수)출력하세요.

select name, addr, prodname, concat(mobile1, '-' ,mobile2)
from usertbl U
inner join buytbl B
on U.userID = B.userID
where amount*price >= 100;

-- groupName이 '전자'인 행의 userID, birthYear, prodName, groupName을 출력하세요.

select name, U.userID, birthYear, prodName, groupName
from usertbl U
inner join buytbl B
on U.userID = B.userID
where groupNAme = '전자';

-- --------------------
-- OUTER JOIN 실습
-- --------------------

-- OUTER JOIN:
--   LEFT OUTER JOIN: 왼쪽의 모든 데이터 + 교집합. 
--   RIGHT OUTER JOIN: 오른쪽의 모든 데이터 + 교집합. 
--   FULL OUTER JOIN: 합집합(=둘의 모든 데이터).

-- LEFT OUTER JOIN: 왼쪽 테이블의 모든 행 + 조건 일치하는 오른쪽 행
select *
from usertbl U  -- LEFT
left outer join buytbl B -- RIGHT
on U.userid = B.userid;

-- RIGHT OUTER JOIN: 오른쪽 테이블의 모든 행 + 조건 일치하는 왼쪽 행
select *
from buytbl B  -- LEFT
right outer join usertbl U -- RIGHT
on U.userid = B.userid;

-- FULL OUTER JOIN: 합집합(=둘의 모든 데이터)
-- MySQL은 FULL OUTER JOIN 직접 지원x
-- 대신 UNION을 사용해 left, right를 outer join연결
-- 즉, left로 뽑고 right로 뽑아 합침

-- union: 2개 이상의 테이블에서 SELECT한 결과 집합을 하나로 합쳐서 보여주는 연산자.

select * from usertbl U left outer join buytbl B on U.userid = B.userid
union
select * from usertbl U right outer join buytbl B on U.userid = B.userid;

-- --------------------

use employees;

desc employees;
desc salaries;
desc salaries;
desc dept_emp;
desc departments;

select E.emp_no, concat(first_name,' ', last_name) as name, salary, hire_date, S.from_date, S.to_date, D.dept_no, dept_name
from employees E -- left
inner join salaries S -- right
on E.emp_no = S.emp_no -- 사번 기준 이너조인. 직원&급여 매칭
inner join dept_emp DE
on E.emp_no = DE.emp_no -- 사번기준 이너조인. 직원&부서 매칭
inner join departments D
on DE.dept_no = D.dept_no -- 부서번호 기준 실제 부서 이름 조인
limit 100;

-- 문제
-- WORLD DB진행
-- countryCode를 만족하는 Co.name, C.name, region, population, Capital, Language 출력
use world;
select * from city; -- C
select * from country; -- Co
select * from countrylanguage; -- CL

select Co.name as 'country name', C.name as 'city name', region, C.population, Capital, Language
from city C

inner join country Co
on C.countryCode = Co.Code

inner join countrylanguage CL
on C.countryCode = CL.countryCode
;

-- 풀이 2 : distinct로 중복 행을 제거하고 나라 이름순 정렬
select distinct C.name as 'country name', CT.name as 'city name', region, CT.population, Capital, Language
from country C

inner join city CT
on C.Code = CT.countryCode

inner join countrylanguage CL
on C.Code = CL.countryCode
order by C.name asc
;
