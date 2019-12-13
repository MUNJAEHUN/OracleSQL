--------------------------------------------------------------
------------------------�Լ� ��ø Ȱ�� 
SELECT ENAME, INITCAP(CONCAT(SUBSTR(ENAME,1,2),'_US'))  --CONCAT ���ڰ����Լ�
FROM EMP 
WHERE DEPTNO=10 ;

SELECT TO_CHAR(ROUND(SAL/7,2))
FROM EMP;
--------------------------------------------------------------
-----------------------�׷� �Լ�(���� ��) 
-- �׷�� �ϳ��� ����� ��ȯ 
-- AVG, COUNT, MAX, MIN, STDDV, SUM, VARIANCE, DISTINCT

-- MAX, MIN�� LOB, LONG �ڷ����� ��� �Ұ� --> �ڷ��� ��ü���� ū�뷮�� �����ϰ� �־� �ִ� �ּҰ� ���ǹ��� �Լ� ���� 

SELECT ROUND(AVG(SAL),2),MAX(SAL),MIN(SAL),SUM(SAL)
FROM EMP;

------------------------���ǿ� ���� �׷��Լ� ���� 

SELECT ROUND(AVG(SAL),2),MAX(SAL),MIN(SAL),SUM(SAL)
FROM EMP 
WHERE JOB LIKE 'CLERK';

-------------------------���� �ֱ��Ի� , ������ ��� ( DATE ���Ŀ����� MAX,MIN) 

SELECT MAX(HIREDATE),MIN(HIREDATE)
FROM EMP;

------------------------�����ټ� �Ի��� MAX(�޽��縵),MIN(ù���縵) [ ���ڿ����� MAX,MIN ��밡�� ]
SELECT MAX(ENAME),MIN(ENAME)
FROM EMP;

------------------------COUNT : ���̺� Ʃ�� ���� ��ȯ
-------------------  NULL�� ����ִ� Ʃ���� ī��Ʈ ���� �ʴ´�. �̴� ���(��ü��)�� ���ϹǷ� NULLó�� �Լ��� ���� �̸� �ذ��ؾ��Ѵ�.




SELECT COUNT(*)
FROM EMP;
--------------EX) ȸ�� ��� ���� ���ϼ��� 

SELECT COUNT(ENAME)
FROM EMP;

-------------�ǽ�) 10�� �μ� ����� ���� ���
SELECT COUNT(ENAME)
FROM EMP
WHERE DEPTNO=10;

--
SELECT COUNT(COMM)---------NULL�� ����ִ� Ʃ��
FROM EMP;

SELECT COMM,ENAME
FROM EMP;

---------------------NULL�� �����ϰ� �Լ� ����  
SELECT AVG(COMM)
FROM EMP;
------------>��ü����� ��������� ���ҋ� NULL���Ե� �ο��� �����ϰ� AVG����ǹǷ� �߰� ���� �����ؾ���
----> NULL�� �����ֵ��� ��ȯ�Ͽ� ����ϴ� ���� ����

SELECT ROUND(AVG(NVL(COMM,'0')),3)
FROM EMP;

SELECT ROUND(STDDEV(SAL),3) SALARY --ǥ������
FROM EMP;

-------------��ü���� ��ձ޿�,�� �޿�,�ְ�,�ּұ޿� (����� �Ҽ��� 2�ڸ� , �հ�� õ���� ǥ��)

SELECT MAX(SAL) max,MIN(SAL) min ,ROUND(AVG(SAL),2) AVG ,TO_CHAR(SUM(SAL),'999,999')
FROM EMP;

--------------------------------------------------------------
--------------------------------------GROUP BY  : �� ���� �׷����̺�� ���� 

SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO;     --- 10������,20������,30������ ���ڴ� ( �� ���� �׷����� �����ϰڴ� )

--------------------- �� �μ���ȣ���� ��ձ޿��� ����϶�

SELECT ROUND(AVG(SAL),2),DEPTNO
--------------> DEPTNO ���� ���ϸ� 3���� �׷����� �����Ե� ( DEPT�� �÷� ����ŭ�� �׷��� �����ȴ�.)
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO ASC;

----> �� �������� ��� �޿��� ����϶� 
SELECT * FROM EMP;

SELECT JOB,ROUND(AVG(SAL),3)
FROM EMP
GROUP BY JOB;


--------------------GROUP BY ���� 2�� �̻��� �÷� ��� ���� , ��� ��ġ�ϴ� Ʃ�ó��� ( ROW ) �׷��� �����Ҽ��ִ�.

SELECT DEPTNO, JOB, AVG(SAL)
FROM EMP
GROUP BY DEPTNO, JOB ;

-- �������� �׷�ȭ �Ͽ� ����,�ο���,��ձ޿�,�ְ�޿�,�ּұ޿�,�հ� ��ȸ
SELECT JOB,COUNT(ENAME),ROUND(AVG(SAL),2),MAX(SAL),MIN(SAL),SUM(SAL)
FROM EMP
GROUP BY JOB
ORDER BY JOB ASC;
------------

SELECT COUNT(ENAME)
FROM EMP
GROUP BY JOB;



-----------------------------------------------------------------------------------
------------------------HAVING :GROUP BY ���� WHERE ��, �׷쿡 ���� ������ ������ִ�.
--EX) 
SELECT DEPTNO,AVG(SAL)
FROM EMP
GROUP BY DEPTNO
HAVING AVG(SAL)>=2500;           ---SAL 2500�̻��� �׷�(�μ�)�� �μ���ȣ�� ǥ�� 

----------��å�� ��� �޿��� �˻� 

SELECT JOB, AVG(SAL)
FROM EMP 
GROUP BY JOB
HAVING AVG(SAL)>=1500;

---------�ǽ�1 : �� �μ��� ����� �ο��� �ִ��� ��� 

SELECT DEPTNO, COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO;


---------�ǽ�2 : �ο��� 2�� ��R���� �μ� ��� 

SELECT DEPTNO, COUNT(ENAME)
FROM EMP
GROUP BY DEPTNO
HAVING COUNT(ENAME)>=2;



-------------------------------�׷��Լ��� ��ø�� �����ϴ�

SELECT MAX(AVG(SAL))
FROM EMP
GROUP BY DEPTNO;





