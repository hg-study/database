# Join

### JOIN

> 두 개 이상의 테이블을 연결해 하나의 결과로 출력한다. 보통 한 테이블의 PK와 다른 테이블의 FK를 `on`으로 연결한다. 테이블에 별칭(`usertbl U`)을 붙이면 열 이름 앞에 `U.userid`처럼 짧게 쓸 수 있다.

<br>

| **종류** | **설명** |
| --- | --- |
| `inner join` | 교집합. `on` 조건에 맞는 행만 |
| `left outer join` | 왼쪽 테이블 전체 + 조건에 맞는 오른쪽 행 |
| `right outer join` | 오른쪽 테이블 전체 + 조건에 맞는 왼쪽 행 |
| `full outer join` | 합집합. MySQL은 지원하지 않아 left와 right 결과를 `union`으로 합쳐 구현 |
| `cross join` | 모든 행의 조합(곱집합). 조건 없음 |
| `self join` | 자기 자신 테이블과 조인 |

<br>

```sql
select U.userid, name, addr, prodname, amount
from usertbl U
inner join buytbl B
on U.userid = B.userid
where amount >= 5;

-- full outer join
select * from usertbl U left outer join buytbl B on U.userid = B.userid
union
select * from usertbl U right outer join buytbl B on U.userid = B.userid;
```

<br>

**3개 이상 테이블 조인** `inner join`을 이어서 쓴다. 직원, 급여, 부서 테이블을 사번과 부서번호로 연결한다.

```sql
select E.emp_no, concat(first_name,' ', last_name) as name, salary, D.dept_no, dept_name
from employees E
inner join salaries S on E.emp_no = S.emp_no
inner join dept_emp DE on E.emp_no = DE.emp_no
inner join departments D on DE.dept_no = D.dept_no
limit 100;
```

<br>

- 예제 코드: [JOIN](../08_Join/01Join.sql)

<br>

---

<br>

**Join 요약**

<aside>

> JOIN: 테이블을 on 조건으로 연결 <br>
inner는 교집합, left와 right outer는 한쪽 전체 포함 <br>
full outer는 union으로 구현, cross는 곱집합

</aside>

<br>

### Link
[MySQL JOIN](https://dev.mysql.com/doc/refman/8.0/en/join.html) <br>
[SQL JOIN 정리](https://hongong.hanbit.co.kr/sql-%EA%B8%B0%EB%B3%B8-%EB%AC%B8%EB%B2%95-joininner-outer-cross-self-join/)
