---------------------------------------���� �Լ� 
-----------�ΰ� �̻��� ���̺��� ���̺��� �ʿ��� �ڷḦ �������� ���� ���

SELECT  ENAME,DNAME
FROM EMP,DEPT;                 -- EMP ; 12 , DEPT : 4  Ʃ�� �����Ƿ�  12*4�� ����� ��ȯ = īƼ�� ���δ�Ʈ ��� �ೢ���� ���� 

-- ���̺� ���� ���� ������ �ʿ��� -> �̷��� �Ǹ� �� ���� �ʿ䰡 �������� 

SELECT  ENAME,DNAME
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO; -- > ������ �ɾ� ��Ȯ�� ���� ��ȯ ������.



------����Ŭ 92(�⵵)JOIN
--���� ���� ,������ ���� ,���� ���� ,�ƿ��� ����

------ANSIǥ�� ����
-- �̳�(���� ,������)���� ,�ƿ������� ,ũ�ν����� ,���߷� ����



-----------------------------------���� �� ����� �� �⺻Ű, �ܷ�Ű�� ����Ͽ� �����Ѵ�,


--------------92 ���������� ǥ�� ����----------
SELECT EMP.EMPNO, EMP,ENAME, DEPT.DNAME
FROM EMP,DEPT
WHERE EMP.DEPTNO=DEPT.DEPTNO;

----------- �÷��� ���̺���� �ٿ� ǥ��, 
SELECT E.EMPNO, E,ENAME, D.DNAME
FROM EMP E,DEPT D             -- WHERE�� ����
WHERE EMP.DEPTNO=DEPT.DEPTNO;

---------------------------ANSI EQUL-INNER ���� ����  --- �̰͵� ���������� TRUE�� ��ȯ�ϴ� �ڷ� ��ȯ
SELECT E.ENAME,D.DNAME
FROM EMP E INNER JOIN DEPT D  -- INNER JOIN ~~~ ON
ON E.DEPTNO=D.DEPTNO;

-------���̺����̸��� ����� Ÿ���ο� �ð��� �ҿ�Ǵ°� ������ ��Ī 


--------------------------ANSI NON-EQUL-INEENR ���� ���� 
-------------�����ϱ� ���� ���� -> ���̺��� � �÷��� ������ ���̺� �ø��� ��ġ���� ������, && ���� ����ǿ� "=" �� ������ �����ڰ� ���Ǵ� ��� 
--                              (BETWEEN,AND,IS NULL,NOT NULL,IN,NOT IN)�� ����Ҷ� 

---- EX) ��ü ����� �̸��� �޿������ ��ȸ�ϴ� ��� 

SELECT E.ENAME,S.GRADE
FROM EMP E INNER JOIN SALGRADE S
ON E.SAL BETWEEN S.LOSAL AND S.HISAL;  ---- ����� �������� ������ SALGRADE�� �ִ� LO,HISAL�� ������ ����� �ο��� ��ȯ 

-------------------�ǽ� : ��ü �����, �μ���, �޿������ ��ȸ
SELECT E.ENAME,D.DNAME,S.GRADE
FROM EMP E , SALGRADE S , DEPT D
WHERE (E.SAL BETWEEN S.LOSAL AND S.HISAL) AND  E.DEPTNO=D.DEPTNO;


----------------92 ���� ������-------------
SELECT E.ENAME,S.GRADE
FROM EMP E , SALGRADE S 
WHERE (E.SAL BETWEEN S.LOSAL AND S.HISAL);

-----------------------------------92 ���� ���� 
-- �������ΰ� ������ �ϳ��� ���̺��� ������ �Ͼ�� ����, ���� ���̺� ���� 2���� ALIAS�� ����Ͽ� FROM������ �����ϴ� ���  
-- ���� �ٸ� Ʃ�ó����� �� 
--------------------EX) �� ������� �Ŵ��� �̸��� ��ȸ�϶�.

SELECT * FROM EMP ;


SELECT E1.ENAME,E2.ENAME  ---------E1 =��� . E2= �Ŵ���
FROM EMP E1,EMP E2
WHERE E1.MGR=E2.EMPNO;

----------------------92 �ƿ��� ���� : EQUI ������ ���λ����� ���� �÷��� ���� ������ ��ȯ���� �������� �ƿ��������� ������ 
--                       ��ġ�� ������ ���� �ʾƵ� ���� ���� -> �η� ���� 
--                       ���� ���ǿ��� ���� ������ �����ϴ� ���� ���� ����� ��ȸ�ϱ� ���� ��� 
--                    92 �ƿ��� ���� ������ (+)�� ���ΰ��� ���� �������� ��ġ��Ŵ.  �� ǥ������ ������ ��밡���ϴ�. (+)=0,0=(+) 0 > ǥ���ϰ� �������
--EX)
SELECT DISTINCT(E.DEPTNO),D.DEPTNO,D.DNAME
FROM EMP E , DEPT D 
WHERE E. DEPTNO = D. DEPTNO;  

---> �� ������ �����ҽÿ� DEPTNO�� 40�� ���� ..  << EMP�� 40���� �ٹ��ϴ� ����̾��� ���� 
--> ��� �μ��� �����޶�� �ҽÿ��� ������� �ϹǷ� �̿� �ƿ��� ������ ����Ͽ� ��� �μ� ��ȣ�� ��ȯ�Ѵ�.

--EX2)
--��� ���̺��� ����̸� ��ο� �Ŵ������� ��ȸ

SELECT E.ENAME,C.ENAME
FROM  EMP E,EMP C
WHERE E.MGR = C.EMPNO; ----> �� ��ȯ���� KING�� ������ �����Ƿ� ��� ����� ��ȯ�Ǿ��ٰ� �Ҽ�����.

SELECT E.ENAME,C.ENAME
FROM  EMP E,EMP C
WHERE E.MGR = C.EMPNO(+);---> ���� �ƿ��� ������ ���� KING�� ǥ���� �� �ְ� �ȴ�.
----------


-------------------------ANSI �ƿ��� ���� 
--                       LEFT OUTER JOIN , RIGHT OUTER JOIN , FULL OUTER JOIN 
-- LEFT OUTER JOIN - �̳����� ���(����� Ʈ�簪)�� ǥ��, ����Ű���� �����ִ� ���̺��� ���������� ������Ű������ ǥ�õ������� ���ڵ带 ǥ�� - 3Ʃ�� ��ȯ

SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM EMP E 
    LEFT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

-- RIGHT OUTER JOIN - �̳����� ���(����� Ʈ�簪)�� ǥ��, ����Ű���� �������ִ� ���̺��� ���������� ������Ű������ ǥ�õ������� ���ڵ带 ǥ�� -4Ʃ�� ��ȯ
SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM EMP E 
    RIGHT OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

--  FULL OUTER JOIN - �� ���̺��ο� ���� ���ڵ���� ǥ���ϱ� ���� ���

SELECT DISTINCT(E.DEPTNO),D.DEPTNO
FROM EMP E 
    full OUTER JOIN DEPT D
ON E.DEPTNO=D.DEPTNO;

--------------------------ANSI ���߷� ���� (�ڿ�����) : EQUI,INNER ���ΰ� ����
--        �� ���̺� ������ �̸��� ���� �÷��� ��� ���ν�Ų��. -> ������ �÷��� ���̺� ��Ī�� �ָ� ������ �߻� ( ON ������ ���� ) -> ######ON�� ���� �����ϴ� , �Ⱦ��� ����

--SELECT E.ENAME,D.DNAME
--FROM EMP E NATURAL JOIN DEPT D  -----------> ���� �÷��� ��� ã�ƾ� �ϹǷ� ��Ī ���X ( ON���� �������� )
--ON E.DEPTNO=D.DEPTNO;

SELECT ENAME,DNAME
FROM EMP NATURAL JOIN DEPT;  ----------> �˾Ƽ� ���� ����� �÷��� ã�� ��ȯ

-------------------------USING : ������ �ø��� �ΰ� �̻��� ��� ���     JOIN~USING  EQUI �̳����� �ο� 
SELECT E.ENAME,D.DNAME,DEPTNO
FROM EMP E
    INNER JOIN DEPT D  --> INNER ���� ���� 
USING(DEPTNO);



--------------------------ANSI ũ�ν� ����  
-- ������ �ΰ��� ���� ������� ��� ǥ���ϰ��� �Ҷ�, CARTESIAN PRODUCT ���� ���� �� ��� , �̳�/ �ƿ��� �������� ���� �� �� ���� ��(Ʃ��)���� ��ĥ��  Ȱ�� 

SELECT ENAME
FROM EMP CROSS JOIN DEPT;   ---> 12*4 = 48 

--- ���̺��� ���� ���� �ؼҼ��� �����ϴ� ���ǰ� �Բ� ����ϴ°��� ���� ---> ó�� �ҿ䶧����
--EX
SELECT E.EMPNO,D.DNAME,E.ENAME
FROM EMP E  
    CROSS JOIN DEPT D
WHERE D.DEPTNO=10;

--------