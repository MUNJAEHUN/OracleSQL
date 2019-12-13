그림1)
SQL> desc cust
Name                                      Null?    Type
----------------------------------------   -------
CUST_ID                                           NUMBER(6)
CUST_GENDER                                        NUMBER
CUST_NAME                                          VARCHAR2(10)


그림2)
SQL> select * from cust;
CUST_ID   CUST_GENDER    CUST_NAME
-------     -------------     -----------
         1           1        홍길동
         2           0        신사임당
         3           1
         4           0        유관순
         5           1        이순신

1.      그림1처럼 TABLE을 생성 하는 SQL문을 작성하시오.

create table cust(
cust_id number(6),
cust_gender number,
cust_name varchar2(10)
);

desc cust

2.      그림2처럼 데이터를 추가 하는 SQL문을 작성하시오.
alter table cust
modify cust_name varchar2(12);

update cust
set cust_name='신사임당'
where cust_name='신사임';

insert into cust
values(1,1,'홍길동');
insert into cust
values(2,0,'신사임당');
insert into cust
values(4,0,'유관순');
insert into cust
values(5,1,'이순신');


select * from cust order by cust_id asc;


3. CUST 테이블에 CUST_GRADE 컬럼을 추가 하는 SQL문을 작성하시오
--(단 GRADE 는 숫자2자리)

alter table cust
add cust_grade number(2);

select * from cust;



4. CUST_GRADE 컬럼에 TYPE을 숫자 4자리로 변경 시키는 SQL문을 작성하시오

alter table cust 
modify cust_grade number(4);

desc cust;

--
5.      CUST 테이블을 복사하여 CUSTOMER 테이블을 생성

create table customer
as
select * from cust;

select * from customer;

6.    CUST 테이블에  고객테이블 이라는 주석을 달고   올바르게  추가되었는지 데이터 딕셔너리를 조회하세요

comment on table cust
is '고객테이블';

select * from user_tab_comments; 

7.   CUST 테이블의 모든 데이터를 삭제 하는 2가지 방법의 명령을 쓰고 둘의 차이점에 대해 기술하시요
--delete : rollback 수행 가능 
--truncate : rollback 수행불가 

8.  CUST 테이블을 삭제

drop table cust;

9.  휴지통에서 삭제된 테이블의 정보를 찾을수 있다.

show recyclebin

10. 삭제하기 전으로 되돌리려고 한다 어떻게 해야 하나?

flashback table cust
to before drop;