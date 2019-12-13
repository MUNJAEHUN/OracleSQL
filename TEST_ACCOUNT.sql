다음은 설명을 보고 적절한 조치를 취할 수 있는 SQL문을 작성하시오 .
1. 테스트 전용 계정을 생성 한다. ( ID: TEST_ACCOUNT PW: TIGER )

creatE user TEST_ACCOUNT
IDENTIFIED BY TIGER;


2.  DB에 LOGIN 가능하게 권한을 부여 한다.

grant connect, resource to TEST_ACCOUNT;


3. 사원이름과 직업, 급여, 급여등급 을 출력하라  ?

SELECT SCOTT.EMP.ENAME,SCOTT.EMP.JOB,SCOTT.EMP.SAL,SCOTT.SALGRADE.GRADE 
FROM SCOTT.EMP ,SCOTT.SALGRADE ,SCOTT.DEPT 
WHERE SCOTT.EMP.DEPTNO=SCOTT.DEPT.DEPTNO AND SCOTT.EMP.SAL BETWEEN SCOTT.SALGRADE.LOSAL AND SCOTT.SALGRADE.HISAL;

SELECT EMP.ENAME,EMP.JOB,EMP.SAL,SALGRADE.GRADE 
FROM SCOTT.EMP ,SCOTT.SALGRADE ,SCOTT.DEPT 
WHERE EMP.DEPTNO=DEPT.DEPTNO AND EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;


4. 20 번 부서의 사원들과 같은 월급을 받는 사원들의 이름과 월급과 부서
번호를 출력하라 ?

SELECT ENAME,SAL,DEPTNO
FROM SCOTT.EMP
WHERE SAL IN( SELECT SAL  FROM SCOTT.EMP WHERE DEPTNO = 20);


5. 이름에  T  를 포함하고 있는 사원들과  동일한 부서에서 근무하고 있는 사원의
사원 번호와 이름을  출력하라 ?


SELECT ENAME,EMPNO
FROM SCOTT.EMP
WHERE DEPTNO    IN (SELECT DEPTNO
                FROM SCOTT.EMP
                WHERE ENAME LIKE '%T%');


6. BLAKE 이란 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하라 ?
( SUBQUERY와 JOIN 두가지 방법 모두 기술)


-------------------------------------------------------------------------------
SELECT E1.ENAME, E1.HIREDATE 
FROM SCOTT.EMP E1 ,SCOTT.EMP E2 
WHERE  E1.HIREDATE>E2.HIREDATE
AND E2.ENAME='BLAKE';

SELECT ENAME, HIREDATE
FROM SCOTT.EMP
WHERE HIREDATE > ( SELECT HIREDATE
                    FROM SCOTT.EMP
                    WHERE ENAME = 'BLAKE');



==========================================================================
그림1)
SQL> desc cust
Name                                      Null?    Type
----------------------------------------- --------- -------------
CUST_ID                                   NOT NULL NUMBER(6)
CUST_GENDER                                        NUMBER
CUST_NAME                                          VARCHAR2(10)


그림2)
SQL> select * from cust;
CUST_ID CUST_GENDER CUST_NAME
-------     -----------     --------
         1           1 홍길동
         2           0 유관순
         3           1
         4           0 신사임당
         5           1 갑돌이


그림3)
SQL> /

CONSTRAINT_NAME                C TABLE_NAME
---------------------           -- -----------
CUST_ID_PK                     P CUST


7.      그림1처럼 TABLE을 생성 하는 SQL문을 작성하시오.

CREATE TABLE CUST(
CUST_ID NUMBER(6) NOT NULL,
CUST_GENDER NUMBER,
CUST_NAME VARCHAR2(12)
);
                    
DESC CUST

8.      그림2처럼 데이터를 추가 하는 SQL문을 작성하시오.

INSERT INTO CUST
VALUES(1,1,'홍길동');

INSERT INTO CUST
VALUES(2,0,'유관순');

INSERT INTO CUST
VALUES(3,1,' ');

INSERT INTO CUST
VALUES(4,0,'신사임당');

INSERT INTO CUST
VALUES(5,1,'갑돌이');

SELECT * FROM CUST
ORDER BY CUST_ID ASC;

9.      CUST 테이블에 GRADE 컬럼을 추가 하는 SQL문을 작성하시오
(단 GRADE 는 숫자2자리)

ALTER TABLE CUST
ADD GRADE NUMBER(2);

10.      GRADE 컬럼에 TYPE을 숫자 4자리로 변경 시키는 SQL문을 작성하시오

ALTER TABLE CUST
MODIFY GRADE NUMBER(4);


11.      CUST_ID 컬럼에 PRIMARY KEY 제약을 추가시키시오 (단 제약명은 CUST_ID_PK )

ALTER TABLE CUST
ADD CONSTRAINT CUSI_ID_PK PRIMARY KEY(CUST_ID);

12.      CUST 테이블을 복사하여 CUSTOMER 테이블을 생성

CREATE TABLE CUSTOMER
AS
SELECT * FROM CUST;

13.      그림3 처럼 정보를 확인할수 있는 있는 SQL문을 작성하시오.

SELECT CONSTRAINT_NAME,TABLE_NAME
FROM USER_CONSTRAINTS ;

14.      SCOTT  USER가 이 테이블을 SELECT , INSERT 할 수 있는 권한을 부여하시오.


GRANT SELECT,INSERT ON TEST_ACCOUNT.CUST TO SCOTT;

