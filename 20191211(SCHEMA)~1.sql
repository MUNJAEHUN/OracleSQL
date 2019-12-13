��Ű�� ��ü ( ���̺��� ������ �����ͺ��̽� ��ü )

�� : ���̺� ������ ǥ�� , ������ ���� 
������ : ���� ���� ���α׷����� PRIMARY KEY������ ������ȣ�� ���
        �� ������ȣ�� ó���ϴ� �ڵ带 �ۼ��ϰų� �ڵ����� ���ڸ� �����ϴ� �������� ����Ͽ� ������ȣ�� �����Ҽ��ִ�.
�ε��� : ������ �˻� �������� ���, 
���Ǿ� : ��ü�� �ٸ� �̸� ���� 


�� - > ���̺��̳� �並 ��������ϴ� ���� ���̺� 
���̺��� �����͸� ���ų� �����Ҽ��ִ� â 
���� ����� �Ǵ� ���̺��� �⺻ ���̺��̶�� �θ���
��� ������ ��ųʸ��� ����Ʈ������ ����ȴ�
���� : ����, �������� �ܼ��� 

CREATE VIEW EMPVW30
AS
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE DEPTNO=30;
--�Ϲݰ������� ������ �����Ƿ� system ���� ������ �����ް� ���� 

select * from empvw30;

�������� �� ������ data dictionary ���� Ȯ�� ����
desc user_views;

select view_name, text  --> �ؽ�Ʈ�� ������� �� �̸� �˻� 
from user_views;


--�� ���� -> create or replace �������� ���� , alter �� ���̺� ������ ����, ��� �ؽ�Ʈ�� �Ǿ������Ƿλ��Ұ� 

create or replace view empvw30
as
select empno,ename,comm,deptno
from emp
where deptno = 30;


--�ܼ� �� ���� �� 
�信�� ���̺�ó�� ����Ϸ��� dml�� �����ؾ��Ѵ� ->������ �並 ���� ���� �Ѵ�.

insert into empvw30
values(1111,'hong',1000,30);

select* from emp;

dml���� �������� ���� ��츦 ���� ���� �Ѵ� -> join, group by, group function�� ���� �� 
��)
create view emp_dept_sal
as
select e.ename,d.dname,s.grade
from emp e, dept d, salgrade s
where e.deptno=d.deptno and e.sal between s.losal and s.hisal; -- ����,���������� ���� ��������

select * from emp_dept_sal;

insert into emp_dept_sal
values('hong2','sales',5);  -- ���պ�� �Ǿ��־� ������� �ʴ´�.


���� �޿� ���� ������� ������ ����� ��� �̸� �޿��� ���ϼ���
-- ���� 1 : �ܼ��� ���̺��� ���� ��ȸ
select empno,ename,sal
from emp
where sal between 2970 and 5000 
order by sal desc;

--���� 2 : ������ ���ϴ� ������ ���� ��� �˻� 
select * from emp ; 

rowid : row ���� �ο��� ���� �ĺ���
rownum : �ش� ���̺��� ���° ���� �˷��ִ� ����

create view e3
as
select empno,ename,sal
from emp
order by sal desc;

select rownum,empno,ename,sal
from e3
where rownum<=3 and sal is not null ;

select rowid ,rownum, empno from emp;

select empno,ename,sal
from emp
order by sal desc;

-------------�並 ���� dml �۾����ź��Ҽ� ���� ; with read only

create or replace view empvw20
as
select empno,ename,comm,deptno
from emp
where deptno=20
with read only; 

insert into empvw20
values(2222,'HONG2',0,20); -- with read only�� ���� insert �ȴ�

---- �� ����
--drop view ����
--�並 �����ص� ���̺��� ������ ����
--������ �並 �����ϴ� �䳪 �������α׷��� ���Ұ���
--�����ڳ� drop any view������ ���� ������ �並 �����Ҽ�����

drop view empvw30;
