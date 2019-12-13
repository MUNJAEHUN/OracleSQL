--DDL 
--
--�����ͺ��̽� ��ü
--
--���̺� -> �����͸� �����Ѵ�
--�� -> ������ ���̺�, �ϳ��̻� ���̺��� ������ �κ�����
--������ -> ���ڰ��� �����Ѵ�
--�ε��� -> ����(����)������ ����ų�� ���
--���Ǿ� -> ��ü�� �ٸ� �̸��� �ο�
--
--���̺� �̸� ������Ģ
--1.A_Z,a_z,0_9,_,&,#
--2.ù ���ڴ� ������
--3.����� ���x
--4.�ǹ��ִ� �̸� ���

--���̺� ����
--:���̺� �����ҽ� ����(������)�� create table ������ �ʼ�, ��ü�� ������ ���念���� �ʿ�
--:dba�� dcl���� ����Ͽ� �������� ������ �ο�


--CREATE TABLE COPY_EMP2(
--EMPNO NUMBER(4),
--ENAME VARCHAR(20), -- VARCHAR : �ִ� 4000�� 
--                   -- �� ) LONG : 2G �ؽ�Ʈ, LONG RAW:2G �̹���
--                   --> LOB(LARGE OBJECT),CLOB,BLOB,BFILE : 4G
--JOB CHAR(20),      -- �ִ� 2000��
--SAL NUMBER(7,2),
--HIREDATE DATE
--);

CREATE TABLE COPY_EMP2(
EMPNO NUMBER(4),
ENAME VARCHAR(20), --> VARCHAR2�� �ڵ���ȯ
JOB CHAR(20),
SAL NUMBER(7,2),
HIREDATE DATE
);

DESC COPY_EMP2

CREATE TABLE BIGDATA1(
D1 LONG,        -- �����̺��� �ϳ��� LONGŸ�Ը� �����ִٴ� ���� ǥ��
D2 LONG RAW);

CREATE TABLE BIGDATA2(
D1 CLOB,  D2 BLOB, D3 BFILE
); -- �Ѱ��� ���̺� 4G�̻��� �����͸� �����ϴ� �÷�Ÿ�Ե�� ���̺� ����


--���̺� ������ �������� ��밡��
CREATE TABLE EMPS
AS
SELECT * FROM EMP;

SELECT * FROM EMPS;


--���� COPY_EMP3 ���̺��� ����
--EMP ���̺�� ������ ����, ROW�� �ϳ��� ���� ���� (�����Ͱ� ����)
--�� �ڵ带 ������ ����
-------------- ������ Ǯ�� ----------
CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP;

DELETE FROM COPY_EMP3;

---------------����1 : ���ǿ� ���� �����ʴ� ����� ���� ����,-------

CREATE TABLE COPY_EMP3
AS
SELECT * FROM EMP
WHERE EMPNO=9999; -- 9999�ڸ��� NULL�� ��ü�Ͽ� ������ ��� 


--INSERT ���������� �������� ��밡��
INSERT INTO COPY_EMP3
SELECT * FROM EMP;


--���̺� ���� ����
----1.ALTER TABLE ����
--�� �� �߰� 
--���� ���� ���Ǹ� ���� (�ѹ�->ĳ����)
--���� �⺻������, �� ����,�� �̸��ٲٱ�, �б� ���� ���·� ���̺� ����(11G��)

--���̺� �÷� �߰�
ALTER TABLE EMPS
ADD HP VARCHAR(10);

--�÷��̸� ����
ALTER TABLE EMPS
RENAME COLUMN HP TO MP;

-- �÷� ���� ����
ALTER TABLE EMPS
MODIFY MP VARCHAR2(15);

-- �÷� ����
ALTER TABLE EMPS
DROP COLUMN MP;

--�б����� ���̺� : READ ONLY �������� ���̺��� �б��������� ���� -> DML��� X �����ͼ��������ʴ��� DDL�� ���� ����
ALTER TABLE EMPS READ ONLY;

INSERT INTO EMPS(EMPNO)
VALUES (9999); -- ���� �߻� �б�����

--�б� ����
ALTER TABLE EMPS READ WRITE; -- �б��������� ���̺��� �����Ҽ��ִ�. DROP�� ������ ��ųʸ����� ����ǹǷ� ���̺� ���뿡 ������ �� �ʿ䰡 ���� ���� 

--���̺� ���� 
DROP TABLE EMPS;
DESC EMPS

--��) DELETE : ���̺� Ʃ�� ����, DROp ���̺� ��ü ����, TRUNCATE : DELETE�� �޸� ROLLBACK ���� �Ұ�
---> ROLLBACK�� Ʈ������ �������̾���� , WHERE�� ��� �Ұ�(�κл����Ұ�)


--���̺� ���� (���)
-- > DROP ����� RECYCLEBIN�� �̵� (������ ����)
SHOW RECYCLEBIN

FLASHBACK TABLE EMPS
TO BEFORE DROP; -- ��� ������ EMPS�� ����


--����
DROP TABLE EMPS;


--������ ���� : �ٷλ������ DROP ���� ����� �ǵڿ� PURGE �߰��Ͽ� ��뵵 ���� 
PURGE RECYCLEBIN;

DESC EMPS;


--���̺� �̸� ���� 
RENAME COPY_EMP2
TO EMPS;

--���̺� �ּ� �߰� 
COMMENT ON TABLE EMPS
IS 'EMP��  EMPLOYEE �̴�';

SELECT * FROM EMPS;
DESC EMPS;

 --�ּ��� DATA DICTIONARY���� Ȯ���Ҽ��ִ�.
 
DESC USER_TAB_COMMENTS;
SELECT * FROM USER_TAB_COMMENTS;





----------------------------------------
--DDL ����
--1, ���ü�
--2, ���ð���
--3, ���ü� ���� - Ʈ������ EX)���� ������ü
                COMMINT, ROLLBACK, SAVEPOINT
            
--            
--2, ���Ἲ
--    : ���Ἲ�� ������Ű����? DDL, DML ���� �� �� ���̺� ������ �����Ҷ��� �����Ҽ� �ֵ��� �ϸ� �ȴ�.
--    ���� ���� : 1) PRIMARY KEY : �ݵ�� �ʼ�
--               2) NOT NULL
--               3) CHECK
--                4) UNIQUE : ���ϰ� 
--                5) FOREIGN KEY 
                
--EX) EMP,DEPT ���̺�
--EMPNO : �ΰ��� �ƴϸ� �ߺ��ɼ����� - PRIMARY KEY�ʿ�
--ENAME : �ΰ��ƴ����� �ߺ������ϴ� - NOT NULL ���� 
--SAL :  0���ٴ� Ŀ���Ѵ� ( ���Ի������ ) �ߺ� �����ϴ� - CHECK�� ���
--
--
--DEPTNO : �μ� ���̺��� �ϳ� , NULL �Ұ���, �ߺ��Ұ��� - DEPTNO�� PRIMARY�� Ű ,FOREIGN KEY
--DNAME : �ߺ� �Ұ� , ���� -UNIQUE
                
desc emp

select * from emp;


--���� ���� ����
--1) �÷����� ���� ��� : 
--�÷��� datatype [CONSTRAINT �����̸�]
--������� �����ϸ� SYS_C���� ������ ���� �ο�

CREATE TABLE DEPT1(
DEPTNO NUMBER(2)PRIMARY KEY,
DNAME VARCHAR(20) UNIQUE,
LOC VARCHAR(20)
);

--2) ���̺� ���� ���ǹ�� 
--�÷��� DATATYPE ,
--�÷��� DATATYPE ,
--CONSTRAINT ����� ��������(�÷���),
--CONSTRAINT ����� ��������(�÷���). . .

CREATE TABLE EMP1(
EMPNO NUMBER(4) CONSTRAINT EMP1_EMPNO_PK PRIMARY KEY,
ENAME VARCHAR2(20) NOT NULL,
SAL NUMBER(7,2),
DEPTNO NUMBER(2),
CONSTRAINT "EMP1_SAL_CK" CHECK (SAL BETWEEN 500 AND 5000),
CONSTRAINT "ENP1_DEPTNO_FK" FOREIGN KEY (DEPTNO)
             REFERENCES DEPT1(DEPTNO)-- ���̺� ����� �������κκ�, ���۷����� �׽�Ʈ�Ŀ� �ۼ�
);

DESC EMP1


INSERT INTO DEPT1
VALUES (1,'ȸ��','�λ�');

UPDATE DEPT1
SET LOC='����'
WHERE DEPTNO=1 AND LOC='�λ�';

INSERT INTO DEPT1
VALUES (1,'����','����'); --> �� ������ ���ÿ� ����� �����߻� , --> DEPTNO�� �⺻Ű(���� �ƴϸ� �ߺ�X)�̹Ƿ� ���� �������� ���� 1�̶� ���� 

INSERT INTO DEPT1
VALUES (2,'����','�λ�');

INSERT INTO EMP1
VALUES (1111,'HONG',3000,2); --> �μ���ȣ�� 2 ��������쿡�� ���� �����߻� 

UPDATE EMP1
SET DEPTNO=1
WHERE ENAME='HONG';

INSERT INTO EMP1
VALUES (1111,'HONG',3000,1);


INSERT INTO EMP1
VALUES(2222,'KILDONG',6000,1);

SELECT * FROM EMP1;


-- DEPT1 ���̺� LOC �÷��� UNIQUE ������ �ο�
ALTER TABLE DEPT1
ADD CONSTRAINT DEPT1_LOC_UQ UNIQUE(LOC);  --�÷�(��������) �߰�

--�������� ��ȸ�� ������ ��ųʸ��� ���� ��ȸ . DATA DICTIONARY

DESC USER_CONSTRAINTS

SELECT CONSTRAINT_NAME, CONSTRAINT_TYPE, TABLE_NAME, SEARCH_CONDITION
FROM USER_CONSTRAINTS
WHERE TABLE_NAME IN ('EMP1','DEPT1');

--�������� ���� 
ALTER TABLE DEPT1
DROP CONSTRAINT DEPT1_LOC_UQ;

