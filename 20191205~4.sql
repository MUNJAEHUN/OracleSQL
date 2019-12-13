------------------------------------------------------------------
--날짜 함수 : SYSDATE   date형식의 데이터를 변경
--종류 : MONTH_BETWEEN,ADD-MONTHS,NEXT_DAY,LAST_DAY 등 -> 날짜와 날짜 연산이 안된다

--오늘
SELECT SYSDATE FROM DUAL;


---입사일, 오늘부터 입사월까지 개월수, 6개월 후, 가장 가까운 금요일, 고용날의한달의 마지막 날
SELECT HIREDATE,
       MONTHS_BETWEEN(SYSDATE,HIREDATE), --숫자형 데이터 출력 
       ADD_MONTHS(HIREDATE,6),
       NEXT_DAY(HIREDATE,'금'),
       LAST_DAY(HIREDATE)
FROM EMP;

-------------------------------------------------------------------
--실습 --이번달의 마지막 일자를 출력--

SELECT LAST_DAY(SYSDATE) FROM DUAL; 

-- 실습 2: 근무개월수가 460개월 이상인 사원의 이름 , 입사일자 , 근무개월수를 출력
--근무 개월수는 월 단위로 표기 (TRUNK)
SELECT ENAME,HIREDATE, tRUNC( MONTHS_BETWEEN(SYSDATE,HIREDATE),0) as mONTHS
FROM EMP
WHERE MONTHS_BETWEEN(SYSDATE,HIREDATE)>=460;

------------------------------------------------------------------
--실습3사원명 , 입사일 , 입사후 6개월 후 금요일
SELECT ENAME, HIREDATE, NEXT_DAY(ADD_MONTHS(HIREDATE,6),'금') AS "6개월 후 금"
FROM EMP;


---------------------------------------------------------
-- 날짜 연산 
SELECT SYSDATE +1 FROM DUAL;  -- 날짜 + 숫자 = 날짜형 반환

SELECT SYSDATE + HIREDATE FROM DUAL; -- 날짜 + 날짜 = 오류 반환

SELECT SYSDATE -'80/01/01' FROM DUAL; -- 날짜 - 날짜 = 오류 반환   invalid number
-- 이유 '' >>문자형이므로 "" 
-------------------------------------------------------
--실습 : 전체 사원들의 이름, 근무년수 조회 ( 근무 년수는 연단위로 표기 ) 



--------------------------접근 1
SELECT ENAME, TRUNC(MONTHS_BETWEEN(SYSDATE,HIREDATE)/12) AS 근무년수
FROM EMP;
---------------------------------------------------------


--------------------------접근 2  날짜 연산 (빼기) 
SELECT ENAME, TRUNC((SYSDATE-HIREDATE)/365) AS 근무년수
FROM EMP;



