# Select

- [SELECT](#select)
- [WHERE 조건절](#where-조건절)
- [서브쿼리](#서브쿼리)
- [정렬, 중복 제거, 개수 제한](#정렬-중복-제거-개수-제한)
- [테이블 복사](#테이블-복사)
- [GROUP BY](#group-by)
- [Link](#link)

<br>

---

### SELECT

> `select`는 테이블에서 원하는 열과 행을 조회한다. 열은 `select` 뒤에, 행은 `where` 조건절로 고른다. `as`로 열 이름에 별칭을 붙이고 `concat()`으로 열을 합쳐 출력할 수 있다.

<br>

```sql
select * from usertbl;                                              -- 모든 열
select userid as '아이디', birthyear as '생년월일' from usertbl;     -- 열 지정과 별칭
select concat(mobile1,'-',mobile2) as '연락처' from usertbl;         -- 열 합치기
```

---

### WHERE 조건절

| **구분** | **연산자** | **설명** |
| --- | --- | --- |
| 비교 | `=`, `>`, `<`, `>=`, `<=`, `!=`, `<>` | 값 비교 |
| 논리 | `and`, `or` | and는 둘 다 참, or는 하나라도 참 |
| 범위 | `between A and B` | A 이상 B 이하 |
| 포함 | `in (값, ...)` | 목록에 포함된 값 |
| 패턴 | `like` | `%`는 길이 제한 없는 모든 문자, `_`는 글자 수만큼의 문자 (`like '김__'`) |
| null | `is null`, `is not null` | 비어 있는지 확인. `= null`은 사용할 수 없다 |

<br>

---

### 서브쿼리

> 쿼리 안에 쓰는 또 다른 쿼리다. 괄호로 감싸 `where` 조건의 값으로 사용한다. 결과가 여러 행이면 `all`, `any`와 함께 비교한다.

<br>

| **키워드** | **설명** |
| --- | --- |
| `> (서브쿼리)` | 서브쿼리 결과(한 값)보다 큰 행 |
| `>= all (서브쿼리)` | 모든 결과를 만족(and). 가장 큰 값 이상 |
| `>= any (서브쿼리)` | 하나라도 만족(or). 가장 작은 값 이상 |

<br>

```sql
-- 김경호보다 키가 큰 행
select * from usertbl where height > (select height from usertbl where name='김경호');
```

---

### 정렬, 중복 제거, 개수 제한

| **구문** | **설명** |
| --- | --- |
| `order by 열 asc, desc` | 정렬. `asc` 오름차순(기본), `desc` 내림차순. 열을 쉼표로 이어 기준을 여러 개 지정 |
| `distinct` | 중복 값을 제거하고 고유 값만 출력 |
| `limit n` | 상위 n개 행만 출력 |
| `limit 시작, n` | 시작 위치(0부터)부터 n개 출력. 게시판 페이징, 상위 n개 추출에 사용 |

---

### 테이블 복사

| **방식** | **문법** | **복사되는 것** |
| --- | --- | --- |
| 구조와 값 | `create table 새테이블(select * from 원본);` | 구조, 데이터. PK, FK, Index는 복사되지 않는다 |
| 구조만 | `create table 새테이블 like 원본;` | 구조, PK, Index. 데이터는 복사되지 않는다 |
| 데이터만 | `insert into 새테이블 select * from 원본 where 조건;` | 조건에 맞는 데이터 |

<br>

- 예제 코드: [SELECT](../01_Select/01Select.sql)

---

### GROUP BY

> 같은 값을 가진 행을 하나로 묶어 집계 함수로 계산한다. `group by`로 묶은 결과의 조건은 `where`가 아니라 `having`으로 지정한다.

<br>

| **집계 함수** | **설명** |
| --- | --- |
| `count()` | 행의 개수 |
| `sum()` | 합계 |
| `avg()` | 평균. `truncate(값, 자릿수)`로 소수 자릿수를 버린다 |
| `max()`, `min()` | 최대, 최소 |

<br>

```sql
select userid, sum(amount) as '구매총량'
from buytbl
group by userid
having sum(amount) >= 5;       -- 그룹 결과에 대한 조건은 having
```

<br>

| **절** | **실행 시점** |
| --- | --- |
| `where` | 그룹으로 묶기 전에 행을 거른다 |
| `having` | 그룹으로 묶고 집계한 뒤 결과를 거른다 |

<br>

- 예제 코드: [GROUP BY](../01_Select/02Group.sql)

<br>

---

<br>

**Select 요약**

<aside>

> SELECT 열 FROM 테이블 WHERE 조건 <br>
조건: 비교, and/or, between, in, like(%, _) <br>
서브쿼리와 all, any, order by, distinct, limit <br>
group by는 집계 함수와 함께 사용, 그룹 조건은 having

</aside>

<br>

### Link
[MySQL SELECT](https://dev.mysql.com/doc/refman/8.0/en/select.html)
