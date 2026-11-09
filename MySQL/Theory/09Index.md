# Index

### INDEX

> 인덱스는 테이블의 검색 속도를 높이기 위한 자료구조다. 책의 색인처럼 정렬된 값과 위치를 따로 저장한다. `where` 조건절에 자주 쓰는 열에 지정한다. 인덱스가 없으면 모든 행을 읽고(Full Scan), 있으면 필요한 행만 찾는다.

<br>

**검색 알고리즘**

| **종류** | **설명** |
| --- | --- |
| B-Tree | 기본값. 대부분의 인덱스에 사용 |
| Hash | 해시 함수 이용. 정확히 일치하는 검색에 사용하며 포함 검색에는 성능이 떨어진다 |
| Full-text | 전체 텍스트 검색용 |
| Spatial | 위도, 경도 같은 공간 데이터용 |

<br>

**인덱스 종류**

| **종류** | **설명** |
| --- | --- |
| 클러스터형 인덱스 | PK에 자동 적용. 데이터가 이 인덱스 순서로 실제 정렬된다. 테이블당 1개이며 보조 인덱스보다 빠르다 |
| 보조(Secondary) 인덱스 | PK 이외의 `unique` 제약조건이나 직접 만든 인덱스. 여러 개 가능 |

<br>

<span style="color:brown">PK를 지정한 테이블은 입력 순서가 아니라 PK 오름차순으로 정렬된다. 5를 먼저 넣고 3을 나중에 넣어도 3이 먼저 출력된다.</span>

---

### 인덱스 생성과 삭제

```sql
create table tbl_c(
    col1 int primary key,                       -- 클러스터형 인덱스
    col2 int,
    col3 int,
    unique index col2_index(col2)               -- 보조 인덱스 (이름 직접 지정)
);
create table tbl_d(
    col1 int primary key, col2 int, col3 int,
    unique index col2_3_index(col2, col3)       -- 결합 인덱스. 두 열의 조합이 중복되면 안 된다
);
create index col2_idx on tbl_e(col2);           -- 테이블 생성 후 추가(중복 허용)
show index from tbl_e;                          -- 인덱스 확인
alter table tbl_b drop primary key;             -- PK 삭제
alter table tbl_b drop constraint col2;         -- unique 삭제
alter table employees.salaries drop index to_date_idx;
```

<br>

외래키를 설정하면 참조 무결성을 위해 인덱스가 자동으로 생성된다.

---

### 성능 확인

> 약 280만 행의 `employees.salaries`에서 `to_date` 열로 조회해 인덱스 유무에 따른 속도를 비교한다. 인덱스를 만든 뒤에는 같은 쿼리가 훨씬 빨리 실행된다.

<br>

```sql
select * from employees.salaries where to_date = '1986-01-01';      -- 인덱스 없음
create index to_date_idx on employees.salaries(to_date);            -- 인덱스 생성
select * from employees.salaries where to_date = '1986-12-01';      -- 인덱스 사용
```

<br>

- 예제 코드: [INDEX](../07_Index/01Index.sql)

<br>

---

<br>

**Index 요약**

<aside>

> INDEX: 검색 속도를 높이는 자료구조, 기본 B-Tree <br>
클러스터형은 PK에 자동 적용(테이블당 1개), 보조 인덱스는 여러 개 <br>
create index, show index, drop index

</aside>

<br>

### Link
[MySQL 인덱스](https://dev.mysql.com/doc/refman/8.0/en/mysql-indexes.html)
