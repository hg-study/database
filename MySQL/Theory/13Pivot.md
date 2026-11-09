# Pivot

### PIVOT

> 피벗은 행(Row) 데이터를 열(Column)로 회전시켜 집계표를 만드는 것이다. MySQL에는 pivot 명령이 없어 `sum(if())` 또는 `count(case when)`과 `group by`로 구현한다.

<br>

```sql
select userid,
sum(if(prodname='모니터',amount,0)) as '모니터',     -- prodname이 '모니터'면 amount를 더하고, 아니면 0
sum(if(prodname='운동화',amount,0)) as '운동화',
sum(amount) as '유저별구매량'
from buytbl
group by userid
with rollup;                                        -- 마지막 행에 전체 합계 추가
```

<br>

| **구문** | **설명** |
| --- | --- |
| `if(조건, 참, 거짓)` | 조건에 따라 값 선택 |
| `case when 조건 then 값 end` | 조건에 따라 값 선택. `count`와 함께 개수 집계에 사용 |
| `with rollup` | `group by` 결과에 부분 합계와 총합계를 추가 |
| `is null` | null 비교는 `= null`이 아니라 `is null` |

<br>

- 예제 코드: [PIVOT](../11_Pivot/01Pivot.sql)

<br>

---

<br>

**Pivot 요약**

<aside>

> PIVOT: 행을 열로 회전 <br>
sum(if())나 count(case when)과 group by로 구현 <br>
with rollup으로 합계 행 추가

</aside>

<br>

### Link
[MySQL GROUP BY 수정자](https://dev.mysql.com/doc/refman/8.0/en/group-by-modifiers.html)
