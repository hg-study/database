-- =======================================
-- 내장 함수
-- 문자열(concat, substring, replace, lpad 등), 진수 변환, 날짜와 시간 함수
-- =======================================
-- ---------------------
-- 내장함수 (https://velog.io/@wngud4950/MySQL-%EB%82%B4%EC%9E%A5%ED%95%A8%EC%88%98-%EC%A0%95%EB%A6%AC)
-- ---------------------
-- Concat(), Concat_ws()
-- Concat: 여러 문자열이나 숫자를 하나로 합친다.
-- Concat_ws: 첫 번째 인자를 구분자로 사용하여 합친다.

select concat('hello','-','world',5,6); -- 전부 합치기
select concat_ws("-",'hello','world',5,6); -- 첫번째 인자를 구분자로 사용해 합치기

-- SubString(): 문자열의 특정 위치부터 잘라낸다.
-- MySQL은 인덱스가 1부터 시작
select substring("HELLO WORLD",6);	-- 6 index 부터 마지막 문자까지
select substring("HELLO WORLD",1,6);	-- 1 index부터 6개문자

-- substring_index(): 구분자를 기준으로 n번째까지 잘라낸다.
select substring_index("HELLO MY NAME IS JUNG"," ",3); -- 3번째 공백 앞부분까지 출력
select userId,substring_index(mDate,'-',2) as '가입연월' from usertbl; -- -가 두번째 나오는 곳까지 자르기
select mdate from usertbl;

-- 문자열 길이: LENGTH()
select length("Hello World");                         -- 11
select length(lastname) from classicmodels.employees;

-- 소문자/대문자 변환
select lower("HELLO WORLD");
select upper("hello world");

-- 공백 제거: TRIM()
select trim("  HELLO WORLD  ");                       -- "HELLO WORLD"

-- 문자열 치환: REPLACE()
select replace("HELLO WORLD", "WORLD", "MYSQL");      -- HELLO MYSQL

-- 문자열 포함 위치: INSTR(), LOCATE()
select instr("HELLO MYSQL", "SQL");                   -- 8
select locate("MYSQL", "HELLO MYSQL");                -- 7

-- 문자열 채우기: LPAD(), RPAD()
select lpad("HELLO", 10, '*');                        -- *****HELLO
select rpad("HELLO", 10, '#');                        -- HELLO#####

-- 문자열 왼쪽/오른쪽 추출: LEFT(), RIGHT()
select left("HELLO MYSQL", 5);                        -- HELLO
select right("HELLO MYSQL", 5);                       -- MYSQL

-- 문자열 중간 추출: MID()
select mid("HELLO MYSQL", 7, 5);                      -- MYSQL

-- 숫자 진수 변환: BIN(), OCT(), HEX()
select bin(1), bin(5), bin(10), bin(15);              -- 이진수
select oct(10), hex(255);                             -- 8진수, 16진수


-- REVERSE(): 문자열 뒤집기
select reverse('HELLO');                               -- OLLEH
-- SPACE(): 공백 n개
select concat('A', space(3), 'B');                     -- A   B
-- REPEAT(): 문자열 n번 반복
select repeat('AB', 3);                                -- ABABAB
-- FORMAT(): 천 단위 쉼표와 소수 자릿수
select format(1234567.891, 2);                         -- 1,234,567.89

-- ---------------------
-- 날짜 관련 내장 함수
-- ---------------------
use shopdb;
select Year(mDate) from usertbl;
select month(mDate) from usertbl;
select day(mDate) from usertbl;

-- 현재 날짜/시간
select now();             -- 현재 날짜시간
select date(now());       -- 날짜만
select curdate();         -- 날짜만
select time(now());       -- 시간만
select curtime();         -- 시간만

-- 날짜/시간 포맷 조합 출력
-- YYYY#MM#DD hh|mm|ss

select replace(curdate(),'-','#') ;
select replace(curtime(),':','|') ;
select concat(replace(curdate(),'-','#')," ",replace(curtime(),':','|'));
