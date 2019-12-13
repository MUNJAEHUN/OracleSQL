-------------------------------------------------------------------
--REPLACE  재배치 함수 (문자 변환 함수) 
SELECT REPLACE ('oracleclub','oracle','db') name FROM DUAL;
-- 해당 문자에서 '문' 자를 다른 문자로 바꿔준다 , 

select replace('OracleDBMS','oracle','mysql')name From dual
union all
select replace('oracleDBMS','oracle','mysql')name From dual;

--대소문자 구분 유의 
-------------------------------------------------------------------


--숫자함수  올림/버림/모드연산

select round(45.139,2),trunc(45.139,2)name from dual;

select mod(101,2) 
from dual;
------------------------------------------------------------------
------------------------------------------------------------------
--실습: 12월에 입사한 사원 이름 ,입사일자,급여 조회

--------------접근1 : 이경우 12월,일,년에 걸릴수있다 -------------------------- 
select * from emp;

select ename,hiredate,sal
from emp
where hiredate like '%12%';
-------------접근2 -------------------------- 

select ename,hiredate,sal
from emp
where hiredate like '___12%';

--------------접근3 -------------------------- 
select ename, hiredate, sal
from emp
where substr(hiredate,4,2)='12';  -- substr(Val,index,range)

------------------------------------------------------------------
------------------------------------------------------------------
--실습2 12월의 입사 사원 정보 조회하고  급여를 6자리로 출력, 단 부족한 자리수는 0으로 표기

select empno, ename, job, mgr, hiredate, LPAD(sal,6,0) as sal , comm, deptno
from emp
where substr(hiredate,4,2)='12';


------------------------------------------------------------------
------------------------------------------------------------------
--실습 3 : 전체사원의 매니저를구분하려한다, 이름 ,직책 , 매니저번호가 0또는 1, 매니저 번호 출력 -> 매니저번호가 짝수면 0, 홀수면 1로 출력 

select * from emp;

select ename, job, MOD(MGR,2) as "MAGNO",empno
from emp
where job='MANAGER';

