--�ε��� 
--: �����͸� ����� Ʃ�� �˻��ӵ��� ���� ���ִ� ��Ű�� ��ü
--  �����/�ڵ����� �ε����� ���� (����� ����) 
--  �������� ? �÷��� �ε����� ������ ��ü ���̺� �˻��� ���� -> �ӵ� ���� -> �ε����� ������ �ӵ��� ����Ű�� ���� 
--  -> �ᱹ ��ũ i/o �� ���̰��� ���̴�
--  ����Ŭ ������ �ڵ����� ���,��������
--  �ε����� ����,���������� �ε����� ����� ���̺� �������̴�.
--  �������� ����,�����Ҽ������� �⺻ ���̺��̳� �ٸ� �ε����� ������ �����ʴ´�
--  
--  
--  �ε��� ���� ���
--  1. auto : pk,uk (primary,unique)����� �ڵ� ����
--  2. ���� : 1) where ���ǿ��� ���ֻ��
--            2) ���� �������� ���� ���
--            (������)
--            


set timing on

select empno,ename,sal
from emp
where ename='king';

--�ε��� ����
create index idx_emp_ename
on emp(ename);

select empno,ename,sal
from emp
where ename= 'adams';

desc user_indexes

select index_name,index_type,uniqueness
from user_indexes;

--�ε��� ����

drop index idx_emp_ename;

--

-- ������ (sequence) : �ڵ���ȣ������
-- �뵵 - ���ÿ��� pk������ �ߺ����� ���� ���� �ֱ� ���� ���� ��� 
-- 
-- ������ ����
create sequence dept_deptno
 start with 1
 increment by 1
 minvalue 1
 maxvalue 100
 nocache -- ������ �⺻ 20���� �����ȴ�
 nocycle; -- ���� ����Ŭ�����ϰ��� �ƽ����� ������ �ٷ� �̴ϸذ����� ���� 98,99,100->1,2,3,4,  -> 1,2�� �������� ������ �׷��� �����Ŭ 
 
 --������ ���
insert into dept
values (dept_deptno.nextval,'AA','BB'); -- dept no -> 10������ ���� 

select * from dept;

-- ���� ���� ������ ���� Ȯ��

desc user_sequences

-- ������ ����

drop sequence dept_deptno;


----���Ǿ� (synonym)
--: ��ü�� �ٸ� �̸� �ο�, ���� ������ �뵵
--1. �ٸ������� ������ ���̺��� ���� ��������
--2. �� ��ü �̸��� ª�� ����� ��������
--���Ǿ�� ������ �ʿ�

create synonym ex1
for dept ;


drop synonym ex1;

------------------dcl  : ������ �����
����Ŭ db ������� �ܰ� 

sys : ������
system : ������ (dba)
scott���� ��ǥ�Ǵ� ��������(���������) -- ���� ���Ѿ��� ���� 

