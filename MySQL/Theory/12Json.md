# Json

### JSON

> JSON은 데이터를 주고받기 위한 텍스트 형식이다. `{}`는 키와 값으로 이뤄진 객체, `[]`는 데이터 목록(배열)이다. MySQL은 `json` 자료형과 JSON 함수를 지원한다. 경로는 `$`로 시작한다(`$.userinfo[2].age`).

<br>

| **함수** | **설명** |
| --- | --- |
| `json_object(키, 값, ...)` | JSON 객체 생성 |
| `json_valid(값)` | 올바른 JSON이면 1, 아니면 0 |
| `json_search(json, 'one' 또는 'all', 문자열)` | 문자열이 있는 경로 검색. `one`은 첫 번째만 |
| `json_extract(json, 경로)` | 경로의 값 추출. `$.userinfo[*].name`은 모든 name |
| `json_insert(json, 경로, 값)` | 값 추가(이미 있으면 유지) |
| `json_replace(json, 경로, 값)` | 기존 경로의 값 변경 |
| `json_remove(json, 경로)` | 경로의 값 삭제 |

<br>

```sql
create table tbl_json(id int primary key, json_data json not null);
insert into tbl_json values(1, json_object('name','홍길동','height',182));
select json_extract(json_data, '$.name') from tbl_json;
```

<br>

`json_*` 함수는 변수뿐 아니라 테이블의 `json` 컬럼에도 적용할 수 있다. 공공데이터(중구 맛집 179건)를 JSON 배열로 변수에 저장해 `json_search`로 검색하는 연습도 한다.

<br>

- 예제 코드: [JSON](../10_Json/01Json.sql)

<br>

---

<br>

**Json 요약**

<aside>

> JSON: {} 객체, [] 배열, 경로는 $로 시작 <br>
json_object, json_valid, json_search, json_extract <br>
json_insert, json_replace, json_remove, json 컬럼

</aside>

<br>

### Link
[MySQL JSON 함수](https://dev.mysql.com/doc/refman/8.0/en/json-function-reference.html)
