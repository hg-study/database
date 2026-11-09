-- =======================================
-- 변수와 형변환
-- @변수, prepare와 execute, cast 강제 형변환, 자동 형변환 규칙
-- =======================================
-- ------------------
-- 01 변수
-- ------------------
-- 변수: 값을 저장해 두고 재사용하는 이름. MySQL에서는 @이름으로 쓰고 set으로 값을 저장한다

use shopdb;
set @var1 = 5;
set @var2 = 4.56;
set @var3 = "가수이름=>";

select @var1;
select @var2;
select @var3;
select @var1+@var2;

select @var3 as 'TITLE',name,addr from usertbl; 

-- LIMIT 에서 변수 사용
set @rowcnt = 5;

prepare sqlQuery01  -- prepare: 쿼리를 미리 저장해 두고 execute로 실행. ?는 값이 들어갈 자리
from 'select * from usertbl order by height limit ?';

execute sqlQuery01 using @rowcnt;

-- ------------------
-- 형변환
-- ------------------
-- 연산작업시(ex 대입연산,비교연산...) 자료형(Data Type)이 불일치시 자료형을 일치시키는 작업
-- 자동형변환(암시적형변환)	: 시스템에 의한 형변환(데이터 손실을 최소화 방향)
-- 강제형변환(명시적형변환)	: 프로그래머에 의한 형변환(프로그램 제작 목적에 따른->데이터 손실 우려가 비교적 큼)

select mdate from usertbl;
select cast('2024$01$01 12:12:12' as datetime); -- date타입으로 강제 형변환
select cast('2024@01@01' as date);

select 
num, 
concat(cast(price as char(10)),' X ',cast(amount as char(10)),"=") as '가격x수량',
price*amount as '결과값'

from buytbl;

select 100 + 200; -- 300
select '100' + 200; -- 300 java와 다르게 산술 연산자를 보고 숫자 형변환 해준다.
select '100' + '200'; -- 300
select '100a' + '200'+'300'; -- 600. '100a'는 읽을 수 있는 앞부분 100만 숫자로 바꾸고 나머지는 버린다0만 가져와 계산.

-- 숫자 비교연산의 결과(참 : 1, 거짓 : 0 )
select 1 < 2; -- 1 T
select 2 > '1a1bcd'; -- 1 T. 1뒤 다버리므로 2>1 은 T
select 0 = 'mega'; -- 1 T. mega는 숫자 없으므로 0처리되니 0=0 은 T
