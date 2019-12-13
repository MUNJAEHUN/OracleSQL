�׸�1)
SQL> desc cust
Name                                      Null?    Type
----------------------------------------   -------
CUST_ID                                           NUMBER(6)
CUST_GENDER                                        NUMBER
CUST_NAME                                          VARCHAR2(10)


�׸�2)
SQL> select * from cust;
CUST_ID   CUST_GENDER    CUST_NAME
-------     -------------     -----------
         1           1        ȫ�浿
         2           0        �Ż��Ӵ�
         3           1
         4           0        ������
         5           1        �̼���

1.      �׸�1ó�� TABLE�� ���� �ϴ� SQL���� �ۼ��Ͻÿ�.

create table cust(
cust_id number(6),
cust_gender number,
cust_name varchar2(10)
);

desc cust

2.      �׸�2ó�� �����͸� �߰� �ϴ� SQL���� �ۼ��Ͻÿ�.
alter table cust
modify cust_name varchar2(12);

update cust
set cust_name='�Ż��Ӵ�'
where cust_name='�Ż���';

insert into cust
values(1,1,'ȫ�浿');
insert into cust
values(2,0,'�Ż��Ӵ�');
insert into cust
values(4,0,'������');
insert into cust
values(5,1,'�̼���');


select * from cust order by cust_id asc;


3. CUST ���̺� CUST_GRADE �÷��� �߰� �ϴ� SQL���� �ۼ��Ͻÿ�
--(�� GRADE �� ����2�ڸ�)

alter table cust
add cust_grade number(2);

select * from cust;



4. CUST_GRADE �÷��� TYPE�� ���� 4�ڸ��� ���� ��Ű�� SQL���� �ۼ��Ͻÿ�

alter table cust 
modify cust_grade number(4);

desc cust;

--
5.      CUST ���̺��� �����Ͽ� CUSTOMER ���̺��� ����

create table customer
as
select * from cust;

select * from customer;

6.    CUST ���̺�  �����̺� �̶�� �ּ��� �ް�   �ùٸ���  �߰��Ǿ����� ������ ��ųʸ��� ��ȸ�ϼ���

comment on table cust
is '�����̺�';

select * from user_tab_comments; 

7.   CUST ���̺��� ��� �����͸� ���� �ϴ� 2���� ����� ����� ���� ���� �������� ���� ����Ͻÿ�
--delete : rollback ���� ���� 
--truncate : rollback ����Ұ� 

8.  CUST ���̺��� ����

drop table cust;

9.  �����뿡�� ������ ���̺��� ������ ã���� �ִ�.

show recyclebin

10. �����ϱ� ������ �ǵ������� �Ѵ� ��� �ؾ� �ϳ�?

flashback table cust
to before drop;