스키마 객체 ( 테이블을 제외한 데이터베이스 객체 )

뷰 : 테이블 데이터 표시 , 숨김이 가능 
시퀀스 : 많은 응용 프로그램들이 PRIMARY KEY값으로 고유번호를 사용
        이 고유번호를 처리하는 코드를 작성하거나 자동으로 숫자를 생성하는 시퀀스를 사용하여 고유번호를 생성할수있다.
인덱스 : 데이터 검색 쿼리성능 향상, 
동의어 : 객체에 다른 이름 지정 


뷰 - > 테이블이나 뷰를 기반으로하는 논리적 테이블 
테이블의 데이터를 보거나 변경할수있는 창 
뷰의 기반이 되는 테이블을 기본 테이블이라고 부른다
뷰는 데이터 딕셔너리에 셀렉트문으로 저장된다
목적 : 보안, 엑세스의 단순함 

CREATE VIEW EMPVW30
AS
SELECT EMPNO,ENAME,COMM
FROM EMP
WHERE DEPTNO=30;
--일반계정에게 권한이 없으므로 system 에게 권한을 수여받고 진행 

select * from empvw30;

내가만든 뷰 정보는 data dictionary 에서 확인 가능
desc user_views;

select view_name, text  --> 텍스트로 만들어진 뷰 이름 검색 
from user_views;


--뷰 수정 -> create or replace 구문으로 수정 , alter 는 테이블 생성후 수정, 뷰는 텍스트로 되어있으므로사용불가 

create or replace view empvw30
as
select empno,ename,comm,deptno
from emp
where deptno = 30;


--단순 뷰 복합 뷰 
뷰에서 테이블처럼 사용하려면 dml이 가능해야한다 ->가능한 뷰를 심플 뷰라고 한다.

insert into empvw30
values(1111,'hong',1000,30);

select* from emp;

dml문이 가능하지 않은 경우를 복합 뷰라고 한다 -> join, group by, group function이 사용된 뷰 
예)
create view emp_dept_sal
as
select e.ename,d.dname,s.grade
from emp e, dept d, salgrade s
where e.deptno=d.deptno and e.sal between s.losal and s.hisal; -- 조인,논이퀄조인 으로 삼항조인

select * from emp_dept_sal;

insert into emp_dept_sal
values('hong2','sales',5);  -- 복합뷰로 되어있어 실행되지 않는다.


문제 급여 많은 순서대로 세명의 사원의 사번 이름 급여를 구하세요
-- 접근 1 : 단순히 테이블을 보고 조회
select empno,ename,sal
from emp
where sal between 2970 and 5000 
order by sal desc;

--접근 2 : 세명을 구하는 기준을 세운 뷰로 검색 
select * from emp ; 

rowid : row 마다 부여된 고유 식별자
rownum : 해당 테이블에서 몇번째 인지 알려주는 숫자

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

-------------뷰를 통한 dml 작업을거부할수 있음 ; with read only

create or replace view empvw20
as
select empno,ename,comm,deptno
from emp
where deptno=20
with read only; 

insert into empvw20
values(2222,'HONG2',0,20); -- with read only로 인해 insert 안댐

---- 뷰 제거
--drop view 구문
--뷰를 삭제해도 테이블에는 영향이 없다
--삭제된 뷰를 참조하는 뷰나 응용프로그램은 사용불가능
--생성자나 drop any view권한을 가진 유저만 뷰를 제거할수있음

drop view empvw30;
