# Variable Function

- [변수](#변수)
- [형변환](#형변환)
- [문자열 함수](#문자열-함수)
- [날짜 함수](#날짜-함수)
- [파일 업로드와 다운로드](#파일-업로드와-다운로드)
- [Link](#link)

<br>

---

### 변수

> 변수는 값을 저장해 두고 재사용하는 이름이다. MySQL에서는 `@이름`으로 쓰고 `set`으로 값을 저장한다. `prepare`로 쿼리를 미리 저장하면 `limit`처럼 변수를 직접 쓸 수 없는 곳에도 값을 넣을 수 있다.

<br>

```sql
set @var1 = 5;
select @var1 + 4.56;

set @rowcnt = 5;
prepare sqlQuery01 from 'select * from usertbl order by height limit ?';    -- ?는 값이 들어갈 자리
execute sqlQuery01 using @rowcnt;
```

---

### 형변환

> 연산할 때 자료형이 다르면 자료형을 맞추는 작업이다. 시스템이 알아서 바꾸는 자동(암시적) 형변환과 프로그래머가 `cast`로 지정하는 강제(명시적) 형변환이 있다.

<br>

| **구분** | **설명** | **예시** |
| --- | --- | --- |
| 자동 | 산술 연산자를 보고 문자열을 숫자로 바꾼다 | `select '100' + 200;` → 300 |
| 자동(일부 변환) | 숫자로 읽을 수 있는 앞부분만 쓰고 나머지는 버린다 | `select '100a' + '200' + '300';` → 600 |
| 비교 결과 | 참은 1, 거짓은 0 | `select 2 > '1a1bcd';` → 1 |
| 강제 | `cast(값 as 자료형)` | `cast('2024@01@01' as date)` |

<br>

- 예제 코드: [변수와 형변환](../04_Variable/01VariableCast.sql)

---

### 문자열 함수

| **함수** | **설명** | **예시** |
| --- | --- | --- |
| `concat(a, b, ...)` | 문자열 합치기 | `concat('hello','-','world')` |
| `concat_ws(구분자, a, b)` | 구분자로 합치기 | `concat_ws('-','hello','world')` |
| `substring(문자열, 시작, 개수)` | 잘라내기. 인덱스는 1부터 | `substring('HELLO WORLD',1,6)` |
| `substring_index(문자열, 구분자, n)` | n번째 구분자 앞까지 | `substring_index(mDate,'-',2)` |
| `length()` | 길이 | |
| `lower()`, `upper()` | 소문자, 대문자 | |
| `trim()` | 앞뒤 공백 제거 | |
| `replace(문자열, 찾을, 바꿀)` | 치환 | |
| `instr()`, `locate()` | 포함 위치 | |
| `lpad()`, `rpad()` | 왼쪽, 오른쪽을 채워 길이 맞추기 | `lpad('HELLO',10,'*')` |
| `left()`, `right()`, `mid()` | 왼쪽, 오른쪽, 중간 추출 | |
| `reverse()`, `space()`, `repeat()`, `format()` | 뒤집기, 공백, 반복, 천 단위 쉼표 | |
| `bin()`, `oct()`, `hex()` | 2진수, 8진수, 16진수 | |

---

### 날짜 함수

| **함수** | **설명** |
| --- | --- |
| `year()`, `month()`, `day()` | 연, 월, 일 |
| `now()` | 현재 날짜와 시간 |
| `curdate()`, `curtime()` | 현재 날짜, 현재 시간 |
| `date()`, `time()` | 날짜 부분, 시간 부분만 |
| `datediff(날짜1, 날짜2)` | 날짜 차이(일) |
| `to_days()` | 0000년부터 지난 일수 |

<br>

- 예제 코드: [내장 함수](../05_Function/01BuiltIn.sql)

---

### 파일 업로드와 다운로드

> `longblob` 컬럼에 파일을 저장한다. `load_file()`로 올리고 `into dumpfile`로 내려받는다. 서버 설정 `secure_file_priv`로 지정된 폴더의 파일만 사용할 수 있다.

<br>

```sql
create table tbl_file(title varchar(50), filedata longblob);
insert into tbl_file values('test2.jpg', load_file('c:\\sql\\test2.jpg'));                     -- 업로드
select filedata from tbl_file where title='test2.jpg' into dumpfile 'c:\\sql\\test2_copy.jpg'; -- 다운로드
```

<br>

- 예제 코드: [파일 업로드와 다운로드](../06_File/01UploadDownload.sql)

<br>

---

<br>

**Variable Function 요약**

<aside>

> 변수: @이름과 set, prepare와 execute <br>
형변환: 자동(산술 연산자 기준), 강제는 cast <br>
문자열, 날짜 내장 함수 <br>
파일: longblob, load_file, into dumpfile

</aside>

<br>

### Link
[MySQL 문자열 함수](https://dev.mysql.com/doc/refman/8.0/en/string-functions.html) <br>
[MySQL 날짜 함수](https://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html)
