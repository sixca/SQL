/*
 * Q.1-1 
 * (1) 논리 설계
 * (2) 데이터 모델링
 * 
 * Q.1-2 
 * (1) E-R 모델
 * (2) E-R 모델
 * (3) Entity
 * 
 * Q.1-3
 * (1) E-R Diagram
 * (2) 관계
 * 
 * Q.1-4
 * (1) 카디널리티(Cardinality)
 * (2) 옵셔널리티(Optionality)
 * 
 * Q.1-5
 * (1) 스키마
 * (2) 테이블
 * 
 * Q.1-6
 * (1) Table
 * (2) Index
 * (3) Sequence
 * 
 * */

-- 실습과제 1
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

-- 실습과제 2
SELECT
	*
FROM
	EMP
WHERE
	COMM IS NULL  -- NULL의 비교는  IS NULL, IS NOT NULL로만!
	AND SAL > 0
;

SELECT
	*
FROM
	EMP
WHERE
	MGR IS NULL
	AND COMM IS NULL
;

-- 실습과제 3
SELECT
	*
FROM
	EMP
WHERE
	ENAME IN ('SMITH', 'JONES', 'ADAMS', 'JAMES', 'MILLER')
;

SELECT
	*
FROM
	EMP e
WHERE
	ENAME LIKE '%S'
;

SELECT
	*
FROM
	EMP
WHERE
	JOB = 'SALESMAN'
	AND DEPTNO = 30
;

SELECT
	*
FROM
	EMP
WHERE
	DEPTNO IN (20, 30)
	AND SAL > 2000
;

SELECT
	*
FROM
	EMP
WHERE
	DEPTNO = 20
	AND SAL > 2000
UNION                -- 합집합
SELECT
	*
FROM
	EMP
WHERE
	DEPTNO = 30
	AND SAL > 2000
;

SELECT
	*
FROM
	EMP
WHERE
	COMM IS NULL
	AND MGR IS NOT NULL
	AND JOB IN ('MANAGER', 'CLERK')
	AND SUBSTR(ENAME, 2, 1) != 'L'      --ENAME 2번째 첫글자가 'L'과 같지 않음
; 

-- 실습과제 4
SELECT
	EMPNO,
	ENAME
	,
	SUBSTR(EMPNO, 1, 2)|| LPAD('*', 2, '*') AS "EMPNO 마스킹 처리"  --앞 두자리 || *마스킹 2개
	,
	SUBSTR(ENAME, 1, 1)|| LPAD('*', 5, '*') AS "ENAME 마스킹 처리"  --앞 두자리 || *마스킹 5개
FROM
	EMP
WHERE
	LENGTH (ENAME) >= 6
; 

SELECT
	EMPNO,
	ENAME
	,
	RPAD(SUBSTR(EMPNO, 1, 2), LENGTH(EMPNO), '*') AS "EMPNO 마스킹 처리"  --앞 두자리 이후 마스킹
	,
	RPAD(SUBSTR(ENAME, 1, 1), LENGTH(ENAME), '*') AS "ENAME 마스킹 처리"  --앞 한자리 이후 마스킹
FROM
	EMP
WHERE
	LENGTH (ENAME) >= 6
;

SELECT
	EMPNO,
	ENAME,
	JOB,
	SAL,
	SAL / 20 AS "DAY_PER_SAL",
	SAL / 20 / 8 AS "HOUR_PER_SAL"
FROM
	EMP
WHERE
	JOB IN ('SALESMAN', 'CLERK')
ORDER BY
	SAL
;

-- 실습과제 5
SELECT
	EMPNO,
	ENAME,
	TO_CHAR(HIREDATE, 'YYYY/MM/DD'),
	COALESCE (TO_CHAR(COMM),
	'N/A') 
	,
	TO_CHAR (NEXT_DAY(ADD_MONTHS(HIREDATE, 3), '월요일'),  --'MONDAY' 불가, '월요일' 성공
	'YYYY/MM/DD') AS "정직원이 된 날"
FROM
	EMP
;

-- 실습과제 6
SELECT
	EMPNO,
	ENAME,
	MGR 
	,
	CASE
		WHEN MGR IS NULL THEN '0000'
		WHEN SUBSTR(MGR, 1, 2)= 75 THEN '5555'
		WHEN SUBSTR(MGR, 1, 2)= 76 THEN '6666'
		WHEN SUBSTR(MGR, 1, 2)= 77 THEN '7777'
		WHEN SUBSTR(MGR, 1, 2)= 78 THEN '8888'
		ELSE '9999'
	END AS CHG_MGR
FROM
	EMP
;
-- CASE문을 대체할 DECODE문 활용 실패..


