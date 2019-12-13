-- 뷰 객체를 사용할수있도록 scott 계정에 권한허가

grant create view to scott;


SELECT *

FROM NLS_DATABASE_PARAMETERS

WHERE PARAMETER = 'NLS_CHARACTERSET';



--동의어 객체 생성 허가
grant create synonym  to scott;