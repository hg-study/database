# Procedure

### Stored Procedure

> 저장 프로시저는 데이터베이스에 저장해 두고 호출해 실행하는 SQL의 묶음이다. 반복되는 작업을 재사용하고 로직을 모듈화한다. `call 이름();`으로 실행한다.

<br>

**프로시저와 함수의 공통점**

재사용성, 모듈화, 매개변수, 흐름 제어(`if`, `case`, `while`), 트랜잭션, 커서, 동적 SQL(`prepare`, `execute`).

<br>

**차이점**

| **구분** | **프로시저** | **함수(Function)** |
| --- | --- | --- |
| 반환값 | 필수 아님 | 항상 값을 반환 |
| 호출 위치 | `call`로 단독 호출 | `select`, `where` 안에서 호출 |
| 용도 | `insert`, `update`, `delete` 포함 여러 SQL 실행 | 주로 읽기 전용 계산 |

---

### 기본 문법

```sql
delimiter $$                      -- 명령 끝 기호를 $$로 변경. 내부의 ;를 명령 종료로 오해하지 않게 한다
create procedure pro2(in param int)     -- in : 외부에서 값을 받는 입력 파라미터
begin
    declare var1 int;             -- declare : 변수 선언
    set var1 = 100;               -- set : 값 대입
    if param = var1 then
        select param, '은 100 입니다';
    else
        select param, '은 100 이 아닙니다';
    end if;
end $$
delimiter ;                       -- 끝 기호를 다시 ;로 복구
call pro2(100);
```

<br>

| **구문** | **설명** |
| --- | --- |
| `show procedure status where db='shopdb';` | 프로시저 목록 |
| `drop procedure [if exists] 이름;` | 삭제 |
| `if 조건 then ... elseif 조건 then ... else ... end if;` | 조건 분기 |
| `case when 조건 then 값 ... else 값 end` | 조건에 따라 값 선택 |
| `while 조건 do ... end while;` | 반복. 반복 변수를 직접 증가시킨다 |

<br>

---

### 활용

| **예제** | **설명** |
| --- | --- |
| `pro3(amt)` | 인자보다 구매량이 많은 행 조회 |
| `pro5()` | 평균 구매액을 변수에 저장하고 행마다 평균 이상, 이하 구분 |
| `older(param)` | 출생년도를 입력받아 그보다 나이가 많은 행 조회 |
| 나이 계산 | `floor((to_days(curdate()) - to_days(date(concat(birthyear,'-01-01'))))/365)` |
| 반복문 | 1부터 N까지 합, N부터 M까지 합, 구구단 N단 |

<br>

<span style="color:brown">나이처럼 소수가 나오는 계산은 `ceil`(올림), `round`(반올림), `floor`(내림) 중 목적에 맞는 것을 쓴다.</span>

<br>

- 예제 코드: [Procedure](../12_Procedure/01Procedure.sql)

<br>

---

<br>

**Procedure 요약**

<aside>

> Procedure: 저장해 두고 call로 실행하는 SQL 묶음 <br>
delimiter $$로 끝 기호 변경, in 파라미터, declare와 set <br>
if, case, while 흐름 제어 <br>
함수와 달리 반환값이 필수가 아니다

</aside>

<br>

### Link
[MySQL Stored Routines](https://dev.mysql.com/doc/refman/8.0/en/stored-routines.html)
