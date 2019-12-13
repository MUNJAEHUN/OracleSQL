------------------------------------------------------------------
--��¥ �Լ� : SYSDATE   date������ �����͸� ����
--���� : MONTH_BETWEEN,ADD-MONTHS,NEXT_DAY,LAST_DAY �� -> ��¥�� ��¥ ������ �ȵȴ�

--����
SELECT SYSDATE FROM DUAL;


---�Ի���, ���ú��� �Ի������ ������, 6���� ��, ���� ����� �ݿ���, ��볯���Ѵ��� ������ ��
SELECT HIREDATE,
       MONTHS_BETWEEN(SYSDATE,HIREDATE), --������ ������ ��� 
       ADD_MONTHS(HIREDATE,6),
       NEXT_DAY(HIREDATE,'��'),
       LAST_DAY(HIREDATE)
FROM EMP;

-------------------------------------------------------------------
--�ǽ� --�̹����� ������ ���ڸ� ���--

SELECT LAST_DAY(SYSDATE) FROM DUAL; 

-- �ǽ� 2: �ٹ��������� 460���� �̻��� ����� �̸� , �Ի����� , �ٹ��������� ���
--�ٹ� �������� �� ������ ǥ�� (TRUNK)
SELECT ENAME,HIREDATE, tRUNC( MONTHS_BETWEEN(SYSDATE,HIREDATE),0) as mONTHS
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE,HIREDATE)>=460;

------------------------------------------------------------------
--�ǽ�3����� , �Ի��� , �Ի��� 6���� �� �ݿ���
SELECT ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE,6),'��') AS "6���� �� ��"
FROM EMP;


---------------------------------------------------------
-- ��¥ ���� 
SELECT SYSDATE +1 FROM DUAL;  -- ��¥ + ���� = ��¥�� ��ȯ

SELECT SYSDATE + HIREDATE FROM DUAL; -- ��¥ + ��¥ = ���� ��ȯ

SELECT SYSDATE -'80/01/01' FROM DUAL; -- ��¥ - ��¥ = ���� ��ȯ   invalid number
-- ���� '' >>�������̹Ƿ� "" 
-------------------------------------------------------
--�ǽ� : ��ü ������� �̸�, �ٹ���� ��ȸ ( �ٹ� ����� �������� ǥ�� ) 



--------------------------���� 1
SELECT ENAME, TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) AS �ٹ����
FROM EMP;
---------------------------------------------------------


--------------------------���� 2  ��¥ ���� (����) 
SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/365) AS �ٹ����
FROM EMP;



