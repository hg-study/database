# Transaction

### TRANSACTION

> 트랜잭션은 여러 SQL을 하나의 작업 단위로 묶는 것이다. 모두 성공하면 확정하고, 하나라도 실패하면 전부 취소해 데이터의 일관성을 지킨다. 예를 들어 계좌 이체는 출금과 입금이 함께 성공해야 한다.

<br>

| **명령** | **설명** |
| --- | --- |
| `start transaction;` | 트랜잭션 시작 |
| `commit;` | 변경 내용 확정 |
| `rollback;` | 시작 시점으로 되돌리기 |
| `savepoint 이름;` | 되돌아갈 지점 저장 |
| `rollback to 이름;` | 저장한 지점까지만 되돌리기 |
| `release savepoint 이름;` | 지점 삭제 |
| `select @@autocommit;` | 자동 확정 설정 확인. 기본 1(켜짐) |
| `set autocommit = 0;` | 자동 확정 끄기. 수동으로 commit, rollback 제어 |

<br>

```sql
start transaction;
    insert into tbl_test values(4,'aa',66,'W');
    savepoint s1;
    insert into tbl_test values(5,'ab',66,'W');
    savepoint s2;
    insert into tbl_test values(6,'ac',66,'W');
    rollback to s2;          -- 6번 입력만 취소
commit;                      -- 4, 5번 입력 확정
```

---

### 예외 발생 시 rollback

> 프로시저 안에서 예외 핸들러와 트랜잭션을 함께 사용하면 오류가 났을 때 자동으로 `rollback`한다.

<br>

```sql
create procedure TX_Test()
begin
    declare continue handler for SQLEXCEPTION
    begin
        show errors;
        rollback;
    end;
    start transaction;
        insert into tbl_test values(4,'aa',66,'W');
        insert into tbl_test values(5,'ab',66,'W');
        insert into tbl_test values(5,'ac',66,'W');   -- PK 중복으로 오류
    commit;
end
```

<br>

- 예제 코드: [Transaction](../13_Transaction/01Transaction.sql)

---

### 문제

```sql
-- 1 AUTOCOMMIT 상태 확인
select @@autocommit;
-- 2 AUTOCOMMIT 비활성화
set autocommit = 0;
-- 3 트랜잭션을 시작하고 (4,'aa',66,'W')를 삽입한 뒤 확정
start transaction; insert into tbl_test values (4, 'aa', 66, 'W'); commit;
-- 4 트랜잭션을 시작하고 모든 데이터를 삭제한 뒤 삭제 전 상태로 되돌리기
start transaction; delete from tbl_test; rollback;
-- 5 SAVEPOINT s1, s2를 지정하며 삽입하고 s2로 rollback한 뒤 commit
start transaction;
insert into tbl_test values(5, 'ab', 20, 'M');
savepoint s1;
insert into tbl_test values(6, 'ac', 30, 'W');
savepoint s2;
insert into tbl_test values(7, 'cd', 35, 'M');
rollback to s2;
commit;
```

<br>

---

<br>

**Transaction 요약**

<aside>

> TRANSACTION: 여러 SQL을 하나의 단위로 묶어 모두 성공하거나 모두 취소 <br>
start transaction, commit, rollback, savepoint <br>
autocommit을 끄면 수동 제어

</aside>

<br>

### Link
[MySQL Transaction](https://dev.mysql.com/doc/refman/8.0/en/commit.html)
