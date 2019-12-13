------------------------[변환함수] 
--암시적 : 오라클 서버가 변경해준다 ex) lpad,rpad 함수  800->00800


--명시적 : 명시함으로써 변경가능하다 _ 숫자 ->문자 문자->날짜 날짜->문자, 문자->숫자
-- char가 날짜로 갈때 TO_DATE,처럼 변하고자 하는 자료형으로 TO_바꿀자료형
--날짜 형식 모델요소, 숫자에 to_char함수 표현형식요소,

select sysdate-'80/01/01' --> 문자  ORA-01722: invalid number
from emp;

select sysdate-to_date('80/01/01') --> 변환함수사용 
from dual;

select sysdate,to_date('20191205') --> '/' 없어도 변환함수 디폴트로 반환함
from dual;

select to_char(sysdate,'cc yyyy/mm/dd:hh24:mi:ss') -->   세기년월일시분초
from dual;

------------------ 급여 형태변환  숫자 -> 문자열

select ename,sal
from emp;

select ename,to_char(sal,'$999,999.99') --> 자리수,소수점 표기
from emp;

--콤마 예제
select to_char(12345678,'999,999,999')
from dual;

-- 로컬 통화 기호 'l' 
select to_char(12345678,'l999,999,999')
from dual;

--0표시 강제적용

select to_char(123,'0999')from dual;

--16진수 변환 

select to_char(123,'XXXX')from dual; --> X-> 16진수 변환 포맷


----------------------문자를 숫자로 변환
-->휴대폰번호 입력받을시 010->10으로 표시되는 상황과 같이 0중요하면 자료형 신경쓰자.
-->만약 실수로 10으로 표시되는 경우 , '0'붙이기같은 유연한 대처 가능.
select to_number('012345678') from dual;


----------------------[일반함수]
--null을 처리하는 함수  : nvl, nvl2, nullif, coalesce
--조건부 표현식 : case(ANSI표준), decode(Oracle)

select ename,sal*12+comm fullsal --> comm을 받지않는 모든 사람의 연봉이 누락 (null=무존재,?,무한대)
from emp;

-----------------------NVL 
select ename,sal*12+nvl(comm,0) fullsal  --> null이 맞으면 해당값 대입
from emp;


----------------------NVL2 (col,val1,val2) --> null이면 val2,아니면 val1
-- ex) 사원들의 매니저의 유무에 따라 1,0 출력

select empno,nvl2(MGR,1,0) --> 자신의 매니져가 있으면 1 아니면 (NULL) 0
from emp;

--coalesce (col,VAL1,VAL2) --> COL이 NULL이면 VAL1, VAL1이 NULL이면 VAL2 = NULL의 최소화

SELECT COALESCE(COMM,1),COMM
FROM EMP;


SELECT COALESCE(COMM,NULL,2),COMM
FROM EMP;

---------------------NULLIF : 두 표현식을 비교, 동일하면 NULL반환, 동일하지않으면 첫표현식을 반환
SELECT NULLIF('A','a'),NULLIF('A','A')
from dual;
-------> 전자는 첫표현식으로, 후자는 null로 표현된다.


-----------------------DECODE함수 : 조건에 따라 데이터를 다른 값이나 컬럼 값으로 추출 할 수있는 함수 
--DECODE(VALUE,IF1,THEN1,THEN2 . . .)  => 밸류가 IF1이면 THEN 값반환, 아니면(IF2면) IF2값반환
--: DECODE 함수 안에 DECODE 함수를 중접가능 (이중 조건문) 
-- #########################################주석 단축키 : 컨트롤 슬래쉬
--  부서번호가 10이면 ACCOUNTING, 20=RESERCH, 30=SALES, ETC=OPERATIONS 출력
SELECT DEPTNO, 
       DECODE(DEPTNO,10,'ACCOUNTING',20,'RESERCH',30,'SALES','OPERATIONS')
FROM DEPT;


-------------------------------CASE 구문 ( ANSI 표준) 
-- 조건부 표현식  : DECODE 와 유사함
-- DECODE에서 제공하지 않는 비교연산단점을 해결할수있다.
-- => 조건 연산자 다 사용가능.

SELECT DEPTNO,
       CASE DEPTNO
            WHEN 10 THEN 'ACCOUNTING'
            WHEN 20 THEN 'RESERCH'
            WHEN 30 THEN 'SALES'
            ELSE 'OPERATIONS'
       END
FROM DEPT;

-------------------------------CASE와 조건 연산자
--급여별로 인상율을 다르게 적용할 경우 (계산)

SELECT ENAME,SAL,
    CASE 
        WHEN SAL < 1000 THEN SAL+(SAL*0.08)
        WHEN SAL BETWEEN 1000 AND 2000 THEN SAL+(SAL*0.05)
        WHEN SAL BETWEEN 2001 AND 3000 THEN SAL+(SAL*0.03)
        ELSE SAL+(SAL*0.01)
    END AS "UPSAL"
FROM EMP;

------------------------------실습 
--직책 : 매니져 사원 -> 급여 10%인상
--직책 : CLACK 5%인상
--나머지 : 2%인상
-----------------------------접근 1 : CASE 
SELECT ENAME,JOB,SAL,
    CASE
        WHEN JOB='MANAGER' THEN SAL+(SAL*0.1)
        WHEN JOB='CLERK' THEN SAL+(SAL*0.05)
        ELSE (SAL+SAL*0.02)
    END "UPSAL"
FROM EMP;
---------------------------접근 2 : DECODE
SELECT ENAME,JOB,SAL,
    DECODE(JOB,'MANAGER',SAL*1.1,
                'CLERK',SAL*1.05,
                SAL*1.02) "UPSAL"
FROM EMP;
