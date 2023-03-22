
/*
 * CREATE TABLE
 */
CREATE TABLE DEPT_TEMP
	AS
SELECT
	*
FROM
	DEPT;    -- 기존 DEPT테이블을 가지고 임시 테이블을 만들었다

 -- COMMIT; -- TO CONFIRM IF ANY CHANGES ON DO IS VAILD	
	
-- DROP TABLE DEPT_TEMP;     -- 테이블을 제거함 

 -- DML(DATA MANIPULATION LANGUAGE): SELECT, INSERT, UPDATE, DELETE   :: 조작, 처리
 -- DDL(DATA DEFINITION LANGUAGE): CREATE, ALTER, DROP, TRUNCATE  :: 테이블 구조변경

-- INSERT 데이터를 입력하는 방식   ::  INSERT INTO 테이블명 (칼럼명1, 칼럼명2, ....) VALUES (데이터1, 데이터2, ....)	

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (50, 'DATABASE', 'SEOUL')
;

SELECT * FROM DEPT_TEMP;

INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (70, 'WEB', NULL)
;
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (70, 'WEB', NULL)
;
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (80, 'MOBILE', '')
;
INSERT INTO DEPT_TEMP (DEPTNO, DNAME, LOC)
VALUES (90, 'INCHEON')
; -- NOT ENOUGH VALUE

COMMIT;

SELECT * FROM DEPT_TEMP;
-- 중복된 값들이 있죠. 이러면 안 되니 PRIMARY KEY가 필요하다는 느낌이 오죠


-- 칼럼들만 복사해서 새로운 테이블을 생성  (빨리 복사 떠올 때)  :: WHERE 조건절에 1<>1
CREATE TABLE EMP_TEMP
AS SELECT * FROM EMP WHERE 1<>1
;

COMMIT;

SELECT * FROM EMP_TEMP;  -- EMP 테이블과 같은 칼럼들을 가진 틀이 생김

INSERT  INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (9999, '홍길동', 'PRESIDENT', NULL, '2001/01/01', 6000, 500, 10);
-- literal does not match format string 이런 오류가 뜨면 날짜의 형식을 맞춰줘야 한다 :: 여기선 오라클 DBMS가 자동으로 처리해줘버림

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (2111, '이순신', 'MANAGER', 9999, TO_DATE('07/01/2001', 'DD/MM/YYYY'), 4000, NULL, 20);
-- 이렇게 넣어도 날짜 형식이 테이블 날짜형식과 다르다 보니 NOT VAILD MONTH 이런 오류가 나야하는데,, 마찬가지로 DBMS에서 잡아주니 입력 됨

INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES (3111, '심청이', 'MANAGER', 9999, SYSDATE, 4000, NULL, 20);

-- COMMIT;  기본적으로 커밋하는 연습!

SELECT
	*
FROM
	EMP_TEMP;

-- INSERT 문에서 SUB쿼리를 사용  :: VALUES문이 없음, 테이블의 열개수와 서브쿼리의 열 개수가 동일해야 함, 테이블의 자료형과 서브쿼리의 자료형도 동일해야 함
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
SELECT e.EMPNO , e.ENAME , E.JOB , E.MGR , E.HIREDATE , E.SAL , E.COMM , E.DEPTNO 
FROM EMP e , SALGRADE s 
WHERE e.SAL BETWEEN s.LOSAL AND s.HISAL 
	AND S.GRADE = 1
; -- SALGRADE 1인 사람들을 추가함

SELECT * FROM EMP_TEMP;


-- UPDATE 문 : 필터된 데이터에 대해서 레코드 값을 수정 (컬럼값을 수정 X) 
CREATE TABLE DEPT_TEMP2
AS SELECT * FROM DEPT
; -- 테스트 개발을 위한 임시 테이블 생성

SELECT * FROM DEPT_TEMP2
; -- 테스트 개발을 위한 임시 테이블 확인

COMMIT;

/*
 * UPDATE 
 * SET
 * 한 문장과도 같이 세트로 나옴
 */ 
UPDATE DEPT_TEMP2
SET LOC = 'SEOUL'
; 
-- 이렇게 해버리면 모든 LOC이 서울행
-- WHERE 조건절을 잘 넣어야 합니다
ROLLBACK;   --으로 되돌려야겠죠
 
SELECT * FROM EMP WHERE ROWNUM < 3; -- ROWNUM을 등록한 적이 없지만 자동으로 등록되어 있죠

-- UPDATE 부서번호 40의 2개 값 변경
UPDATE DEPT_TEMP2
SET DNAME = 'DATABASE'
, LOC = 'SEOUL'
WHERE DEPTNO = 40
;

-- 서브쿼리를 사용하여 UPDATE 
UPDATE DEPT_TEMP2 
SET (DNAME, LOC) = (SELECT DNAME, LOC FROM DEPT WHERE DEPTNO = 40)
WHERE DEPTNO = 40
;

ROLLBACK;  -- 롤백이 안 먹히는듯;; AUTO COMMIT 되는 것 같은데..

SELECT * FROM DEPT_TEMP2;

COMMIT; -- 사장결재 끝, 원복 불가

/*
 * DELETE 구문으로 테이블에서 값을 제거
 * 대부분의 경우,
 * 보통의 경우, DELETE보다는 UPDATE 구문으로 상태 값을 변경
 * 예시 : 근무/휴직/퇴사 등의 유형으로 값을 변경
 */

SELECT * FROM EMP_TEMP2;

CREATE TABLE EMP_TEMP2 AS (SELECT * FROM EMP)
;   -- DDL 오라클은 오토커밋이 되네 커밋안해도 만들어짐

DELETE FROM EMP_TEMP2
WHERE JOB ='MANAGER'
;  -- 인사팀에서 명령 실행 요청

ROLLBACK; -- 사장 승인? 취소?  :: DML도 롤백이 안돼;;;
COMMIT; 

SELECT * FROM EMP_TEMP2
WHERE JOB = 'MANAGER'
;

UPDATE DEPT_TEMP2 
SET DNAME = 'DATABASE'
   ,LOC='SEOUL'
WHERE DEPTNO = 40 -- WHERE절이 반드시 필요!
;

COMMIT; -- 하고

UPDATE DEPT_TEMP2 
SET (DNAME, LOC) = (SELECT DNAME, LOC
               FROM DEPT
               WHERE DEPTNO = 40)
WHERE DEPTNO = 40
; -- 되돌리고

ROLLBACK; -- 다시 돌백하면 직전 COMMIT까지 돌아감


-- 좀 더 복잡한 where절을 활용한 delete
DELETE FROM 
	EMP_TEMP2
WHERE
	EMPNO IN (
	SELECT EMPNO
	FROM EMP_TEMP2 et, SALGRADE s
	WHERE et.SAL BETWEEN S.LOSAL AND s.HISAL
		AND S.GRADE = 3
		AND DEPTNO = 30)
; -- GRADE가 3이고, DEPTNO가 30인 EMPNO 값 모두 삭제. 하나일수도, 두개 이상일수도 있겠지

SELECT et.EMPNO
FROM EMP_TEMP2 et , SALGRADE s 
WHERE ET.SAL BETWEEN s.LOSAL AND s.HISAL 
	AND s.GRADE = 3
	AND deptno = 30
;

/*
 * CREATE 문을 정의 : 기존에 없는 테이블 구조를 생성
 * 데이터는 없고, 테이블의 컬럼과 데이터타입, 제약 조건 등의 구조를 생성 
 */

CREATE TABLE EMP_NEW 
(
	EMPNO   NUMBER(4)
	, ENAME VARCHAR(10)
	, JOB VARCHAR(9)
	, MGR NUMBER(4)
	, HIREDATE DATE
	, SALGRADE NUMBER(7,2)
	, COMM NUMBER(7,2)
	, DEPTNO NUMBER(2)
)
;

SELECT *
FROM EMP e 
WHERE ROWNUM <= 5
; -- 왜 ROWNUM = 2하면 결과가 없을까? 특정 번호를 가져오는 것이 아니라, 갯수를 가져오는 것이라 그렇습니다.

-- DDL (DATA DEFINITION LANGUAGE) 명령어  :: CREATE(테이블 생성) / ALTER (테이블 구조 변경) + ADD, MODIFY, RENAME, DROP.. / DROP(테이블 자체를 삭제) / RENAME(이름변경) 

--테이블에 새로운 컬럼을 추가(ADD)
ALTER TABLE EMP_NEW
ADD HP VARCHAR2(20); -- HP 컬럼 추가

SELECT * FROM EMP_NEW;

--기존 컬럼명을 변경(RENAME COLUMN)
ALTER TABLE EMP_NEW 
RENAME COLUMN TEL TO TEL_NO; -- HP 컬럼명을 TEL_NO로 변경

--이름이 아닌 타입을 바꾸려면?  컬럼 데이터 형식을 변경(MODIFY)
ALTER TABLE EMP_NEW MODIFY EMPNO NUMBER(5); -- 직원수가 많아져서 기존 4자리에서 5자리로 변경
ALTER TABLE EMP_NEW DROP COLUMN TEL_NO; -- 컬럼 삭제

--SEQUENCE 생성 : 일련번호 사용  (테이블 관리를 편리하게 하고자 함, 유니크한 값을 만들기 위함)
-- 특정 규칙에 따라 생성되는 연속 숫자를 생성하는 객체
CREATE SEQUENCE SEQ_DEPTNO
	INCREMENT BY 1	   --증가값(기본1)	
	START WITH 1       --시작값(기본1)
	MAXVALUE 999
	MINVALUE 1
	NOCYCLE   -- NOCYCLE = 최대값에서 중단. 반복x  
	NOCACHE   --  NOCACHE 값 미리 생성(기본20) 
	;  -- SEQUENCES 폴더에 SEQ_DEPTNO라는 시퀀스가 생성됨.

INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTNO.NEXTVAL, 'DATABASE', 'SEOUL') 
;
INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTNO.NEXTVAL,'WEB', 'BUSAN')
;
INSERT INTO DEPT_TEMP2 (DEPTNO, DNAME, LOC)
VALUES (SEQ_DEPTNO.NEXTVAL,'MOBILE', 'SUNGSU')
;
-- SEQUENCE 만들걸 가지고 번호를 따서 DEPTNO를 채움. 내가 기억하지 못하더라도 절대 중복되지 않겠지. ROLLBACK 불가 무조건 COMMIT입니다
SELECT * FROM DEPT_TEMP2 dt ;

/*
 * 제약조건 (CONSTRAINT) 지정
 * 테이블을 생성할 때, 테이블 컬럼별 제약 조건을 설정
 * 
 * NOT NULL
 * UNIQUE
 * PK
 * FK
 */

CREATE TABLE LOGIN (
  LOG_ID VARCHAR2(20) NOT NULL,
  LOG_PWD VARCHAR2(20) NOT NULL,
  TEL VARCHAR2(20)
);

INSERT INTO LOGIN (LOG_ID, LOG_PWD)
VALUES ('TEST01', '1234')
;

SELECT *
FROM LOGIN
;

--수소문해서 TEL 넘버를 알게되서 추가
UPDATE LOGIN
SET TEL = '010-1234-5678'
WHERE LOG_ID = 'TEST01'
;

--TEL의 중요성을 향후 인식, NOT NULL 제약조건을 설정
ALTER TABLE LOGIN
MODIFY TEL NOT NULL
; --제약조건 이름 설정하지 않음

-- 오라클 DBMS가 사용자를 위해 만들어 놓은 제약조건 설정값 테이블
SELECT OWNER
	, CONSTRAINT_NAME
	, CONSTRAINT_TYPE
	, TABLE_NAME
FROM USER_CONSTRAINTS
WHERE TABLE_NAME = 'LOGIN'
; -- 제약조건 확인

-- 제약조건 이름을 만들면서 제약 조건 설정
ALTER TABLE LOGIN
	MODIFY (TEL CONSTRAINT TEL_NN NOT NULL)
;

/*
--TEL의 중요성을 향후 인식, NOT NULL 제약조건을 설정
ALTER TABLE LOGIN
MODIFY TEL NOT NULL
; --제약조건 이름 설정하지 않음   // FROM USER_CONSTRAINTS 테이블에서 제약조건 확인 가능
*/

-- 제약조건 삭제
ALTER TABLE LOGIN2
DROP CONSTRAINT SYS_C007040        -- 제약조건 이름이 없어 주어진 이름 사용(내장된) 
;     

/*
 * UNIQUE 키워드 사용
 */
CREATE TABLE LOG_UNIQUE
(
	LOG_ID VARCHAR2(20) UNIQUE
	, LOG_PWD VARCHAR2(20) NOT NULL
	, TEL VARCHAR2(20)
)
;

SELECT *
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'LOG_UNIQUE'
; -- 제약조건 확인


INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST1', 'PWD123', '010-0000-2222')
;
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST2', 'PWD88', '010-0000-2321')
;
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST3', 'PWD00', '010-0000-2555')
;
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES('TEST4', 'PWD112', '010-0000-7777')
;
INSERT INTO LOG_UNIQUE (LOG_ID, LOG_PWD, TEL)
VALUES(NULL, 'PWD112', '010-0000-7777')
; -- 일부러 NULL입력, 향후 UPDATE를 위해.. UNIQUE 제약조건 컬럼이라 NULL값 가능

SELECT * FROM LOG_UNIQUE;

UPDATE LOG_UNIQUE
SET LOG_ID = 'TEST_ID_NEW'   --사용자가 ID변경을 요청
WHERE LOG_ID IS NULL
;  -- NULL인 로긴아이디에 TEST_ID_NEW 입력

ALTER TABLE LOG_UNUQUE
MODIFY (TEL UNIQUE)
;  -- TEL 칼럼을 UNIQUE 제약조건으로 변경

/*
 * PK(주키, PRIMARY KEY) : 테이블을 설명하는 가장 중요한 키
 * NOT NULL + UNIQUE + INDEX
 */

CREATE TABLE LOG_PK
(
	LOG_ID VARCHAR2(20) PRIMARY KEY
	, LOG_PWD VARCHAR2(20) NOT NULL
	, TEL VARCHAR2(20)
)
;

SELECT *
FROM USER_CONSTRAINTS 
WHERE TABLE_NAME = 'LOG_PK'
; -- 제약조건 확인     왜 제약조건 확인이 안 될까

-- 기존 고객의 ID와 동일한 ID 입력하는 경우, NULL입력하는 경우  :: LOG_ID (PK제약조건 위반)
INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES ('PK01', 'PWD01', '012-2422-3161')
;
INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES ('PK01', 'PWD02', '013-2555-3222')
;  --오류
INSERT INTO LOG_PK (LOG_ID, LOG_PWD, TEL)
VALUES (NULL, 'PWD03', '011-3451-7777')
;  --오류



SELECT *
FROM EMP_TEMP
;

/*
 * 존재하지 않는 부서번호를 EMP_TEMP 테이블에 입력을 시도 
 */
INSERT INTO EMP_TEMP (EMPNO, ENAME, JOB, MGR, HIREDATE, SAL, COMM, DEPTNO)
VALUES(3333, 'GHOST', 'SURPRISE', '9999', SYSDATE, 1200, NULL, 99)
;

CREATE TABLE EMP_FK
       (EMPNO NUMBER(4) CONSTRAINT PK_EMP PRIMARY KEY,
	ENAME VARCHAR2(10),
	JOB VARCHAR2(9),
	MGR NUMBER(4),
	HIREDATE DATE,
	SAL NUMBER(7,2),
	COMM NUMBER(7,2),
	DEPTNO NUMBER(2) CONSTRAINT FK_DEPTNO REFERENCES DEPT);
-- 제약조건 포함 테이블 생성

-- ON DELETE CASCADE  :: 자식 데이터까지 모두 삭제
-- ON DELETE SET NULL  :: 지우고 NULL로 세팅?

-- CHECK 키워드 :: 값을 확인하는 제약 조건

-- DEFAULT 값 지정 - 제약조건      EX) 로그인 패스워드에 기본값을 지정하는 경우 >> DEFAULT '1234'

/*
 * INDEX 지정 : 빠른 검색을 위한 색인 지정
 * 
 * 장점 : 순식간에 원하는 값을 찾아 준다
 * 단점 : 입력과 출력이 잦은 경우, 인덱스가 설정된 테이블이 속도가 저하된다 
 * 
 * KEY & POINTER 쌍으로 구성
 */

-- 특정 직군에 해당하는 직원을 빠르게 찾기 위한 색인 지정  :: 원하는 데이터 레코드를 빠르게 찾기 위함
CREATE INDEX IDX_EMP_JOB
ON EMP(JOB)
;
-- 지정한 테이블에다가 (칼럼명) 해주면 인덱스는 지정됨

-- 설정한 인덱스 리스트 출력
SELECT *
FROM USER_INDEXES
WHERE TABLE_NAME IN('EMP', 'DEPT')
;

--테이블에 값이 100만개.... 인덱스가 몇 개 되어있나 보니 5개가 있네? 



--VIEW(뷰) 가상의임시 테이블처럼 사용하는 편리한 뷰, 테이블을 편리하게 사용하기 위한 목적으로 생성하는 가상 테이블

-- SQLPLUS SYSTEM/111111    :: CMD에서 시스템 로그인 후
GRANT CREATE VIEW TO SCOTT;   -- SCOTT계정에 VIEW 권한 부여

--VIEW 생성
CREATE VIEW VW_EMP
AS (SELECT EMPNO, ENAME, JOB, DEPTNO
		FROM EMP
		WHERE DEPTNO = 10)
;
-- CREATE TABLE은 입력, 저장의 목적이고..  VIEW는 만들어놓고 결과값만 볼려는 목적이다. ONLY '조회'

--생성된 VIEW 확인
SELECT * FROM VW_EMP
;

SELECT *
FROM USER_VIEWS
WHERE VIEW_NAME = 'VW_EMP'
;  -- 또 안됨.. SYSTEM계정이 아니라서(SCOTT계정) 그런듯함

-- 내장 뷰 리스트 보기
SELECT * FROM USER_VIEWS
;
SELECT VIEW_NAME, TEXT_LENGTH, TEXT FROM USER_VIEWS
;

-- 뷰 삭제하기
DROP VIEW VW_EMP;


-- ROWNUM 컬럼(순번) : 상위 N개 출력
SELECT ROWNUM
	, E.*
FROM EMP e 
ORDER BY SAL DESC
;

-- 인라인 뷰(SQL 문에서 일회성으로 사용하는 뷰. 출력하고 사라진다) FROM절에 나오는 이중쿼리 = 인라인 뷰
SELECT ROWNUM, E.*
FROM (SELECT *
		FROM EMP 
		ORDER BY SAL DESC) E
;

-- WITH절을 사용하는 인라인 뷰
WITH E AS (SELECT * FROM EMP ORDER BY SAL DESC)
SELECT ROWNUM, E.*
FROM E;

-- ROWDNUM 상위 5개만 뽑기 (1:1인 =으로 조회는 불가)
SELECT ROWNUM, E.*
FROM (SELECT * 
		FROM EMP 
		ORDER BY SAL DESC) E
WHERE ROWNUM <= 5
;

-- 데이터 사전 : 오라클 객체에 대한 정보 제공 목적.. 오라클 DBMS에서 관리하는 관리 테이블 리스트 출력

-- 데이터 사전 조회
SELECT * FROM DICT;
SELECT * FROM DICTIONARY;

SELECT *
FROM DICT
WHERE TABLE_NAME LIKE 'USER_%' -- % 와일드 카드
;
SELECT *
FROM DICT
WHERE TABLE_NAME LIKE 'USER_CON%'
;

-- 사용자 테이블 조회
SELECT TABLE_NAME FROM USER_TABLES;

-- DBA 소유 테이블 조회
SELECT *
FROM DBA_TABLES
WHERE TABLE_NAME LIKE 'EMP%'
;

--DBA 사용자 관련 조회
SELECT *
FROM DBA_USERS
WHERE USERNAME = 'SCOTT'
;


