---------------------------------------조인 함수 
-----------두개 이상의 테이블에서 테이블마다 필요한 자료를 가져오기 위한 방법

SELECT  ENAME,DNAME
FROM EMP,DEPT;                 -- EMP ; 12 , DEPT : 4  튜플 있으므로  12*4의 결과가 반환 = 카티션 프로덕트 모든 행끼리의 수행 

-- 테이블간 공통 조인 조건이 필요함 -> 이렇게 되면 다 읽을 필요가 없어진다 

SELECT  ENAME,DNAME
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO; -- > 조건을 걸어 정확한 값만 반환 가능함.



------오라클 92(년도)JOIN
--이퀄 조인 ,논이퀄 조인 ,셀프 조인 ,아우터 조인

------ANSI표준 조인
-- 이너(이퀄 ,논이퀄)조인 ,아우터조인 ,크로스조인 ,내추럴 조인



-----------------------------------조인 시 공통된 값 기본키, 외래키를 사용하여 조인한다,


--------------92 이퀄조인의 표현 형식----------
SELECT EMP.EMPNO, EMP,ENAME, DEPT.DNAME
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO;

----------- 컬럼에 테이블명을 붙여 표현, 
SELECT E.EMPNO, E,ENAME, D.DNAME
FROM EMP E,DEPT D             -- WHERE절 ㅈ건
WHERE EMP.DEPTNO=DEPT.DEPTNO;

---------------------------ANSI EQUL-INNER 조인 형식  --- 이것도 조인조건이 TRUE를 반환하는 자료 반환
SELECT E.ENAME,D.DNAME
FROM EMP E INNER JOIN DEPT D  -- INNER JOIN ~~~ ON
ON E.DEPTNO=D.DEPTNO;

-------테이블의이름이 길어져 타이핑에 시간이 소요되는걸 막고자 별칭 


--------------------------ANSI NON-EQUL-INEENR 조인 형식 
-------------실행하기 위한 조건 -> 테이블의 어떤 컬럼도 조인할 테이블 컬림에 일치하지 않을때, && 조인 컨디션에 "=" 을 제외한 연산자가 사용되는 경우 
--                              (BETWEEN,AND,IS NULL,NOT NULL,IN,NOT IN)를 사용할때 

---- EX) 전체 사원의 이름과 급여등급을 조회하는 경우 

SELECT E.ENAME,S.GRADE
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;  ---- 사원의 샐러리를 가지고 SALGRADE에 있는 LO,HISAL의 범위로 등급을 부여후 반환 

-------------------실습 : 전체 사원명, 부서명, 급여등급을 조회
SELECT E.ENAME,D.DNAME,S.GRADE
FROM EMP E , SALGRADE S , DEPT D
WHERE (E.SAL BETWEEN S.LOSAL AND S.HISAL) AND  E.DEPTNO=D.DEPTNO;


----------------92 형식 논이퀄-------------
SELECT E.ENAME,S.GRADE
FROM EMP E , SALGRADE S 
WHERE (E.SAL BETWEEN S.LOSAL AND S.HISAL);

-----------------------------------92 셀프 조인 
-- 이퀄조인과 같으나 하나의 테이블에서 조인이 일어나는 형태, 같은 테이블에 대해 2개의 ALIAS를 사용하여 FROM절에서 조인하는 방식  
-- 서로 다른 튜플끼리의 비교 
--------------------EX) 각 사원들의 매니저 이름을 조회하라.

SELECT * FROM EMP ;


SELECT E1.ENAME,E2.ENAME  ---------E1 =사원 . E2= 매니저
FROM EMP E1,EMP E2
WHERE E1.MGR=E2.EMPNO;

----------------------92 아우터 조인 : EQUI 조인은 조인생성시 한쪽 컬럼에 값이 없으면 반환하지 못하지만 아우터조인은 가능함 
--                       일치값 가지고 있지 않아도 조인 가능 -> 널로 생성 
--                       동일 조건에서 조인 조건을 만족하는 값이 없는 행들을 조회하기 위해 사용 
--                    92 아우터 조인 연산자 (+)를 조인값이 없는 조인측에 위치시킴.  단 표현식의 한편에만 사용가능하다. (+)=0,0=(+) 0 > 표현하고 싶은장소
--EX)
SELECT DISTINCT(E.DEPTNO),D.DEPTNO,D.DNAME
FROM EMP E , DEPT D 
WHERE E. DEPTNO = D. DEPTNO;  

---> 이 구문을 실행할시에 DEPTNO의 40이 없음 ..  << EMP에 40번에 근무하는 사원이없기 때문 
--> 모든 부서를 보여달라고 할시에는 보여줘야 하므로 이에 아우터 조인을 사용하여 모든 부서 번호를 반환한다.

--EX2)
--사원 테이블에서 사원이름 모두와 매니저명을 조회

SELECT E.ENAME,C.ENAME
FROM  EMP E,EMP C
WHERE E.MGR = C.EMPNO; ----> 이 반환값은 KING이 나오지 않으므로 모든 사원이 반환되었다고 할수없다.

SELECT E.ENAME,C.ENAME
FROM  EMP E,EMP C
WHERE E.MGR = C.EMPNO(+);---> 따라서 아우터 조인을 통해 KING을 표현할 수 있게 된다.
----------


-------------------------ANSI 아우터 조인 
--                       LEFT OUTER JOIN , RIGHT OUTER JOIN , FULL OUTER JOIN 
-- LEFT OUTER JOIN - 이너조인 결과(공통된 트루값)도 표시, 조인키워드 왼편에있는 테이블에서 조인조건을 만족시키지못해 표시되지않은 레코드를 표시 - 3튜플 반환

SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM EMP E 
    LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- RIGHT OUTER JOIN - 이너조인 결과(공통된 트루값)도 표시, 조인키워드 오른편에있는 테이블에서 조인조건을 만족시키지못해 표시되지않은 레코드를 표시 -4튜플 반환
SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM EMP E 
    RIGHT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

--  FULL OUTER JOIN - 양 테이블모두에 남는 레코드들을 표시하기 위해 사용

SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM EMP E 
    full OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

--------------------------ANSI 내추럴 조인 (자연조인) : EQUI,INNER 조인과 동일
--        두 테이블에 동일한 이름을 가진 컬럼을 모두 조인시킨다. -> 동일한 컬럼에 테이블 별칭을 주면 오류가 발생 ( ON 절에서 에러 ) -> ######ON절 생략 가능하다 , 안쓰는 경향

--SELECT E.ENAME,D.DNAME
--FROM EMP E NATURAL JOIN DEPT D  -----------> 동일 컬럼을 모두 찾아야 하므로 별칭 사용X ( ON에서 에러나서 )
--ON E.DEPTNO=D.DEPTNO;

SELECT ENAME,DNAME
FROM EMP NATURAL JOIN DEPT;  ----------> 알아서 둘의 공통된 컬럼을 찾아 반환

-------------------------USING : 동일한 컬림이 두개 이상일 경우 사용     JOIN~USING  EQUI 이너조인 인용 
SELECT E.ENAME,D.DNAME,DEPTNO
FROM EMP E
    INNER JOIN DEPT D  --> INNER 생략 가능 
USING(DEPTNO);



--------------------------ANSI 크로스 조인  
-- 강제로 두개의 조인 결과값을 모두 표현하고자 할때, CARTESIAN PRODUCT 값을 얻을 때 사용 , 이너/ 아우터 조인으로 합쳐 질 수 없는 행(튜플)들을 합칠때  활용 

SELECT ENAME
FROM EMP CROSS JOIN DEPT;   ---> 12*4 = 48 

--- 테이블의 행의 수를 극소수로 제한하는 조건과 함께 사용하는것을 권장 ---> 처리 소요때문에
--EX
SELECT E.EMPNO,D.DNAME,E.ENAME
FROM EMP E  
    CROSS JOIN DEPT D
WHERE D.DEPTNO=10;

--------