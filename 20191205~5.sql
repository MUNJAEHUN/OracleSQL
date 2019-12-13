------------------------[��ȯ�Լ�] 
--�Ͻ��� : ����Ŭ ������ �������ش� ex) lpad,rpad �Լ�  800->00800


--����� : ��������ν� ���氡���ϴ� _ ���� ->���� ����->��¥ ��¥->����, ����->����
-- char�� ��¥�� ���� TO_DATE,ó�� ���ϰ��� �ϴ� �ڷ������� TO_�ٲ��ڷ���
--��¥ ���� �𵨿��, ���ڿ� to_char�Լ� ǥ�����Ŀ��,

select sysdate-'80/01/01' --> ����  ORA-01722: invalid number
from emp;

select sysdate-to_date('80/01/01') --> ��ȯ�Լ���� 
from dual;

select sysdate,to_date('20191205') --> '/' ��� ��ȯ�Լ� ����Ʈ�� ��ȯ��
from dual;

select to_char(sysdate,'cc yyyy/mm/dd:hh24:mi:ss') -->   �������Ͻú���
from dual;

------------------ �޿� ���º�ȯ  ���� -> ���ڿ�

select ename,sal
from emp;

select ename,to_char(sal,'$999,999.99') --> �ڸ���,�Ҽ��� ǥ��
from emp;

--�޸� ����
select to_char(12345678,'999,999,999')
from dual;

-- ���� ��ȭ ��ȣ 'l' 
select to_char(12345678,'l999,999,999')
from dual;

--0ǥ�� ��������

select to_char(123,'0999')from dual;

--16���� ��ȯ 

select to_char(123,'XXXX')from dual; --> X-> 16���� ��ȯ ����


----------------------���ڸ� ���ڷ� ��ȯ
-->�޴�����ȣ �Է¹����� 010->10���� ǥ�õǴ� ��Ȳ�� ���� 0�߿��ϸ� �ڷ��� �Ű澲��.
-->���� �Ǽ��� 10���� ǥ�õǴ� ��� , '0'���̱ⰰ�� ������ ��ó ����.
select to_number('012345678') from dual;


----------------------[�Ϲ��Լ�]
--null�� ó���ϴ� �Լ�  : nvl, nvl2, nullif, coalesce
--���Ǻ� ǥ���� : case(ANSIǥ��), decode(Oracle)

select ename,sal*12+comm fullsal --> comm�� �����ʴ� ��� ����� ������ ���� (null=������,?,���Ѵ�)
from emp;

-----------------------NVL 
select ename,sal*12+nvl(comm,0) fullsal  --> null�� ������ �ش簪 ����
from emp;


----------------------NVL2 (col,val1,val2) --> null�̸� val2,�ƴϸ� val1
-- ex) ������� �Ŵ����� ������ ���� 1,0 ���

select empno,nvl2(MGR,1,0) --> �ڽ��� �Ŵ����� ������ 1 �ƴϸ� (NULL) 0
from emp;

--coalesce (col,VAL1,VAL2) --> COL�� NULL�̸� VAL1, VAL1�� NULL�̸� VAL2 = NULL�� �ּ�ȭ

SELECT COALESCE(COMM,1),COMM
FROM EMP;


SELECT COALESCE(COMM,NULL,2),COMM
FROM EMP;

---------------------NULLIF : �� ǥ������ ��, �����ϸ� NULL��ȯ, �������������� ùǥ������ ��ȯ
SELECT NULLIF('A','a'),NULLIF('A','A')
from dual;
-------> ���ڴ� ùǥ��������, ���ڴ� null�� ǥ���ȴ�.


-----------------------DECODE�Լ� : ���ǿ� ���� �����͸� �ٸ� ���̳� �÷� ������ ���� �� ���ִ� �Լ� 
--DECODE(VALUE,IF1,THEN1,THEN2 . . .)  => ����� IF1�̸� THEN ����ȯ, �ƴϸ�(IF2��) IF2����ȯ
--: DECODE �Լ� �ȿ� DECODE �Լ��� �������� (���� ���ǹ�) 
-- #########################################�ּ� ����Ű : ��Ʈ�� ������
--  �μ���ȣ�� 10�̸� ACCOUNTING, 20=RESERCH, 30=SALES, ETC=OPERATIONS ���
SELECT DEPTNO, 
       DECODE(DEPTNO,10,'ACCOUNTING',20,'RESERCH',30,'SALES','OPERATIONS')
FROM DEPT;


-------------------------------CASE ���� ( ANSI ǥ��) 
-- ���Ǻ� ǥ����  : DECODE �� ������
-- DECODE���� �������� �ʴ� �񱳿�������� �ذ��Ҽ��ִ�.
-- => ���� ������ �� ��밡��.

SELECT DEPTNO,
       CASE DEPTNO
            WHEN 10 THEN 'ACCOUNTING'
            WHEN 20 THEN 'RESERCH'
            WHEN 30 THEN 'SALES'
            ELSE 'OPERATIONS'
       END
FROM DEPT;

-------------------------------CASE�� ���� ������
--�޿����� �λ����� �ٸ��� ������ ��� (���)

SELECT ENAME,SAL,
    CASE 
        WHEN SAL < 1000 THEN SAL+(SAL*0.08)
        WHEN SAL BETWEEN 1000 AND 2000 THEN SAL+(SAL*0.05)
        WHEN SAL BETWEEN 2001 AND 3000 THEN SAL+(SAL*0.03)
        ELSE SAL+(SAL*0.01)
    END AS "UPSAL"
FROM EMP;

------------------------------�ǽ� 
--��å : �Ŵ��� ��� -> �޿� 10%�λ�
--��å : CLACK 5%�λ�
--������ : 2%�λ�
-----------------------------���� 1 : CASE 
SELECT ENAME,JOB,SAL,
    CASE
        WHEN JOB='MANAGER' THEN SAL+(SAL*0.1)
        WHEN JOB='CLERK' THEN SAL+(SAL*0.05)
        ELSE (SAL+SAL*0.02)
    END "UPSAL"
FROM EMP;
---------------------------���� 2 : DECODE
SELECT ENAME,JOB,SAL,
    DECODE(JOB,'MANAGER',SAL*1.1,
                'CLERK',SAL*1.05,
                SAL*1.02) "UPSAL"
FROM EMP;
