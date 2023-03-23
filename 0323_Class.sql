/*0323 CLASS*/

--오라클 성능 관련 동적 뷰  :: v(뷰) $(커넥트)
SELECT *
FROM v$version
;  -- oracle DB 버전정보

-- sys, system, sysdba 계정에서 사용 가능
SELECT *
FROM v$option
;

SELECT *
FROM v$option
WHERE value='TRUE'
;

SELECT *
FROM v$database
;

SELECT *
FROM v$instance
;  -- DB에 있는 instance를 보여줌

SELECT *
FROM v$session
; -- 현재 활성화된 모든 세션의 정보를 조회  :: SID는 세션의 식별자

SELECT *
FROM v$parameter
; -- 통계에서 parameter는 모수. 매개변수.. 파라미터들을 조회


--------------TCL 복습-------
CREATE TABLE DEPT_TCL
AS (SELECT * FROM DEPT)
;

SELECT * FROM DEPT_TCL
;

INSERT INTO DEPT_TCL
VALUES(50, 'DATABASE', 'SEOUL')
;

UPDATE DEPT_TCL SET LOC = 'BUSAN'
WHERE  DEPTNO = 50
;

DELETE FROM DEPT_TCL
WHERE DNAME = 'DATABASE'
;

ROLLBACK;
-----------------------------

/*
 * COMMIT 처리 - 실행완료(롤백불가)
 * */

--데이터 입력, 갱신, 삭제 후 COMMIT 처리
INSERT INTO DEPT_TCL VALUES(50, 'NETWORK', 'SEOUL');
INSERT INTO DEPT_TCL VALUES(20, 'RESEARCH', 'INCHEON');
INSERT INTO DEPT_TCL VALUES(30, 'SALES', 'GWANGJU');
INSERT INTO DEPT_TCL VALUES(40, 'ACCOUNTING', 'DALLAS');

UPDATE DEPT_TCL SET LOC = 'BUSAN' WHERE DEPTNO = 20;

DELETE FROM DEPT_TCL WHERE DEPTNO = 40;

SELECT * FROM DEPT_TCL;

COMMIT;

SELECT * FROM DEPT_TCL;

DELETE FROM DEPT_TCL WHERE DEPTNO = 50;

SELECT * FROM DEPT_TCL;

COMMIT;
ROLLBACK;  -- 뒤늦게 취소 불가!
-- UPDATE로 하면 됨 

-- LOCK : 작업 중인 데이터가 있는 경우 트랜잭션 완료(COMMIT, ROLLBACK) 전까지 잠김 상태
-- 다중 세션에서 UPDATE, DELETE 실행 시 영향 받는 해당 행은 LOCK 상태로 변경    :: *세션 = DBMS에 접속하여 사용 중인 연결 정보

SELECT * FROM DEPT_TCL; 


/*
 * LOCK 테스트
 * 
 * 동일한 계정으로 DBEAVER 세션과 SQL*PLUS 세션을 열어 데이터를 수정하는 동시작업을 수행
 * 극단적인 케이스;;
 */

SELECT * FROM DEPT_TCL;

UPDATE DEPT_TCL SET LOC = 'SEOUL'
WHERE DEPTNO = 30;

SELECT * FROM DEPT_TCL;
COMMIT;

--NO ACTION(UPDATE 트랜잭션 완료 전)   >> 이 상태에서는 CMD에서 테이블 조회를 해도 조회되지 않는다. 그런데;; 오라클에서는 AUTO COMMIT이라 바로 반영이 되고,,
-- CMD에서는 오토커밋이 안 되니, COMMIT 전 작업들은 DBEAVER에서 조회가 안 된다.

-- CMD에서 UPDATE 실행함. 그렇지만 DBEAVER에서는 조회가 되지 않는다. 부서30에 LOC을 'DAEGU'로 바꿈
SELECT * FROM DEPT_TCL; -- SQL*PLUS에서 실행중인 직원의 UPDATE 시도를 막고 있는 상황을 모르고 있을 수 있는 상황.

/* SQL*PLUS(CMD)에서 조회되는 내용
 SQL> SELECT * FROM DEPT_TCL;

    DEPTNO DNAME                        LOC
---------- ---------------------------- --------------------------
        10 ACCOUNTING                   NEW YORK
        30 SALES                        DAEGU
        20 RESEARCH                     BUSAN
 */

-- SQL*PLUS(CMD)에서 COMMIT을 하면  >> COMMIT COMPLETE. 라고 뜸
SELECT * FROM DEPT_TCL; -- UPDATE 사항이 반영된다.


/*
 * TUNING 기초 : 자동차 튜닝과 같이 DB 처리 속도(우선)와 안정성 제고 목적의 경우가 대부분
 */

-- 튜닝 전과 후 비교 :: 성능항상, 불필요한 기능 삭제 
-- 전
SELECT *
FROM EMP
WHERE SUBSTR(EMPNO,1,2) = 75    -- 암묵적 형변환이 2번 일어나는 경우(숫자 > 문자 > 숫자)
	AND LENGTH(EMPNO) = 4	    -- 불필요한 비교
	;
--후   :: 불필요한 함수제거 
SELECT *
FROM EMP
WHERE EMPNO > 7499
	 AND EMPNO <7600
	 ;
	 
-- 전
SELECT * FROM EMP WHERE ENAME || '' || JOB = 'WARD SALESMAN';	
-- 후  (연결보다는 개별 비교)
SELECT * FROM EMP WHERE ENAME = 'WARD' AND JOB = 'SALESMAN';

-- 전
SELECT DISTINCT E.EMPNO, E.ENAME , M.DEPTNO
	FROM EMP e JOIN DEPT M ON (E.DEPTNO = M.DEPTNO);
-- 후 (중복 제거 및 정렬 비용 발생 최소화)
SELECT E.EMPNO, E.ENAME, D.DEPTNO
FROM EMP E, DEPT D
WHERE E.DEPTNO = D.DEPTNO
;

-- 전
SELECT *
FROM EMP WHERE DEPTNO ='10'
UNION
SELECT *
FROM EMP WHERE DEPTNO ='20'
;
-- 후 :: UNINO은 중복제거 비용 발생, 암묵적 변환 제거
SELECT *
FROM EMP WHERE DEPTNO ='10'
UNION ALL
SELECT *
FROM EMP WHERE DEPTNO ='20'
;

-- 전
SELECT ENAME, EMPNO, SUM(SAL) FROM EMP
GROUP BY ENAME, EMPNO;
-- 후 :: 인덱스 설정된 EMPNO 우선 순위 사용 (빠르다)
SELECT EMPNO, ENAME, SUM(SAL) FROM EMP
GROUP BY EMPNO, ENAME;   -- 이 테이블에서는 EMPNO가 PRIMARY키이자 INDEX임

-- 전
SELECT EMPNO, ENAME FROM EMP
WHERE TO_CHAR(HIREDATE, 'YYYY/MM/DD') LIKE '1981%' -- 동일한 데이터타입 = string
AND EMPNO > 7700;
-- 후 :: 형변환 줄이고, LIKE 연산 줄이고 (LIKE보다 '='이 빠르다, )
SELECT EMPNO, ENAME FROM EMP
WHERE EXTRACT (YEAR FROM HIREDATE) = 1981 AND EMPNO > 7700;  -- 동일한 데이터타입 = integer
-- 적은 건수에서는 차이가 별로 없지만 데이터량이 많아졌을 때는 '후' 방법이 큰 효율을 낼 것

/*
 * 튜닝 추가
 * 1. INDEX 활용 - GROUP BY 집계 함수
 * 2. 오라클 DATE 객체 함수 비교
 */
SELECT *
FROM USER_INDEXES
WHERE TABLE_NAME = 'EMP';
-- IDX 없는 상태에서..

CREATE INDEX IDX_EMP_JOB
	ON EMP (JOB)
;  -- EMP 테이블 JOB 칼럼에 INDEX 지정

-- 집계 함수를 사용할 때, 최대한 인덱스가 설정된 컬럼을 우선 상
SELECT JOB, SUM(SAL) AS SUM_OF_SAL
FROM EMP 
GROUP BY JOB 
ORDER BY SUM_OF_SAL DESC
;

SELECT * FROM EMP;


-- VIEW 생성 및 활용
SELECT * FROM EMPLOYEES;  -- HR계정에서 해봅시다

SELECT *
FROM EMPLOYEES e 
	, DEPARTMENTS d 
	, JOBS j
	, LOCATIONS l 
	, COUNTRIES c 
	, REGIONS r 
WHERE e.DEPARTMENT_ID = d.DEPARTMENT_ID
	AND d.LOCATION_ID = l.LOCATION_ID 
	AND l.COUNTRY_ID = c.COUNTRY_ID 
	AND C.REGION_ID = r.REGION_ID
	AND j.JOB_ID = e.JOB_ID 
	;
-- 이렇게 view를 만들어서 가져다가 쓰면 됩니다	





