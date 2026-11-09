# View

### VIEW

> 뷰는 `select` 결과를 저장해 둔 가상 테이블이다. 복잡한 쿼리를 재사용하거나, 사용자에게 일부 열만 보여줄 때(보안) 사용한다. 데이터를 따로 저장하지 않고 조회할 때마다 원본 테이블에서 가져온다.

<br>

| **명령** | **설명** |
| --- | --- |
| `create view 이름 as select ...;` | 뷰 생성 |
| `create or replace view 이름 as ...;` | 없으면 만들고, 있으면 덮어쓴다 |
| `show create view 이름;` | 뷰의 소스 확인 |
| `select * from information_schema.views where table_schema='shopdb';` | 뷰 목록(메타데이터) |
| `drop view 이름;` | 삭제 |

<br>

```sql
create or replace view view_02
as
select userid, name, addr, concat(mobile1,'-',mobile2) as 'phone'
from usertbl
where addr in ('서울','경기');
```

<br>

<span style="color:brown">여러 테이블을 조인한 뷰에는 `insert`를 할 수 없다. 단일 테이블 뷰는 원본의 제약조건을 만족하면 값을 넣을 수 있다.</span>

<br>

- 예제 코드: [VIEW](../09_View/01View.sql)

<br>

---

<br>

**View 요약**

<aside>

> VIEW: select 결과를 저장한 가상 테이블 <br>
create view, create or replace view, show create view <br>
조인 뷰는 insert 불가

</aside>

<br>

### Link
[MySQL VIEW](https://dev.mysql.com/doc/refman/8.0/en/create-view.html)
