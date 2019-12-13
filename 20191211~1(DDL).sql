--DDL 
--
--데이터베이스 객체
--
--테이블 -> 데이터를 저장한다
--뷰 -> 가상의 테이블, 하나이상 테이블의 데이터 부분집합
--시퀀스 -> 숫자값을 생성한다
--인덱스 -> 질의(쿼리)성능을 향상시킬때 사용
--동의어 -> 객체에 다른 이름을 부여
--
--테이블 이름 지정규칙
--1.A_Z,a_z,0_9,_,&,#
--2.첫 글자는 영문자
--3.예약어 사용x
--4.의미있는 이름 사용

--테이블 생성
--:테이블 생성할시 유저(개발자)는 create table 권한이 필수, 객체를 생성할 저장영역이 필요
--:dba는 dcl문을 사용하여 유저에게 권한을 부여


--CREATE TABLE COPY_EMP2(
--EMPNO NUMBER(4),
--ENAME VARCHAR(20), -- VARCHAR : 최대 4000자 
--                   -- 비교 ) LONG : 2G 텍스트, LONG RAW:2G 이미지
--                   --> LOB(LARGE OBJECT),CLOB,BLOB,BFILE : 4G
--JOB CHAR(20),      -- 최대 2000자
--SAL NUMBER(7,2),
--HIREDATE DATE
--);

CREATE TABLE COPY_EMP2(
EMPNO NUMBER(4),
ENAME VARCHAR(20), --> VARCHAR2로 자동변환
JOB CHAR(20),
SAL NUMBER(7,2),
HIREDATE DATE
);

DESC COPY_EMP2

CREATE TABLE BIGDATA1(
D1 LONG,        -- 한테이블에는 하나의 LONG타입만 들어갈수있다는 에러 표시
D2 LONG RAW);

CREATE TABLE BIGDATA2(
D1 CLOB,  D2 BLOB, D3 BFILE
); -- 한개의 테이블에 4G이상의 데이터를 저장하는 컬럼타입들로 테이블 생성


--테이블 생성시 서브쿼리 사용가능
CREATE TABLE EMPS
AS
SELECT * FROM EMP;

SELECT * FROM EMPS;


--문제 COPY_EMP3 테이블을 생성
--EMP 테이블과 동일한 구조, ROW는 하나도 없는 구조 (데이터가 없음)
--위 코드를 응용한 구성
-------------- 스스로 풀이 ----------
CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP;

DELETE FROM COPY_EMP3;

---------------접근1 : 조건에 전부 맞지않는 결과를 통해 생성,-------

CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP
WHERE EMPNO=9999; -- 9999자리를 NULL로 대체하여 만약을 대비 


--INSERT 구문에서도 서브쿼리 사용가능
INSERT INTO COPY_EMP3
SELECT * FROM EMP;


--테이블 구조 변경
----1.ALTER TABLE 구문
--새 열 추가 
--기존 열의 정의를 수정 (넘버->캐릭터)
--새열 기본값정의, 열 삭제,열 이름바꾸기, 읽기 전용 상태로 테이블 변경(11G만)

--테이블에 컬럼 추가
ALTER TABLE EMPS
ADD HP VARCHAR(10);

--컬럼이름 변경
ALTER TABLE EMPS
RENAME COLUMN HP TO MP;

-- 컬럼 정의 수정
ALTER TABLE EMPS
MODIFY MP VARCHAR2(15);

-- 컬럼 삭제
ALTER TABLE EMPS
DROP COLUMN MP;

--읽기전용 테이블 : READ ONLY 구문으로 테이블을 읽기전용으로 설정 -> DML사용 X 데이터수정하지않는한 DDL문 실행 가능
ALTER TABLE EMPS READ ONLY;

INSERT INTO EMPS(EMPNO)
VALUES (9999); -- 에러 발생 읽기전용

--읽기 해제
ALTER TABLE EMPS READ WRITE; -- 읽기전용모드인 테이블을 삭제할수있다. DROP은 데이터 딕셔너리에서 실행되므로 테이블 내용에 엑세스 할 필요가 없기 떄문 

--테이블 삭제 
DROP TABLE EMPS;
DESC EMPS

--비교) DELETE : 테이블 튜블 제거, DROp 테이블 자체 삭제, TRUNCATE : DELETE와 달리 ROLLBACK 수행 불가
---> ROLLBACK는 트랜젝션 수행중이어야함 , WHERE절 사용 불가(부분삭제불가)


--테이블 복수 (백업)
-- > DROP 수행시 RECYCLEBIN에 이동 (휴지통 개념)
SHOW RECYCLEBIN

FLASHBACK TABLE EMPS
TO BEFORE DROP; -- 드랍 전으로 EMPS를 복원


--삭제
DROP TABLE EMPS;


--휴지통 삭제 : 바로삭제기능 DROP 구문 수행시 맨뒤에 PURGE 추가하여 사용도 가능 
PURGE RECYCLEBIN;

DESC EMPS;


--테이블 이름 변경 
RENAME COPY_EMP2
TO EMPS;

--테이블 주석 추가 
COMMENT ON TABLE EMPS
IS 'EMP는  EMPLOYEE 이다';

SELECT * FROM EMPS;
DESC EMPS;

 --주석은 DATA DICTIONARY에서 확인할수있다.
 
DESC USER_TAB_COMMENTS;
SELECT * FROM USER_TAB_COMMENTS;





----------------------------------------
--DDL 성질
--1, 동시성
--2, 동시공유
--3, 동시성 제어 - 트랜젝션 EX)은행 계좌이체
                COMMINT, ROLLBACK, SAVEPOINT
            
--            
--2, 무결성
--    : 무결성을 만족시키려면? DDL, DML 문을 쓸 때 테이블 조건을 만족할때만 실행할수 있도록 하면 된다.
--    제약 조건 : 1) PRIMARY KEY : 반드시 필수
--               2) NOT NULL
--               3) CHECK
--                4) UNIQUE : 유일값 
--                5) FOREIGN KEY 
                
--EX) EMP,DEPT 테이블
--EMPNO : 널값이 아니며 중복될수없다 - PRIMARY KEY필요
--ENAME : 널값아니지만 중복가능하다 - NOT NULL 선언 
--SAL :  0보다는 커야한다 ( 신입사원같은 ) 중복 가능하다 - CHECK로 명시
--
--
--DEPTNO : 부서 테이블중 하나 , NULL 불가능, 중복불가능 - DEPTNO의 PRIMARY의 키 ,FOREIGN KEY
--DNAME : 중복 불가 , 고유 -UNIQUE
                
desc emp

select * from emp;


--제약 조건 정의
--1) 컬럼레벨 정의 방식 : 
--컬럼명 datatype [CONSTRAINT 제약이름]
--제약명을 생략하면 SYS_C숫자 형으로 임의 부여

CREATE TABLE DEPT1(
DEPTNO NUMBER(2)PRIMARY KEY,
DNAME VARCHAR(20) UNIQUE,
LOC VARCHAR(20)
);

--2) 테이블 레벨 정의방식 
--컬럼명 DATATYPE ,
--컬럼명 DATATYPE ,
--CONSTRAINT 제약명 제약종류(컬럼명),
--CONSTRAINT 제약명 제약종류(컬럼명). . .

CREATE TABLE EMP1(
EMPNO NUMBER(4) CONSTRAINT EMP1_EMPNO_PK PRIMARY KEY,
ENAME VARCHAR2(20) NOT NULL,
SAL NUMBER(7,2),
DEPTNO NUMBER(2),
CONSTRAINT "EMP1_SAL_CK" CHECK (SAL BETWEEN 500 AND 5000),
CONSTRAINT "ENP1_DEPTNO_FK" FOREIGN KEY (DEPTNO)
             REFERENCES DEPT1(DEPTNO)-- 테이블 삭제등에 오류원인부분, 레퍼런스는 테스트후에 작성
);

DESC EMP1


INSERT INTO DEPT1
VALUES (1,'회계','부산');

UPDATE DEPT1
SET LOC='서울'
WHERE DEPTNO=1 AND LOC='부산';

INSERT INTO DEPT1
VALUES (1,'영업','서울'); --> 위 구문과 동시에 실행시 에러발생 , --> DEPTNO가 기본키(널이 아니며 중복X)이므로 새로 넣으려는 값이 1이라 에러 

INSERT INTO DEPT1
VALUES (2,'영업','부산');

INSERT INTO EMP1
VALUES (1111,'HONG',3000,2); --> 부서번호가 2 가없을경우에는 실행 에러발생 

UPDATE EMP1
SET DEPTNO=1
WHERE ENAME='HONG';

INSERT INTO EMP1
VALUES (1111,'HONG',3000,1);


INSERT INTO EMP1
VALUES(2222,'KILDONG',6000,1);

SELECT * FROM EMP1;


-- DEPT1 테이블 LOC 컬럼에 UNIQUE 제약을 부여
ALTER TABLE DEPT1
ADD CONSTRAINT DEPT1_LOC_UQ UNIQUE(LOC);  --컬럼(제약조건) 추가

--제약조건 조회는 데이터 딕셔너리를 통해 조회 . DATA DICTIONARY

DESC USER_CONSTRAINTS

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP1','DEPT1');

--제약조건 삭제 
ALTER TABLE DEPT1
DROP CONSTRAINT DEPT1_LOC_UQ;

