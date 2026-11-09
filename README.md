## Database

### 목차

- [MySQL](#mysql)
    - [설치와 접속](#설치와-접속)
    - [DDL, 테이블 구조](#ddl-테이블-구조)
    - [DML, 데이터 조작](#dml-데이터-조작)
    - [계정과 권한](#계정과-권한)
    - [SELECT, GROUP BY](#select-group-by)
    - [제약조건](#제약조건)
    - [정규화](#정규화)
    - [변수, 형변환, 내장 함수](#변수-형변환-내장-함수)
    - [INDEX](#index)
    - [JOIN](#join)
    - [VIEW](#view)
    - [JSON](#json)
    - [PIVOT](#pivot)
    - [Procedure](#procedure)
    - [Transaction](#transaction)
    - [Exception](#exception)
    - [Trigger](#trigger)
    - [백업과 복원](#백업과-복원)
    - [ERD 모델링](#erd-모델링)

<br>

---

### MySQL
> MySQL 이론 & 실습

#### 설치와 접속
- [Install 이론](./MySQL/Theory/01Install.md)
    - [employees 샘플 DB](./MySQL/18_SampleDb/Employees/employees.sql)

#### DDL, 테이블 구조
- [Ddl 이론](./MySQL/Theory/02Ddl.md)
    - [제약조건과 테이블 구조 변경](./MySQL/03_Constraint/01Constraint.sql)

#### DML, 데이터 조작
- [Dml 이론](./MySQL/Theory/03Dml.md)
    - [INSERT, UPDATE, DELETE](./MySQL/02_Dml/01InsertUpdateDelete.sql)

#### 계정과 권한
- [User 이론](./MySQL/Theory/04User.md)

#### SELECT, GROUP BY
- [Select 이론](./MySQL/Theory/05Select.md)
    - [SELECT](./MySQL/01_Select/01Select.sql)
    - [GROUP BY](./MySQL/01_Select/02Group.sql)

#### 제약조건
- [Constraint 이론](./MySQL/Theory/06Constraint.md)
    - [제약조건](./MySQL/03_Constraint/01Constraint.sql)

#### 정규화
- [Normalization 이론](./MySQL/Theory/07Normalization.md)

#### 변수, 형변환, 내장 함수
- [Variable Function 이론](./MySQL/Theory/08VariableFunction.md)
    - [변수와 형변환](./MySQL/04_Variable/01VariableCast.sql)
    - [내장 함수](./MySQL/05_Function/01BuiltIn.sql)
    - [파일 업로드와 다운로드](./MySQL/06_File/01UploadDownload.sql)

#### INDEX
- [Index 이론](./MySQL/Theory/09Index.md)
    - [INDEX](./MySQL/07_Index/01Index.sql)

#### JOIN
- [Join 이론](./MySQL/Theory/10Join.md)
    - [JOIN](./MySQL/08_Join/01Join.sql)

#### VIEW
- [View 이론](./MySQL/Theory/11View.md)
    - [VIEW](./MySQL/09_View/01View.sql)

#### JSON
- [Json 이론](./MySQL/Theory/12Json.md)
    - [JSON](./MySQL/10_Json/01Json.sql)

#### PIVOT
- [Pivot 이론](./MySQL/Theory/13Pivot.md)
    - [PIVOT](./MySQL/11_Pivot/01Pivot.sql)

#### Procedure
- [Procedure 이론](./MySQL/Theory/14Procedure.md)
    - [Procedure](./MySQL/12_Procedure/01Procedure.sql)

#### Transaction
- [Transaction 이론](./MySQL/Theory/15Transaction.md)
    - [Transaction](./MySQL/13_Transaction/01Transaction.sql)

#### Exception
- [Exception 이론](./MySQL/Theory/16Exception.md)
    - [EXCEPTION](./MySQL/14_Exception/01Exception.sql)

#### Trigger
- [Trigger 이론](./MySQL/Theory/17Trigger.md)
    - [TRIGGER](./MySQL/15_Trigger/01Trigger.sql)

#### 백업과 복원
- [Backup 이론](./MySQL/Theory/18Backup.md)
    - [전체 DB 백업](./MySQL/17_Backup/AllBackup.sql)
    - [world DB 백업](./MySQL/17_Backup/WorldBackup.sql)
    - [world city 테이블 백업](./MySQL/17_Backup/WorldCityBackup.sql)

#### ERD 모델링
- [Modeling 이론](./MySQL/Theory/19Modeling.md)
    - [Book DB 모델](./MySQL/16_Model/BookDb.mwb)
    - [지문 DB 모델](./MySQL/16_Model/FingerprintDb.mwb)
    - [쇼핑 DB 모델](./MySQL/16_Model/Shopping.mwb)
    - [매장 DB 모델](./MySQL/16_Model/StoreDb.mwb)
    - [웨딩 DB 모델](./MySQL/16_Model/WeddingDb.mwb)
