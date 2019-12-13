-- ���� 1
SELECT rpad(SUBSTR(ENAME,1,2),length(ename),'*') as result
FROM EMP;



-- ���� 2 

select round(hiredate, 'month') result
from emp;

-- ���� 3

SELECT ENAME,
    NVL(TO_CHAR(COMM),' ') COMM,
    NVL(TO_CHAR(COMM),'���߷�') COMMISION
FROM EMP;


--���� 4

select ename from emp

where hiredate < to_date('19810101','YYYYMMDD');


select ename from emp

where trunc(hiredate, 'YEAR') = '1981-01-01';


select ename from emp 

where trunc(to_char(hiredate, 'YYYY'))=1980;

--���� 5

select ename, (sal*12+nvl(comm,0)) as ���� from emp

where (sal*12+nvl(comm,0)) between 12000 and 45000;

--���� 6

select ename from emp

where substr(ename,1,1) between 'H' and 'U'

order by ename;

--���� 7 

select ename from emp

where instr(ename,'A',2,1) = 2;

--���� 8

select ename, decode(SIGN(sal-comm), -1, 'GOOD', 'BAD') result

from emp


