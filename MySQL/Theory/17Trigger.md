# Trigger

### TRIGGER

> 트리거는 테이블에 `insert`, `update`, `delete`가 발생하면 자동으로 실행되는 프로시저다. 변경 이력 저장처럼 사람이 호출하지 않아도 항상 실행되어야 하는 작업에 사용한다.

<br>

| **구분** | **설명** |
| --- | --- |
| `after` | 변경이 일어난 뒤 실행 |
| `before` | 변경이 일어나기 전에 실행 |
| `for each row` | 변경되는 행마다 실행 |
| `old` | 변경 전 행의 값(update, delete) |
| `new` | 변경 후 행의 값(insert, update) |

<br>

```sql
delimiter $$
create trigger trg_c_usertbl_update
after update
on c_usertbl
for each row
begin
    insert into c_usertbl_bak values(
        old.userid, old.name, old.birthyear, old.addr, old.mobile1, old.mobile2, old.height,
        old.mDate, '수정', now()
    );
end $$
delimiter ;
```

<br>

| **명령** | **설명** |
| --- | --- |
| `show triggers;` | 트리거 목록 |
| `show create trigger 이름;` | 트리거 소스 확인 |
| `drop trigger 이름;` | 삭제 |

<br>

수정, 삭제 시 변경 전 데이터를 백업 테이블(`c_usertbl_bak`)에 `'수정'`, `'삭제'` 구분과 시각과 함께 저장한다.

<br>

- 예제 코드: [TRIGGER](../15_Trigger/01Trigger.sql)

<br>

---

<br>

**Trigger 요약**

<aside>

> TRIGGER: 테이블 변경 시 자동 실행 <br>
after, before, for each row, old와 new <br>
변경 이력을 백업 테이블에 저장

</aside>

<br>

### Link
[MySQL TRIGGER](https://dev.mysql.com/doc/refman/8.0/en/create-trigger.html)
