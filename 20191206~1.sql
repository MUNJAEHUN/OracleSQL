--------------------------------------------------------------
------------------------함수 중첩 활용 
SELECT ENAME, INITCAP(CONCAT(SUBSTR(ENAME,1,2),'_US'))  --CONCAT 문자결합함수
FROM EMP 
WHERE DEPTNO=10 ;

SELECT TO_CHAR(ROUND(SAL/7,2))
FROM EMP;
--------------------------------------------------------------
-----------------------그룹 함수(다중 행) 
-- 그룹당 하나의 결과를 반환 
-- AVG, COUNT, MAX, MIN, STDDV, SUM, VARIANCE, DISTINCT

-- MAX, MIN은 LOB, LONG 자료형에 사용 불가 --> 자료형 자체들이 큰용량을 차지하고 있어 최대 최소가 무의미해 함수 설정 

SELECT ROUND(AVG(SAL),2),MAX(SAL),MIN(SAL),SUM(SAL)
FROM EMP;

------------------------조건에 대한 그룹함수 수행 

SELECT ROUND(AVG(SAL),2),MAX(SAL),MIN(SAL),SUM(SAL)
FROM EMP 
WHERE JOB LIKE 'CLERK';

-------------------------가장 최근입사 , 오래된 사원 ( DATE 형식에서의 MAX,MIN) 

SELECT MAX(HIREDATE),MIN(HIREDATE)
FROM EMP;

------------------------가나다순 입사사원 MAX(뒷스펠링),MIN(첫스펠링) [ 문자에서도 MAX,MIN 사용가능 ]
SELECT MAX(ENAME),MIN(ENAME)
FROM EMP;

------------------------COUNT : 테이블 튜플 수를 반환
-------------------  NULL이 들어있는 튜플을 카운트 하지 않는다. 이는 모수(전체수)가 변하므로 NULL처리 함수를 통해 이를 해결해야한다.




SELECT COUNT(*)
FROM EMP;
--------------EX) 회사 사원 수를 구하세요 

SELECT COUNT(ENAME)
FROM EMP;

-------------실습) 10번 부서 사원의 수를 출력
SELECT COUNT(ENAME)
FROM EMP
WHERE DEPTNO=10;

--
SELECT COUNT(COMM)---------NULL이 들어있는 튜플
FROM EMP;

SELECT COMM,ENAME
FROM EMP;

---------------------NULL은 제외하고 함수 수행  
SELECT AVG(COMM)
FROM EMP;
------------>전체사원의 수당평균을 구할떄 NULL포함된 인원을 제외하고 AVG적용되므로 추가 연산 수행해야함
----> NULL을 셀수있도록 변환하여 계산하는 접근 가능

SELECT ROUND(AVG(NVL(COMM,'0')),3)
FROM EMP;

SELECT ROUND(STDDEV(SAL),3) SALARY --표준편차
FROM EMP;

-------------전체직원 평균급여,총 급여,최고,최소급여 (평균은 소수점 2자리 , 합계는 천단위 표기)

SELECT MAX(SAL) max,MIN(SAL) min ,ROUND(AVG(SAL),2) AVG ,TO_CHAR(SUM(SAL),'999,999')
FROM EMP;

--------------------------------------------------------------
--------------------------------------GROUP BY  : 더 작은 그룹테이블로 분할 

SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO;     --- 10번끼리,20번끼리,30번끼리 묶겠다 ( 더 작은 그룹으로 분할하겠다 )

--------------------- 각 부서번호별로 평균급여를 출력하라

SELECT ROUND(AVG(SAL),2),DEPTNO
--------------> DEPTNO 기재 안하면 3개의 그룹으로 나오게됨 ( DEPT의 컬럼 수만큼의 그룹이 생성된다.)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;

----> 각 업무별로 평균 급여를 출력하라 
SELECT * FROM EMP;

SELECT JOB,ROUND(AVG(SAL),3)
FROM EMP
GROUP BY JOB;


--------------------GROUP BY 절에 2개 이상의 컬럼 사용 가능 , 모두 일치하는 튜플끼리 ( ROW ) 그룹을 생성할수있다.

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB ;

-- 업무별로 그룹화 하여 업무,인원수,평균급여,최고급여,최소급여,합계 조회
SELECT JOB,COUNT(ENAME),ROUND(AVG(SAL),2),MAX(SAL),MIN(SAL),SUM(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB ASC;
------------

SELECT COUNT(ENAME)
FROM EMP
GROUP BY JOB;



-----------------------------------------------------------------------------------
------------------------HAVING :GROUP BY 절의 WHERE 절, 그룹에 대한 조건을 세울수있다.
--EX) 
SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>=2500;           ---SAL 2500이상인 그룹(부서)의 부서번호를 표현 

----------직책별 평균 급여를 검색 

SELECT JOB, AVG(SAL)
FROM EMP 
GROUP BY JOB
HAVING AVG(SAL)>=1500;

---------실습1 : 각 부서별 몇명의 인원이 있는지 출력 

SELECT DEPTNO, COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO;


---------실습2 : 인원이 2명 이R상인 부서 출력 

SELECT DEPTNO, COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(ENAME)>=2;



-------------------------------그룹함수도 중첩이 가능하다

SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;





