<  조인 실습 문제 >

1.   사원들의 이름, 부서 번호, 부서 이름을 출력하시오

SELECT E.ENAME,D.DEPTNO,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

SELECT E.ENAME,D.DEPTNO,D.DNAME
FROM EMP E
    INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

2.   30번 부서의 사원들의 이름, 직업, 부서위치를 출력하시오

--92
SELECT E.DEPTNO, E.ENAME, E.JOB, D.LOC
FROM EMP E, DEPT D
WHERE D.DEPTNO = 30 AND E.DEPTNO=D.DEPTNO;

--ANSI
SELECT E.DEPTNO, E.ENAME, E.JOB, D.LOC
FROM EMP E INNER JOIN DEPT D
ON D.DEPTNO = 30 AND E.DEPTNO=D.DEPTNO;


3.  수당을 받는 사원의 이름 , 부서이름 및 부서위치를  하시오
    (단 수당이 0인사원도 포함)

SELECT * FROM DEPT;
SELECT E.ENAME,NVL(E.COMM,0) COMM , D.LOC, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO;

SELECT E.ENAME, NVL(E.COMM,0) COMM, D.LOC, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;





4.   DALLAS 에서 근무하는 사원의 이름 , 직업, 부서번호 , 부서이름
     을 출력하시오

--92
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND D.LOC = 'DALLAS';

--ANSI
SELECT E.ENAME, E.JOB, E.DEPTNO, D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO AND D.LOC = 'DALLAS';


5 이름에  A  가  들어가는 사원들의 이름과 부서이름을 출력하시오

SELECT E.ENAME,D.DNAME
FROM EMP E, DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.ENAME LIKE '%A%';

SELECT E.ENAME,D.DNAME
FROM EMP E INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO AND E.ENAME LIKE '%A%';

6.  사원이름과   그 사원의 관리자 이름을 출력하시오
--( 단 컬럼HEADING을   employeee, manager  출력 )

--92
SELECT E1.ENAME "employee", E2.ENAME "manager"
FROM EMP E1, EMP E2
WHERE E1.MGR = E2.EMPNO;

--ANSI
SELECT E1.ENAME "employee", E2.ENAME "manager"
FROM EMP E1 INNER JOIN EMP E2
ON E1.MGR = E2.EMPNO;
7.    사원이름과 직업, 급여, 급여등급 을 출력하시오

SELECT E.ENAME, E.JOB, E.SAL, S.GRADE
FROM EMP E 
    INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;

SELECT E.ENAME, E.JOB, E.SAL, S.GRADE
FROM EMP E 
    ,SALGRADE S
WHERE E.SAL BETWEEN S.LOSAL AND S.HISAL;

8.   사원이름과 부서명과 월급을 출력하는데 월급이 3000 이상인 사원을
     출력하시오

SELECT E.ENAME,D.DNAME, E.SAL
FROM EMP E,DEPT D
WHERE E.DEPTNO=D.DEPTNO AND E.SAL>=3000;

SELECT E.ENAME, D.DNAME, E.SAL
FROM EMP E
    INNER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO AND E.SAL>=3000;

9. 사원의 이름, 부서번호 와 같은 부서에 근무하는 동료 사원들을
출력하시오
 ex)       FORD 20 SMITH
           JONES  20 SMITH
           JAMES  30 ALLEN
                 …
SELECT  E1.ENAME, E1.DEPTNO,  E2.ENAME
FROM    EMP E1,EMP E2
WHERE   E1.DEPTNO=E2.DEPTNO AND E1.ENAME <> E2.ENAME;

SELECT E1.ENAME, E1.DEPTNO, E2.ENAME
FROM EMP E1
    JOIN EMP E2
ON E1.DEPTNO=E2.DEPTNO AND E1.ENAME != E2.ENAME;    


SELECT ENAME 
FROM EMP 
WHERE DEPTNO=30;

10. BLAKE 이란 사원보다 늦게 입사한 사원의 이름과 입사일을 출력하시오

SELECT E1.ENAME, E1.HIREDATE
FROM EMP E1, EMP E2
WHERE E1.HIREDATE > E2.HIREDATE AND E2.ENAME = 'BLAKE';

SELECT E1.ENAME, E1.HIREDATE
FROM EMP E1
    JOIN EMP E2
ON E1.HIREDATE > E2.HIREDATE AND E2.ENAME='BLAKE';
---
