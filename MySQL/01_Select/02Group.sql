-- =======================================
-- GROUP BY 그룹 집계
-- 집계 함수(sum, avg, min, max, count), group by, having
-- =======================================
use shopdb;

-- =========================================
-- 01 select group by
-- =========================================

-- UserId별 Amount 총합(집계함수 : sum))
select userid,sum(amount) as '구매총량' from buytbl group by userid;
-- userid별 amount*price 의 총합(sum)
select userid,sum(amount*price) as '구매총액' from buytbl group by userid;
-- avg 를 이용
select userid, truncate( avg(amount*price) , 2 ) as '구매평균액' from buytbl group by userid;
-- min(), max() 
select max(height) from usertbl;
select min(height) from usertbl;

-- 가장 큰 키를 가지는 user 정보 확인
select * from usertbl where
height = (select max(height) from usertbl);
-- 가장 작은 키를 가지는 user 정보 확인
select * from usertbl where
height = (select min(height) from usertbl);

-- 가장큰키와 가장 작은키의 유저정보를 한번에 출력
select * from usertbl where
height = (select max(height) from usertbl)
or
height = (select min(height) from usertbl);

-- =========================================
-- 문제
-- =========================================

-- 1 buytbl에서 userid 별로 구매량(amount)의 합을 출력하세요
select userid,sum(amount) from buytbl group by userid;

-- 2 usertbl에서 키의 평균값을 구하세요
select avg(height) from usertbl;
-- 3 buy테이블에서 최대구매량과 최소구매량을 userid와함께 출력하세요
select distinct userid, amount from buytbl
where 
amount =(select max(amount) from buytbl)
or 
amount = (select min(amount) from buytbl);

-- 4 buytbl의 groupname 의 개수를 출력하세요 (count())
select count(*) from buytbl;
select count(groupname) from buytbl;

-- 5 city 테이블에서  CountryCode 별로 Population의 총합을 구하세요(world DB에서진행)
use world;
select CountryCode,sum(Population) from city group by CountryCode;
-- 6 country 테이블에서 Continent 별로 LifeExpectancy의 평균을 구하세요(world DB에서진행)
select Continent,avg(LifeExpectancy) from country group by Continent;

-- =========================================
-- 02 select group by + having
-- =========================================

use shopdb;
select * from buytbl;

select userid, sum(amount) as '구매총량' -- userid기준 amount집계
from buytbl 
group by userid
having sum(amount) >= 5; -- 여기서 where절 사용 불가해 having 사용
-- having 구매총량 >= 5; -- 이렇게도 사용 가능


-- + GROUP BY (지역별 구매총량)
select addr, sum(amount) as '구매총량' -- 원하는 컬럼 지정
from usertbl U-- u라는 별칭을 가진 user테이블과
inner join buytbl B-- b라는 별칭을 가진 buy테이블의 innerjoin(교집합)
on U.userid = B.userid -- 고객 정보에 대한
group by U.addr -- addr로 묶어서
having 구매총량 >= 5 -- 5 이상인
order by 구매총량 desc; -- 내림차순 정렬

select * from buytbl;

 
