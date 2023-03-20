
/*0320 CLASS*/

SELECT
	*
FROM
	EMP a
WHERE
	COMM  IS NULL
	AND SAL > 0
;

SELECT
	a.EMPNO ,
	a.ENAME ,
	a.MGR ,
	a.SAL ,
	a.COMM
FROM
	EMP a
WHERE
	a.MGR IS NULL
	AND a.comm IS NULL;


SELECT * FROM EMP
WHERE ENAME LIKE '%S';

SELECT * FROM EMP
WHERE JOB = 'SALESMAN' AND DEPTNO = 30;

SELECT
	*
FROM
	EMP
WHERE
	DEPTNO IN (20, 30)
	AND SAL > 2000
;           --IN 사용

--4번
SELECT * FROM EMP
WHERE DEPTNO = 20 AND SAL > 2000
UNION
SELECT * FROM EMP
WHERE DEPTNO = 30 AND SAL > 2000
;           -- UNION 합집합 사용

-- 5번
SELECT
	*
FROM
	EMP e
WHERE
	COMM IS NULL
	AND MGR IS NOT NULL
	AND JOB IN ('CLERK', 'MANAGER')
	AND ENAME NOT LIKE '_L%';


SELECT
	EMPNO,
	ENAME
,
	RPAD(SUBSTR(EMPNO, 1, 2), 4, '*') AS "EMPNO 마스킹 처리"
	-- RPAD(SUBSTR(기준문자열, 몇번째, 몇개,), 총 문자열 수, '*')
,
	RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS "ENAME 마스킹 처리"
FROM
	EMP
WHERE
	LENGTH (ENAME) >= 6;

SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL
,
	SAL / 20 AS DAY_PER_SAL
,
	SAL / 20 / 8 AS HOUR_PER_SAL
FROM
	EMP
WHERE
	JOB IN('SALESMAN', 'CLERK')
ORDER BY
	SAL;


SELECT
	EMPNO AS EMPLOYEE_NO
	,
	ENAME AS EMPLOYEE_NAME
	,
	JOB,
	MGR AS MANAGER
	,
	HIREDATE
	,
	SAL AS SALARY
	,
	COMM AS COMISSION
	,
	DEPTNO AS DEPARTMENT_NO
FROM
	EMP
ORDER BY 
	DEPTNO DESC
	,
	ENAME ASC
;


-- SQL 함수 보기
SELECT
	*
FROM
	V$SQLFN_METADATA;
-- SQL 특정함수 조회
SELECT
	*
FROM
	V$SQLFN_METADATA V
WHERE
	V.NAME = 'NVL';

/* 문자열 함수
 * UPPER() 대문자 변환
 * LOWER() 소문자 변환
 * LENGTH() 문자열 길이
 * 
 * [SAMPLE]
 * SELECT
	ENAME,
	UPPER(ENAME) AS TO_UPPER_NAME, 
	LOWER(ENAME) AS TO_LOWER_NAME,
	LENGTH (ENAME) AS LENGTH_NAMTE
	FROM EMP;
 */
--문자열 함수가 왜 중요할까? 월자성 보장되는 1차정규형 테이블에서 대소문자 구분없이 문자로만 찾을 수 있다
 SELECT
	*
FROM
	EMP
WHERE
	UPPER(ENAME) = UPPER('SCOtt');
 
-- TRIM : 공란 제거  
SELECT TRIM('   ____ORACLE _ _ _   ') 
FROM DUAL;

--CONCAT 문자열 연결(더하기)
SELECT
	EMPNO,
	ENAME,
	CONCAT(EMPNO, ENAME),
	CONCAT(EMPNO, ' ')
FROM
	EMP
WHERE
	ENAME = UPPER('SmiTh') 
;

-- REPLACE 문자열 교체  :: '-'을 지운다, 공백을 지운다, 글자를 바꾼다
-- 주요 예시 : 전하번호, 이메일, 집주소 등등
SELECT
	'010-1234-5678' AS MOBILE_PHONE
,
	REPLACE ('010-1234-5678',
	'-',
	'') AS REPLACED_NUMBER
FROM
	DUAL
;

-- LPAD, RPAD, 문자열을 채우기하는 함수  :: 뭘로 채울지 생략하면 공백을 채움
SELECT
	LPAD('ORA_1234_XE', 20) AS LPAD_20
,
	RPAD('ORA_1234_XE', 20) AS RPAD_29
FROM
	DUAL
;

SELECT
	*
FROM
	EMP
WHERE
	E.EMPNO >= :INPUT_NO
	-- HOST VARABLE   [TIP]
;

SELECT
	'ORACLE',
	RPAD('ORACLE', 10, '#') AS LPAD_1
,
	RPAD('ORACLE', 10, '*') AS RPAD_1
,
	LPAD('ORACLE', 10) AS LPAD_2
,
	RPAD('ORACLE', 10) AS RPAD_2
FROM
	DUAL;

SELECT
	RPAD('880520-', 14, '*') AS RPAD_JMNO
,
	RPAD('010-1234-', 13, '*') AS RPAD_PHONE
FROM
	DUAL;

-- NUMBER 숫자를 다루는 함수들
-- 정수(INTEGER), 부동소소(FLOAT) - 소수점이 있는 숫자
-- 부동소수의 경우, 소수점 이하 정밀도(PRECISION) 차이가 발생
-- pi ~ 3.142457....39339 (15자리 이하 소수 )
-- ROUND, TRUNC, CEIL, MOD, POWER, ABS, SIGN, REMAINDER

SELECT
	1234.5678
,
	ROUND(1234.5678) AS ROUND
	-- ROUND는 해당 위치에서 반올림
,
	ROUND(1234.5678, 1) AS R_PLUS1
,
	ROUND(1234.5678, -1) AS R_MINUS1
,
	TRUNC(1234.5678) AS TRUNC
	-- TRUNC는 해당 위치에서 0으로 잘라냄
,
	TRUNC(1234.5678, 1) AS T_PLUS1
,
	CEIL(1234.5678) AS CEIL
	--CEIL, FLOOR 는 값을 정수로 변환인데 CEIL은 위로, FLOOR는 아래로
,
	FLOOR(1234.5678) AS FLOOR
FROM
	DUAL;

SELECT
	MOD(15,
	6),
	MOD(10,
	2),
	MOD(11,
	2)
FROM
	DUAL;   -- 나머지 값 

SELECT
	POWER (3,
	2),
	POWER(-3, 3)
FROM
	DUAL;    -- n승
	
SELECT
	ABS(-100),
	ABS(100),
	ABS(0)
FROM
	DUAL; -- 절대값

/* DATE 날짜를 다루는 함수들
 * 
 * 2023, 04/01 MINUS 1 DAY --> MARCH, 01, 2023
 * 
 * 날짜를 표현하는 일련번호 숫자가 존재
 * 
 * */
SELECT SYSDATE AS NOW
, SYSDATE - 1 AS YESTERDAY
, SYSDATE + 10 AS TEN_DAYS_FROM_NOW
FROM DUAL;

-- :MONTH 를 CTRL+ENTER해서 값을 선택하세요 (HOST VARIABLE 기능)
SELECT ADD_MONTHS(SYSDATE, :MONTH)
FROM DUAL;

SELECT
	ENAME,
	HIREDATE,
	ADD_MONTHS(HIREDATE, 12 * 20) AS WORK10YEAR
FROM
	EMP;

-- 입사일로부터 40년 이상 근속한 직원을 구한다면?
SELECT
	EMPNO,
	ENAME,
	HIREDATE,
	SYSDATE
FROM
	EMP
WHERE
	ADD_MONTHS(HIREDATE, 12 * 40)>SYSDATE;


SELECT
	ENAME
,
	HIREDATE
,
	MONTHS_BETWEEN(SYSDATE, HIREDATE)/
	-- 입력날짜 사이의 개월수 계산

	
	-- 입사 년차 구하기 :: 보고할 때는 YESR3처럼 깔끔하게 만들어서 올려야겠지
SELECT
	ENAME,
	HIREDATE,
	SYSDATE,
	MONTHS_BETWEEN(HIREDATE, SYSDATE)/ 12 AS YEAR1,
	MONTHS_BETWEEN(SYSDATE, HIREDATE)/ 12 AS YEAR2,
	TRUNC(MONTHS_BETWEEN(SYSDATE, HIREDATE)/ 12) AS YEAR3
FROM
	EMP;

--다음 날짜(다음해, 다음월, 다음일, 다음 요일)
SELECT SYSDATE, NEXT_DAY(SYSDATE, '월요일'), LAST_DAY(SYSDATE) FROM DUAL;     --국가별 설정이 달라서 ,, 'MONDAY'가 안 먹히네용

-- 추출
SELECT
	ENAME
,
	EXTRACT (YEAR
FROM
	HIREDATE) AS Y
,
	EXTRACT (MONTH
FROM
	HIREDATE) AS M
,
	EXTRACT (DAY
FROM
	HIREDATE) AS D
FROM
	EMP;

--날짜에 적용하는 FORMAT
SELECT
	SYSDATE,
	ROUND(SYSDATE, 'CC') AS FORMAT_CC,
	-- 네자리 연도 끝 두자리를 기준으로 ROUND
	ROUND(SYSDATE, 'YYYY') AS FORMAT_YYYY,
	-- 7월 1일 기준으로 반올림
	ROUND(SYSDATE, 'Q') AS FORMAT_Q,
	-- 각 분기의 두번째 달의 16일 기준 반올림
	ROUND(SYSDATE, 'DDD') AS FORMAT_DDD,
	-- 해당 일의 정오를 기준으로 반올림(12:00:00)
	ROUND(SYSDATE, 'HH') AS FORMAT_HH
	-- HH, HH12, HH24 해당 일의 시간을 기준으로 반올림
FROM
	DUAL;


/* 
 * 형 변환(Cast, up-cast, down-cast)      & 암묵적인 형변환, 명시적인 형변화도 있어요
 * down-cast : 큰 수를 담는 데이터형에서 작은 수르 담는 데이터 형으로 명시적 변환
 * 예시 : 1234.3456 --> 234.3 (데이터가 짤림)
 */

SELECT * 
FROM emp
WHERE DEPTNO = '20'      
;
-- 문자열로 조회해도 숫자가 조회되지요 (암묵적인 형 변환)
SELECT * 
FROM emp
WHERE DEPTNO = 20      
;
-- 만약 데이터가 많은 경우에는? 형 변환으로 인한 성능저하 발생!
-- 암묵적 형 변환의 우선순위  :: DATE, INTERVAL -> NUMBER -> CHAR, VARCHAR2, CLOB -> 기타 // 162P

--명시적 형 변환

SELECT TO_CHAR(SYSDATE, 'YYYY/MM/DD') FROM dual;    -- 형 변환 날짜를 문자열로 변환
SELECT TO_CHAR(SYSDATE, 'DD HH24:MI:SS') FROM dual; 

--날짜 포맷
SELECT SYSDATE 
	, TO_CHAR(SYSDATE, 'mm') AS mm          --03
	, TO_CHAR(SYSDATE, 'mon') AS mon        --3월
	, TO_CHAR(SYSDATE, 'month') AS MONTH    --3월
	, TO_CHAR(SYSDATE, 'dd') AS dd          --20
	, TO_CHAR(SYSDATE, 'dy') AS dy          --월
	, TO_CHAR(SYSDATE, 'day') AS DAY        --월요일
FROM dual;	
	
--날짜 포맷 국가별 표기
SELECT SYSDATE
	,TO_CHAR(SYSDATE, 'MM') AS MM
	,TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = KOREAN') AS MON_KOR
	,TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = JAPANESE') AS MON_JPN
	,TO_CHAR(SYSDATE, 'MON', 'NLS_DATE_LANGUAGE = ENGLISH') AS MON_ENG
	,TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = KOREAN') AS MONTH_KOR
	,TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = JAPANESE') AS MONTH_JPN
	,TO_CHAR(SYSDATE, 'MONTH', 'NLS_DATE_LANGUAGE = ENGLISH') AS MONTH_ENG
FROM DUAL;


-- TO_NUMBER(입력문자, 필요한 숫자포맷::최대 자릿수)
SELECT TO_NUMBER('3,000', '999,999') - TO_NUMBER('1,100', '999,999')
FROM DUAL;
SELECT TO_NUMBER('1,000,000', '999,999,999') - TO_NUMBER('100,000', '999,999')
FROM DUAL;

-- TO_DATE(날짜 문자열, 필요한 날짜 포맷)
SELECT TO_DATE('20230320', 'YYYY/MM/DD') AS YMD FROM DUAL; 
-- 날짜 포맷 RR과 YY 값 비교
SELECT TO_DATE('880520', 'YY/MM/DD') AS YMD FROM DUAL;  -- 2088년으로 출력 
SELECT TO_DATE('880520', 'RR/MM/DD') AS YMD FROM DUAL;  -- 1988년으로 성공

-- 문자열 날짜(STRING)을 날짜(DATE)로 형 변환 후 비교
SELECT * FROM EMP WHERE HIREDATE > TO_DATE('19810710', 'YYYY/MM/DD');

/*
 * NULL값 = 알 수 없는 값, 계산이 불가능한 값
 * NULL값 비교는 IS NULL <> IS NOT NULL 
 * 
 * NVL(입력값, NULL인 경우 대체할 값)
 * NVL2(입력값, NULL이 있으면 대체할 값, NULL이 없으면 대체할 값)
 * NULL 처리 함수 :: NVL, NVL2 (***NULL값은 중요합니다***) // 통계의 N/A와 비슷.. NOT NUMBER
 */
SELECT EMPNO, ENAME, COMM
	, NVL2(COMM,'O','X')
	, NVL2(COMM, SAL*12+COMM, SAL*12) AS ANNUAL
FROM EMP;
--NVL2는 실무에서 잘 안 쓴다. 왜냐면?
SELECT EMPNO
	, SAL*12 + NVL(COMM, 0) AS SAL2
	FROM EMP;
-- 이렇게 NVL을 가지고 명확하게 표현할 수 있기 때문


-- DECODE와 CASE   :: 같은 목적의 함수
--DECODE (입력 컬럼값,                      -- 값별로 명확하게 보이는 것이 장점 (직관적)
--	'비교값1', 처리1,					   -- DECODE로 실무에서는 많이 처리함. 
--	'비교값2', 처리2,
--	'비교값3', 처리3,) AS 별칭
--
--CASE 컬럼값								-- 일부만 처리값을 주고 나머지(ELSE)를 묶어서 처리 가능 
--	WHEN '비교값1' THEN 처리1
--	WHEN '비교값2' THEN 처리2
--	WHEN '비교값3' THEN 처리3
--	ELSE
--	END AS 별칭


