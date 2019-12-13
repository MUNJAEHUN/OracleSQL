������ ������ ���� ������ ��ġ�� ���� �� �ִ� SQL���� �ۼ��Ͻÿ� .
1. �׽�Ʈ ���� ������ ���� �Ѵ�. ( ID: TEST_ACCOUNT PW: TIGER )

creatE user TEST_ACCOUNT
IDENTIFIED BY TIGER;


2.  DB�� LOGIN �����ϰ� ������ �ο� �Ѵ�.

grant connect, resource to TEST_ACCOUNT;


3. ����̸��� ����, �޿�, �޿���� �� ����϶�  ?

SELECT SCOTT.EMP.ENAME,SCOTT.EMP.JOB,SCOTT.EMP.SAL,SCOTT.SALGRADE.GRADE 
FROM SCOTT.EMP ,SCOTT.SALGRADE ,SCOTT.DEPT 
WHERE SCOTT.EMP.DEPTNO=SCOTT.DEPT.DEPTNO AND SCOTT.EMP.SAL BETWEEN SCOTT.SALGRADE.LOSAL AND SCOTT.SALGRADE.HISAL;

SELECT EMP.ENAME,EMP.JOB,EMP.SAL,SALGRADE.GRADE 
FROM SCOTT.EMP ,SCOTT.SALGRADE ,SCOTT.DEPT 
WHERE EMP.DEPTNO=DEPT.DEPTNO AND EMP.SAL BETWEEN SALGRADE.LOSAL AND SALGRADE.HISAL;


4. 20 �� �μ��� ������ ���� ������ �޴� ������� �̸��� ���ް� �μ�
��ȣ�� ����϶� ?

SELECT ENAME,SAL,DEPTNO
FROM SCOTT.EMP
WHERE SAL IN( SELECT SAL  FROM SCOTT.EMP WHERE DEPTNO = 20);


5. �̸���  T  �� �����ϰ� �ִ� ������  ������ �μ����� �ٹ��ϰ� �ִ� �����
��� ��ȣ�� �̸���  ����϶� ?


SELECT ENAME,EMPNO
FROM SCOTT.EMP
WHERE DEPTNO    IN (SELECT DEPTNO
                FROM SCOTT.EMP
                WHERE ENAME LIKE '%T%');


6. BLAKE �̶� ������� �ʰ� �Ի��� ����� �̸��� �Ի����� ����϶� ?
( SUBQUERY�� JOIN �ΰ��� ��� ��� ���)


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
�׸�1)
SQL> desc cust
Name                                      Null?    Type
----------------------------------------- --------- -------------
CUST_ID                                   NOT NULL NUMBER(6)
CUST_GENDER                                        NUMBER
CUST_NAME                                          VARCHAR2(10)


�׸�2)
SQL> select * from cust;
CUST_ID CUST_GENDER CUST_NAME
-------     -----------     --------
         1           1 ȫ�浿
         2           0 ������
         3           1
         4           0 �Ż��Ӵ�
         5           1 ������


�׸�3)
SQL> /

CONSTRAINT_NAME                C TABLE_NAME
---------------------           -- -----------
CUST_ID_PK                     P CUST


7.      �׸�1ó�� TABLE�� ���� �ϴ� SQL���� �ۼ��Ͻÿ�.

CREATE TABLE CUST(
CUST_ID NUMBER(6) NOT NULL,
CUST_GENDER NUMBER,
CUST_NAME VARCHAR2(12)
);
                    
DESC CUST

8.      �׸�2ó�� �����͸� �߰� �ϴ� SQL���� �ۼ��Ͻÿ�.

INSERT INTO CUST
VALUES(1,1,'ȫ�浿');

INSERT INTO CUST
VALUES(2,0,'������');

INSERT INTO CUST
VALUES(3,1,' ');

INSERT INTO CUST
VALUES(4,0,'�Ż��Ӵ�');

INSERT INTO CUST
VALUES(5,1,'������');

SELECT * FROM CUST
ORDER BY CUST_ID ASC;

9.      CUST ���̺� GRADE �÷��� �߰� �ϴ� SQL���� �ۼ��Ͻÿ�
(�� GRADE �� ����2�ڸ�)

ALTER TABLE CUST
ADD GRADE NUMBER(2);

10.      GRADE �÷��� TYPE�� ���� 4�ڸ��� ���� ��Ű�� SQL���� �ۼ��Ͻÿ�

ALTER TABLE CUST
MODIFY GRADE NUMBER(4);


11.      CUST_ID �÷��� PRIMARY KEY ������ �߰���Ű�ÿ� (�� ������� CUST_ID_PK )

ALTER TABLE CUST
ADD CONSTRAINT CUSI_ID_PK PRIMARY KEY(CUST_ID);

12.      CUST ���̺��� �����Ͽ� CUSTOMER ���̺��� ����

CREATE TABLE CUSTOMER
AS
SELECT * FROM CUST;

13.      �׸�3 ó�� ������ Ȯ���Ҽ� �ִ� �ִ� SQL���� �ۼ��Ͻÿ�.

SELECT CONSTRAINT_NAME,TABLE_NAME
FROM USER_CONSTRAINTS ;

14.      SCOTT  USER�� �� ���̺��� SELECT , INSERT �� �� �ִ� ������ �ο��Ͻÿ�.


GRANT SELECT,INSERT ON TEST_ACCOUNT.CUST TO SCOTT;

