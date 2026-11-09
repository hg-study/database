-- =======================================
-- PIVOT
-- sum(if())와 count(case when)으로 행을 열로 회전, with rollup으로 합계 행 추가
-- =======================================
use shopdb;
select * from buytbl;
-- ----------------------
-- Pivot 다루기 
-- ----------------------
-- 행(Row) 데이터를 열(Column) 데이터로 회전시키는 것

-- 사용자별 합계를 구하고, 마지막 행에 전체 총 합계를 구한다.
select userid,
sum(if(prodname='모니터',amount,0)) as '모니터', -- prodName이 '모니터'면 amount를 더하고, 아니면 0을 더함.
sum(if(prodname='운동화',amount,0)) as '운동화',
sum(if(prodname='메모리',amount,0)) as '메모리',
sum(if(prodname='청바지',amount,0)) as '청바지',
sum(if(prodname='책',amount,0)) as '책'
from buytbl 
group by userid -- userid로 그룹화
-- with rollup: group by로 묶인 데이터의 부분합계와 총 합계를 계산해준다.
with rollup; 


select * from buytbl;
select userid,
-- 카테고리별 구매 수량 합산
sum(if(groupname='전자',amount,0)) as '전자',
sum(if(groupname='의류',amount,0)) as '의류',
sum(if(groupname='서적',amount,0)) as '서적',
-- groupname이 NULL인 경우(is null)를 '기타' 열로 합산
sum(if(groupname is null,amount,0)) as '기타',
sum(amount) as '유저별구매량' -- 가로 방향 총합
from buytbl group by userid with rollup;

create or replace view view_pivot_buytbl
as
select userid,
sum(if(groupname='전자',amount,0)) as '전자',
sum(if(groupname='의류',amount,0)) as '의류',
sum(if(groupname='서적',amount,0)) as '서적',
sum(if(groupname is null,amount,0)) as '기타',
sum(amount) as '유저별구매량'
from buytbl group by userid with rollup;

select * from view_pivot_buytbl;

select 
sum(if(addr='서울',1,0)) as '서울',
sum(if(addr='경기',1,0)) as '경기',
sum(if(addr='경남',1,0)) as '경남',
sum(if(addr='경북',1,0)) as '경북'
from usertbl  ;

select 
	count(case when addr='서울' then 1 end) as '서울',
	count(case when addr='경기' then 1 end) as '경기',
    count(case when addr='경남' then 1 end) as '경남',
    count(case when addr='경북' then 1 end) as '경북'
from usertbl;

select * from usertbl;
