# Constraint

### 제약조건

> 테이블에 들어가는 데이터가 지켜야 할 규칙이다. 규칙에 맞지 않는 값은 입력되지 않아 데이터의 정확성을 지킨다.

<br>

| **제약조건** | **설명** |
| --- | --- |
| `primary key`(PK) | 행을 구분하는 기본키. 중복과 null 불가. 한 테이블에 하나이며 여러 열을 묶은 복합키도 가능 |
| `foreign key`(FK) | 다른 테이블의 PK를 참조하는 외래키. 존재하지 않는 값은 입력할 수 없다 |
| `unique` | 중복 불가(null은 허용) |
| `not null` | null 불가 |
| `check` | 조건식을 만족하는 값만 허용. `check(age>=10 and age<=50)` |
| `default` | 값을 입력하지 않았을 때 들어갈 기본값 |

<br>

---

### Primary Key

```sql
create table tbl_a(id varchar(45) primary key, name varchar(45) not null);          -- 컬럼에 지정
create table tbl_b(id varchar(45), name varchar(45), primary key(id));              -- 테이블 끝에 지정
create table tbl_c(id varchar(45), name varchar(45), primary key(id,name));         -- 복합키
alter table tbl_d add constraint PK_tbl_d primary key(id);                          -- 기존 테이블에 추가
alter table tbl_d drop primary key;                                                 -- 삭제
```

---

### Foreign Key

> `constraint 이름 foreign key(열) references 부모테이블(열)`로 지정한다. 부모의 값이 바뀌거나 삭제될 때 자식 처리 방식을 옵션으로 정한다.

<br>

| **옵션** | **설명** |
| --- | --- |
| `cascade` | 부모(PK)가 변경, 삭제되면 자식(FK)도 함께 변경, 삭제 |
| `no action` | 부모가 바뀌어도 자식은 그대로 |
| `restrict` | 부모, 자식의 변경을 차단 |
| `set null` | 부모가 바뀌면 자식 값을 null로 |
| `set default` | 부모가 바뀌면 자식 값을 기본값으로 |

<br>

```sql
alter table tbl_test3
add constraint FK_tbl_test3_tbl_c
foreign key(id) references tbl_c(id)
on update cascade
on delete cascade;
```

<br>

| **작업** | **설명** |
| --- | --- |
| FK 삭제 | `alter table 테이블 drop foreign key FK명;` 이후 자동 생성된 인덱스는 `drop index`로 삭제 |
| FK 이름 확인 | `show create table 테이블;` |
| 참조되는 테이블 삭제 | 자식 테이블을 먼저 삭제한다. 강제로 삭제하려면 `set foreign_key_checks = 0;`으로 검사를 끄고 삭제한 뒤 `1`로 되돌린다 |

---

### Unique, Check, Default

```sql
create table tbl_test05(id int primary key, email varchar(50) unique);                   -- 컬럼에 unique
alter table tbl_test07 add constraint Uk_tbl_test07_email unique(email);                 -- 추가
alter table tbl_test07 drop constraint Uk_tbl_test07_email;                              -- 삭제

create table tbl_test08(
    age int check(age>=10 and age<=50),
    addr varchar(5),
    constraint CK_ADDR check(addr in('서울','대구','인천'))
);

create table tbl_test09(name varchar(20) default '이름없음', age int default 20);
alter table tbl_test09 alter column name set default '홍길동';     -- 기본값 변경
alter table tbl_test09 alter column age drop default;              -- 기본값 삭제
```

<br>

- 예제 코드: [제약조건](../03_Constraint/01Constraint.sql)

<br>

---

<br>

**Constraint 요약**

<aside>

> PK: 중복과 null 불가 <br>
FK: 부모 PK를 참조, cascade, restrict 등 옵션 <br>
unique, not null, check, default <br>
alter table로 추가하고 drop으로 삭제

</aside>

<br>

### Link
[MySQL 제약조건](https://dev.mysql.com/doc/refman/8.0/en/create-table-check-constraints.html)
