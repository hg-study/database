# Exception

### 예외 처리

> 프로시저 안에서 오류가 발생해도 멈추지 않고 처리하도록 핸들러를 선언한다. `declare 종류 handler for 에러코드 처리내용;` 형식이다.

<br>

| **구분** | **설명** |
| --- | --- |
| `continue handler` | 오류를 처리한 뒤 다음 문장부터 계속 실행 |
| `exit handler` | 오류를 처리한 뒤 프로시저를 종료 |
| `for 1146` | 특정 에러코드. 1146은 테이블이 없음 |
| `for SQLEXCEPTION` | 모든 SQL 예외 |
| `show errors;` | 발생한 오류 확인 |

<br>

| **에러코드** | **의미** |
| --- | --- |
| 1146 | 존재하지 않는 테이블 |
| 1136 | insert의 값 개수가 컬럼 개수와 다름 |
| 1062 | PK, unique 값 중복 |
| 1265 | 값이 잘림(자료형이 맞지 않음) |

<br>

```sql
create procedure Exception_Test02()
begin
    declare continue handler for 1146 select '해당 테이블이 없어요..' as 'Error_msg';
    declare continue handler for 1136 select 'Insert시 value의 column이 다릅니다..' as 'Error_msg';
    select * from notable;              -- 1146 발생, 처리 후 계속 실행
    insert into usertbl values(1);      -- 1136 발생, 처리 후 계속 실행
    select 'Result' as '끝';
end
```

---

### 오류 로그 기록

> `get diagnostics condition 1`로 발생한 오류의 코드(`MYSQL_ERRNO`)와 메시지(`MESSAGE_TEXT`)를 변수에 받아 로그 테이블에 저장한다.

<br>

```sql
create table tbl_std_errlog(error_date datetime, error_code int, error_msg text);
declare continue handler for 1062
begin
    get diagnostics condition 1
        error_code = MYSQL_ERRNO,
        error_message = MESSAGE_TEXT;
    insert into tbl_std_errlog values(now(), error_code, error_message);
end;
```

<br>

- 예제 코드: [EXCEPTION](../14_Exception/01Exception.sql)

<br>

---

<br>

**Exception 요약**

<aside>

> EXCEPTION: declare continue 또는 exit handler for 에러코드 또는 SQLEXCEPTION <br>
show errors, get diagnostics로 오류 정보 확인 <br>
오류 로그 테이블에 기록

</aside>

<br>

### Link
[MySQL DECLARE HANDLER](https://dev.mysql.com/doc/refman/8.0/en/declare-handler.html)
