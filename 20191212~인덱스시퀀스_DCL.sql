--인덱스 
--: 포인터를 사용해 튜플 검색속도를 높일 수있는 스키마 객체
--  명시적/자동으로 인덱스를 생성 (명시적 권장) 
--  오ㅐ쓰냐 ? 컬럼에 인덱스가 없으면 전체 테이블 검색을 수행 -> 속도 저하 -> 인덱스를 접근해 속도를 향상시키기 위함 
--  -> 결국 디스크 i/o 를 줄이고자 함이다
--  오라클 서버가 자동으로 사용,유지관리
--  인덱스는 논리적,물리적으로 인덱스의 대상인 테이블에 독립적이다.
--  언제든지 생성,삭제할수있으며 기본 테이블이나 다른 인덱스에 영향을 주지않는다
--  
--  
--  인덱스 생성 방법
--  1. auto : pk,uk (primary,unique)선언시 자동 생성
--  2. 수동 : 1) where 조건에서 자주사용
--            2) 조인 조건으로 자주 사용
--            (권장사양)
--            


set timing on

select empno,ename,sal
from emp
where ename='king';

--인덱스 생성
create index idx_emp_ename
on emp(ename);

select empno,ename,sal
from emp
where ename= 'adams';

desc user_indexes

select index_name,index_type,uniqueness
from user_indexes;

--인덱스 변경

drop index idx_emp_ename;

--

-- 시퀀스 (sequence) : 자동번호생성기
-- 용도 - 어플에서 pk값으로 중복되지 않은 값을 주기 위해 많이 사용 
-- 
-- 시퀀스 생성
create sequence dept_deptno
 start with 1
 increment by 1
 minvalue 1
 maxvalue 100
 nocache -- 생략시 기본 20개가 생성된다
 nocycle; -- 권장 싸이클상태일경우는 맥스값을 찍은후 바로 미니멈값으로 돈다 98,99,100->1,2,3,4,  -> 1,2에 값있으면 못들어간다 그래서 논사이클 
 
 --시퀀스 사용
insert into dept
values (dept_deptno.nextval,'AA','BB'); -- dept no -> 10번에서 에러 

select * from dept;

-- 내가 만든 시퀀스 정보 확인

desc user_sequences

-- 시퀀스 삭제

drop sequence dept_deptno;


----동의어 (synonym)
--: 객체에 다른 이름 부여, 쉬운 엑세스 용도
--1. 다른유저가 소유한 테이블을 쉽게 참조가능
--2. 긴 객체 이름을 짧게 만들어 쓸수있음
--동의어는 권한이 필요

create synonym ex1
for dept ;


drop synonym ex1;

------------------dcl  : 데이터 제어어
오라클 db 사용자의 단계 

sys : 소유자
system : 관리자 (dba)
scott으로 대표되는 엔드유저(최종사용자) -- 가장 권한없는 유저 

