-------------------------------------------------------------------
--REPLACE  ���ġ �Լ� (���� ��ȯ �Լ�) 
SELECT REPLACE ('oracleclub','oracle','db') name FROM DUAL;
-- �ش� ���ڿ��� '��' �ڸ� �ٸ� ���ڷ� �ٲ��ش� , 

select replace('OracleDBMS','oracle','mysql')name From dual
union all
select replace('oracleDBMS','oracle','mysql')name From dual;

--��ҹ��� ���� ���� 
-------------------------------------------------------------------


--�����Լ�  �ø�/����/��忬��

select round(45.139,2),trunc(45.139,2)name from dual;

select mod(101,2) 
from dual;
------------------------------------------------------------------
------------------------------------------------------------------
--�ǽ�: 12���� �Ի��� ��� �̸� ,�Ի�����,�޿� ��ȸ

--------------����1 : �̰�� 12��,��,�⿡ �ɸ����ִ� -------------------------- 
select * from emp;

select ename,hiredate,sal
from emp
where hiredate like '%12%';
-------------����2 -------------------------- 

select ename,hiredate,sal
from emp
where hiredate like '___12%';

--------------����3 -------------------------- 
select ename, hiredate, sal
from emp
where substr(hiredate,4,2)='12';  -- substr(Val,index,range)

------------------------------------------------------------------
------------------------------------------------------------------
--�ǽ�2 12���� �Ի� ��� ���� ��ȸ�ϰ�  �޿��� 6�ڸ��� ���, �� ������ �ڸ����� 0���� ǥ��

select empno, ename, job, mgr, hiredate, LPAD(sal,6,0) as sal , comm, deptno
from emp
where substr(hiredate,4,2)='12';


------------------------------------------------------------------
------------------------------------------------------------------
--�ǽ� 3 : ��ü����� �Ŵ����������Ϸ��Ѵ�, �̸� ,��å , �Ŵ�����ȣ�� 0�Ǵ� 1, �Ŵ��� ��ȣ ��� -> �Ŵ�����ȣ�� ¦���� 0, Ȧ���� 1�� ��� 

select * from emp;

select ename, job, MOD(MGR,2) as "MAGNO",empno
from emp
where job='MANAGER';

