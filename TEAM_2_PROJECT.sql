--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------테이블 생성-----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--(1) 부서 정보 테이블 생성
CREATE TABLE DEPARTMENT_INFO (
  DEPARTMENT_ID CHAR(3) PRIMARY KEY, --부서ID
  DEPARTMENT_NAME VARCHAR2(30), 	 --부서명
  LOC VARCHAR2(20) 					 --부서위치
);

--(2) 직원 정보 테이블 생성
CREATE TABLE EMPLOYEE_INFO (
  EMPLOYEE_ID CHAR(7) PRIMARY KEY, --사원번호
  EMPLOYEE_NAME VARCHAR2(30), 	   --사원명
  DEPARTMENT_ID CHAR(3),		   --부서ID
  HIRE_DATE DATE,				   --입사일
  JOB_LEVEL CHAR(2),      		   --직급
  DUTY VARCHAR2(20),   			   --직무
  CONSTRAINT FK_DEPARTMENT_INFO FOREIGN KEY (DEPARTMENT_ID) REFERENCES DEPARTMENT_INFO(DEPARTMENT_ID)
);

--(3) 자격증 정보 테이블 생성
CREATE TABLE CERTIFICATION_INFO (
  CERTIFICATION_CODE CHAR(4) PRIMARY KEY,  --자격증코드
  CERTIFICATION_NAME VARCHAR(50),          --자격증명
  CERTIFICATION_TYPE VARCHAR(50),		   --자격증종류(금융, IT, IB)
  PRODUCT_SALES_QUALIFICATION CHAR(1), 	   --상품판매자격증여부(1:여 / 0:부)
  SALES_QUALIFICATION_CODE VARCHAR(50),    --상품판매자격코드(0:해당무 / 1:펀드 / 2:파생 / 3:생명보험 / 4:손해보험 / 5:제3보험 / 6:변액보험)
  CERTIFICATION_GRADE CHAR(1),             --자격등급
  CERTIFICATION_MILEAGE NUMBER(2,0)        --자격취득마일리지
);

--(4) 자격증 취득이력 테이블 생성
CREATE TABLE CERTIFICATION_HISTORY (
  CERTIFICATION_ID CHAR(4) PRIMARY KEY,  --자격증등록ID
  EMPLOYEE_ID CHAR(7),					 --사원번호
  CERTIFICATION_CODE CHAR(4),            --자격증코드
  ACQUISITION_DATE DATE,  			     --취득일
  REGISTRATION_DATE DATE,                --등록일
  CONSTRAINT FK_EMPLOYEE_INFO_CH FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE_INFO(EMPLOYEE_ID),
  CONSTRAINT FK_CERTIFICATION_INFO_CH FOREIGN KEY (CERTIFICATION_CODE) REFERENCES CERTIFICATION_INFO(CERTIFICATION_CODE)
);

--(5) 연수 정보 테이블 생성
CREATE TABLE TRAINING_INFO (
  TRAINING_CODE CHAR(4) PRIMARY KEY,  --연수코드
  TRAINING_NAME VARCHAR(50),		  --연수명
  TRAINING_SUBJECT VARCHAR(50),       --연수과목
  TRAINING_MILEAGE NUMBER(2,0),       --연수마일리지
  TRAINING_GRADE VARCHAR(50)          --연수등급
);

--(6) 연수 수강이력 테이블 생성
CREATE TABLE TRAINING_HISTORY (
  TRAINING_ID CHAR(4) PRIMARY KEY,  --연수수강ID
  EMPLOYEE_ID CHAR(7), 				--사원번호
  TRAINING_CODE CHAR(4), 			--연수코드
  START_DATE DATE, 					--연수시작일
  END_DATE DATE, 					--연수종료일
  COMPLETION_STATUS CHAR(1), 		--수료여부
  CONSTRAINT FK_EMPLOYEE_INFO_TH FOREIGN KEY (EMPLOYEE_ID) REFERENCES EMPLOYEE_INFO(EMPLOYEE_ID),
  CONSTRAINT FK_TRAINING_INFO_TH FOREIGN KEY (TRAINING_CODE) REFERENCES TRAINING_INFO(TRAINING_CODE)
);

--------------------------------------------------------------------------------------------------------------------
-------------------------------------------------------데이터 입력-----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--(7) 부서 정보 테이블 데이터 입력
INSERT INTO department_info (department_id, department_name, LOC)
	SELECT 'D01', '여의도종금센터', '서울' FROM DUAL UNION ALL
	SELECT 'D02', '해운대종금센터', '부산' FROM DUAL UNION ALL
	SELECT 'D03', 'DT전략부', '서울' FROM DUAL UNION ALL
	SELECT 'D04', '회계부', '서울' FROM DUAL UNION ALL
	SELECT 'D05', '개인마케팅부', '대전' FROM DUAL UNION ALL
	SELECT 'D06', '대구지역영업그룹', '대구' FROM DUAL UNION ALL
	SELECT 'D07', '안전관리부', '세종' FROM DUAL UNION ALL
	SELECT 'D08', '비서실', '세종' FROM DUAL UNION ALL
	SELECT 'D09', '스마트고객상담부', '대전' FROM DUAL UNION ALL
	SELECT 'D10', 'WM투자자문부', '서울' FROM DUAL UNION ALL
	SELECT 'D11', '데이터분석부', '강릉' FROM DUAL UNION ALL
	SELECT 'D12', '기업금융솔루션부', '서울' FROM DUAL UNION ALL
	SELECT 'D13', '기업여신부', '춘천' FROM DUAL UNION ALL
	SELECT 'D14', '글로벌기획부', '인천' FROM DUAL UNION ALL
	SELECT 'D15', '글로벌지원부', '인천' FROM DUAL UNION ALL
	SELECT 'D16', '신탁부', '서울' FROM DUAL UNION ALL
	SELECT 'D17', '수탁부', '서울' FROM DUAL UNION ALL
	SELECT 'D18', '펀드서비스부', '서울' FROM DUAL UNION ALL
	SELECT 'D19', 'IT아키텍쳐부', '여수' FROM DUAL UNION ALL
	SELECT 'D20', '자금부', '서울' FROM DUAL
;

--(8) 사원 정보 테이블 데이터 입력
INSERT INTO employee_info (employee_id, employee_name, department_id, hire_date, job_level, duty)
	SELECT '1650431', '김영희', 'D01', '2000-01-15', 'L2', 'UB' FROM DUAL UNION ALL
	SELECT '1789560', '송진영', 'D01', '2013-01-19', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '3033326', '김예진', 'D01', '2007-03-20', 'L1', 'UB' FROM DUAL UNION ALL
	SELECT '3025485', '김수정', 'D02', '2015-02-20', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '3124564', '하도준', 'D02', '2013-04-20', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '3074563', '박철수', 'D02', '2005-03-02', 'L1', 'UB' FROM DUAL UNION ALL
	SELECT '1654444', '이민재', 'D02', '1995-05-03', 'L3', 'UB' FROM DUAL UNION ALL
	SELECT '1654446', '이민재', 'D02', '1995-05-03', 'L3', 'UB' FROM DUAL UNION ALL
	SELECT '1458765', '송지은', 'D03', '2002-06-04', 'L0', 'ICT' FROM DUAL UNION ALL
	SELECT '3077464', '박영미', 'D03', '2022-02-05', 'L2', 'UB' FROM DUAL UNION ALL
	SELECT '1584553', '김태환', 'D04', '2020-03-06', 'L1', 'ICT' FROM DUAL UNION ALL
	SELECT '1313541', '최승현', 'D04', '2015-08-07', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '1654771', '김나리', 'D04', '1989-12-08', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '1655662', '정주영', 'D05', '1998-07-09', 'L2', 'IB' FROM DUAL UNION ALL
	SELECT '1788453', '임세원', 'D06', '2008-02-11', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '1326654', '한승민', 'D06', '2015-03-12', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '1665885', '윤영준', 'D07', '2003-05-13', 'L2', 'ICT' FROM DUAL UNION ALL
	SELECT '1452334', '임승현', 'D07', '1998-04-14', 'L1', 'IB' FROM DUAL UNION ALL
	SELECT '3022558', '박혜진', 'D07', '1994-03-15', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '3066599', '김성민', 'D08', '2005-02-16', 'L0', 'ICT' FROM DUAL UNION ALL
	SELECT '3520140', '이상민', 'D08', '2002-08-17', 'L2', 'UB' FROM DUAL UNION ALL
	SELECT '3014787', '정태환', 'D08', '2004-09-18', 'L1', 'ICT' FROM DUAL UNION ALL
	SELECT '3845123', '하도영', 'D09', '2009-05-20', 'L2', 'ICT' FROM DUAL UNION ALL
	SELECT '3665232', '진도준', 'D09', '2012-06-20', 'L1', 'UB' FROM DUAL UNION ALL
	SELECT '1758661', '차인표', 'D09', '2003-05-20', 'L2', 'IB' FROM DUAL UNION ALL
	SELECT '1650426', '김재경', 'D10', '2015-05-25', 'L1', 'UB' FROM DUAL UNION ALL
	SELECT '1650287', '박원갑', 'D10', '2003-07-20', 'L3', 'UB' FROM DUAL UNION ALL
	SELECT '1652368', '김승원', 'D11', '2003-03-20', 'L2', 'UB' FROM DUAL UNION ALL
	SELECT '1666339', '권현준', 'D11', '2015-06-20', 'L1', 'IB' FROM DUAL UNION ALL
	SELECT '1647850', '서민철', 'D12', '2020-06-20', 'L1', 'IB' FROM DUAL UNION ALL
	SELECT '2215360', '박효선', 'D12', '2021-06-20', 'L1', 'IB' FROM DUAL UNION ALL
	SELECT '3699410', '김하연', 'D13', '2018-06-20', 'L1', 'IB' FROM DUAL UNION ALL
	SELECT '1255448', '권수철', 'D13', '2005-05-20', 'L0', 'IB' FROM DUAL UNION ALL
	SELECT '1365427', '김양희', 'D13', '2008-01-05', 'L3', 'IB' FROM DUAL UNION ALL
	SELECT '1369637', '손영숙', 'D14', '1990-01-20', 'L3', 'ICT' FROM DUAL UNION ALL
	SELECT '1655876', '권민희', 'D14', '2006-01-15', 'L2', 'IB' FROM DUAL UNION ALL
	SELECT '1324665', '신봉진', 'D15', '2012-05-20', 'L2', 'IB' FROM DUAL UNION ALL
	SELECT '1477444', '신강현', 'D15', '2021-05-20', 'L1', 'ICT' FROM DUAL UNION ALL
	SELECT '1466333', '신주하', 'D16', '2022-05-20', 'L1', 'ICT' FROM DUAL UNION ALL
	SELECT '1629882', '박혜민', 'D17', '2015-06-29', 'L1', 'UB' FROM DUAL UNION ALL
	SELECT '1652331', '김혜린', 'D18', '2016-03-11', 'L0', 'UB' FROM DUAL UNION ALL
	SELECT '3054422', '안법헌', 'D19', '2006-12-20', 'L3', 'UB' FROM DUAL UNION ALL
	SELECT '3052339', '임용수', 'D20', '2014-02-10', 'L2', 'ICT' FROM DUAL
;

--(9) 자격증 정보 테이블 데이터 입력
INSERT INTO CERTIFICATION_INFO (CERTIFICATION_CODE, CERTIFICATION_NAME, CERTIFICATION_TYPE, PRODUCT_SALES_QUALIFICATION, SALES_QUALIFICATION_CODE, CERTIFICATION_GRADE,CERTIFICATION_MILEAGE)
	SELECT 'C001', '펀드투자권유자문인력','금융','1','1','B','20' FROM DUAL UNION ALL
	SELECT 'C002', '파생상품투자권유자문인력','금융','1','2','B','20' FROM DUAL UNION ALL
	SELECT 'C003', '생명보험','금융','1','3','C','20' FROM DUAL UNION ALL
	SELECT 'C004', '손해보험','금융','1','4','C','20' FROM DUAL UNION ALL
	SELECT 'C005', '제3보험','금융','1','5','C','20' FROM DUAL UNION ALL
	SELECT 'C006', '변액보험','금융','1','6','C','20' FROM DUAL UNION ALL
	SELECT 'C007', '외환전문역 1종','금융','0','0','B','20' FROM DUAL UNION ALL
	SELECT 'C008', '외환전문역 2종','금융','0','0','B','20' FROM DUAL UNION ALL
	SELECT 'C009', '빅데이터분석기사','IT','0','0','B','20' FROM DUAL UNION ALL
	SELECT 'C010', '데이터분석전문가_ADP','IT','0','0','B','20' FROM DUAL UNION ALL
	SELECT 'C011', '데이터분석준전문가_ADSP','IT','0','0','C','10' FROM DUAL UNION ALL
	SELECT 'C012', 'SQL전문가_SQLP','IT','0','0','B','20' FROM DUAL UNION ALL
	SELECT 'C013', 'SQL개발자_SQLD','IT','0','0','C','10' FROM DUAL UNION ALL
	SELECT 'C014', '데이터아키텍처전문가_DAP','IT','0','0','B','20' FROM DUAL UNION ALL
	SELECT 'C015', '데이터아키텍처WNS전문가_DASP','IT','0','0','C','10' FROM DUAL UNION ALL
	SELECT 'C016', 'TOEIC_SPEAKING','IB','0','0','C','10' FROM DUAL UNION ALL
	SELECT 'C017', 'OPIC','IB','0','0','C','10' FROM DUAL UNION ALL
	SELECT 'C018', '변호사','IB','0','0','A','50' FROM DUAL UNION ALL
	SELECT 'C019', 'CFA','IB','0','0','A','50' FROM DUAL UNION ALL
	SELECT 'C020', '회계사','IB','0','0','A','50' FROM DUAL
;

--(10) 자격증 취득이력 시퀀스 생성
CREATE SEQUENCE SEQ_CERTIFICATION_HISTORY
	INCREMENT BY 1
	START WITH 1001
	MAXVALUE 9999
	MINVALUE 1
	NOCYCLE NOCACHE
;

--(11) 자격증 취득이력 테이블 데이터 입력
INSERT INTO CERTIFICATION_HISTORY (CERTIFICATION_ID, EMPLOYEE_ID, CERTIFICATION_CODE, ACQUISITION_DATE, REGISTRATION_DATE)
	SELECT SEQ_CERTIFICATION_HISTORY.NEXTVAL
	      ,E.*
	FROM (SELECT '1652331','C001','2022-07-07','2022-07-15' FROM DUAL UNION ALL
		SELECT '1650426','C001','2022-07-13','2022-07-19' FROM DUAL UNION ALL
		SELECT '1789560','C001','2022-07-20','2022-07-29' FROM DUAL UNION ALL
		SELECT '1369637','C001','2022-07-21','2022-08-03' FROM DUAL UNION ALL
		SELECT '1584553','C002','2022-07-22','2022-07-29' FROM DUAL UNION ALL
		SELECT '1629882','C002','2022-07-26','2022-08-01' FROM DUAL UNION ALL
		SELECT '3520140','C002','2022-07-27','2022-08-02' FROM DUAL UNION ALL
		SELECT '3066599','C002','2022-07-30','2022-08-05' FROM DUAL UNION ALL
		SELECT '1458765','C003','2022-08-01','2022-08-09' FROM DUAL UNION ALL
		SELECT '1650431','C003','2022-08-02','2022-08-14' FROM DUAL UNION ALL
		SELECT '1654444','C003','2022-08-03','2022-08-10' FROM DUAL UNION ALL
		SELECT '1324665','C003','2022-08-04','2022-08-12' FROM DUAL UNION ALL
		SELECT '1647850','C003','2022-08-06','2022-08-19' FROM DUAL UNION ALL
		SELECT '1654446','C004','2022-08-07','2022-08-13' FROM DUAL UNION ALL
		SELECT '1788453','C004','2022-08-08','2022-08-14' FROM DUAL UNION ALL
		SELECT '3025485','C004','2022-08-10','2022-08-16' FROM DUAL UNION ALL
		SELECT '1647850','C004','2022-08-11','2022-08-24' FROM DUAL UNION ALL
		SELECT '3074563','C004','2022-08-12','2022-08-21' FROM DUAL UNION ALL
		SELECT '3022558','C005','2022-08-14','2022-08-25' FROM DUAL UNION ALL
		SELECT '1324665','C005','2022-08-15','2022-08-26' FROM DUAL UNION ALL
		SELECT '1650431','C005','2022-08-16','2022-08-22' FROM DUAL UNION ALL
		SELECT '1652368','C005','2022-08-17','2022-08-24' FROM DUAL UNION ALL
		SELECT '3665232','C005','2022-08-18','2022-08-29' FROM DUAL UNION ALL
		SELECT '1584553','C006','2022-08-21','2022-08-26' FROM DUAL UNION ALL
		SELECT '1466333','C006','2022-08-22','2022-08-26' FROM DUAL UNION ALL
		SELECT '3074563','C006','2022-08-24','2022-08-29' FROM DUAL UNION ALL
		SELECT '1665885','C006','2022-08-26','2022-08-31' FROM DUAL UNION ALL
		SELECT '3022558','C006','2022-08-29','2022-09-10' FROM DUAL UNION ALL
		SELECT '1477444','C007','2022-08-30','2022-09-06' FROM DUAL UNION ALL
		SELECT '3699410','C007','2022-09-03','2022-09-16' FROM DUAL UNION ALL
		SELECT '1654446','C007','2022-09-04','2022-09-11' FROM DUAL UNION ALL
		SELECT '1655876','C008','2022-09-05','2022-09-13' FROM DUAL UNION ALL
		SELECT '1652331','C008','2022-09-06','2022-09-12' FROM DUAL UNION ALL
		SELECT '1654446','C008','2022-09-07','2022-09-20' FROM DUAL UNION ALL
		SELECT '1650431','C009','2022-09-08','2022-09-19' FROM DUAL UNION ALL
		SELECT '3520140','C009','2022-09-10','2022-09-21' FROM DUAL UNION ALL
		SELECT '1654771','C010','2022-09-12','2022-09-22' FROM DUAL UNION ALL
		SELECT '1255448','C010','2022-07-07','2022-07-15' FROM DUAL UNION ALL
		SELECT '1655876','C010','2022-07-13','2022-07-19' FROM DUAL UNION ALL
		SELECT '3054422','C011','2022-07-20','2022-07-29' FROM DUAL UNION ALL
		SELECT '1477444','C011','2022-07-21','2022-08-03' FROM DUAL UNION ALL
		SELECT '1650431','C011','2022-07-22','2022-07-29' FROM DUAL UNION ALL
		SELECT '1255448','C011','2022-07-26','2022-08-01' FROM DUAL UNION ALL
		SELECT '1650426','C011','2022-07-27','2022-08-02' FROM DUAL UNION ALL
		SELECT '1758661','C012','2022-07-30','2022-08-05' FROM DUAL UNION ALL
		SELECT '1477444','C012','2022-08-01','2022-08-09' FROM DUAL UNION ALL
		SELECT '1788453','C012','2022-08-02','2022-08-14' FROM DUAL UNION ALL
		SELECT '3022558','C013','2022-08-03','2022-08-10' FROM DUAL UNION ALL
		SELECT '3074563','C013','2022-08-04','2022-08-12' FROM DUAL UNION ALL
		SELECT '3033326','C013','2022-08-06','2022-08-19' FROM DUAL UNION ALL
		SELECT '3066599','C013','2022-08-07','2022-08-13' FROM DUAL UNION ALL
		SELECT '1666339','C013','2022-08-08','2022-08-14' FROM DUAL UNION ALL
		SELECT '1650287','C014','2022-08-10','2022-08-16' FROM DUAL UNION ALL
		SELECT '1654771','C014','2022-08-11','2022-08-24' FROM DUAL UNION ALL
		SELECT '1654446','C014','2022-08-12','2022-08-21' FROM DUAL UNION ALL
		SELECT '1584553','C015','2022-08-14','2022-08-25' FROM DUAL UNION ALL
		SELECT '3066599','C015','2022-08-15','2022-08-26' FROM DUAL UNION ALL
		SELECT '3014787','C015','2022-08-16','2022-08-22' FROM DUAL UNION ALL
		SELECT '1650431','C015','2022-08-17','2022-08-24' FROM DUAL UNION ALL
		SELECT '3124564','C015','2022-08-18','2022-08-29' FROM DUAL UNION ALL
		SELECT '1324665','C016','2022-08-21','2022-08-26' FROM DUAL UNION ALL
		SELECT '3022558','C016','2022-08-22','2022-08-26' FROM DUAL UNION ALL
		SELECT '1652368','C016','2022-08-24','2022-08-29' FROM DUAL UNION ALL
		SELECT '1650431','C016','2022-08-26','2022-08-31' FROM DUAL UNION ALL
		SELECT '3066599','C016','2022-08-29','2022-09-10' FROM DUAL UNION ALL
		SELECT '2215360','C017','2022-08-30','2022-09-06' FROM DUAL UNION ALL
		SELECT '1788453','C017','2022-09-03','2022-09-16' FROM DUAL UNION ALL
		SELECT '1650431','C017','2022-09-04','2022-09-11' FROM DUAL UNION ALL
		SELECT '3052339','C017','2022-09-05','2022-09-13' FROM DUAL UNION ALL
		SELECT '1584553','C017','2022-09-06','2022-09-12' FROM DUAL UNION ALL
		SELECT '3520140','C018','2022-09-07','2022-09-20' FROM DUAL UNION ALL
		SELECT '1654446','C018','2022-09-08','2022-09-19' FROM DUAL UNION ALL
		SELECT '3074563','C019','2022-09-10','2022-09-21' FROM DUAL UNION ALL
		SELECT '1326654','C019','2022-09-12','2022-09-22' FROM DUAL UNION ALL
		SELECT '1466333','C020','2022-08-29','2022-09-10' FROM DUAL UNION ALL
		SELECT '1655662','C020','2022-08-30','2022-09-06' FROM DUAL
		) E
;

--(12) 연수 정보 테이블 데이터 입력
INSERT INTO TRAINING_INFO (TRAINING_CODE, TRAINING_NAME, TRAINING_SUBJECT, TRAINING_MILEAGE, TRAINING_GRADE)
	SELECT 'T001', 'SQL_기초','IT','10','C' FROM DUAL UNION ALL
	SELECT 'T002', 'SQL_중급','IT','20','B' FROM DUAL UNION ALL
	SELECT 'T003', 'SQL_고급','IT','30','A' FROM DUAL UNION ALL
	SELECT 'T004', 'REACT_기초','IT','10','C' FROM DUAL UNION ALL
	SELECT 'T005', 'REACT_중급','IT','20','B' FROM DUAL UNION ALL
	SELECT 'T006', 'REACT_고급','IT','30','A' FROM DUAL UNION ALL
	SELECT 'T007', '여신1','금융','10','C' FROM DUAL UNION ALL
	SELECT 'T008', '여신2','금융','20','B' FROM DUAL UNION ALL
	SELECT 'T009', '여신3','금융','30','A' FROM DUAL UNION ALL
	SELECT 'T010', '상품판매1','금융','10','C' FROM DUAL UNION ALL
	SELECT 'T011', '상품판매2','금융','20','B' FROM DUAL UNION ALL
	SELECT 'T012', '상품판매3','금융','30','A' FROM DUAL UNION ALL
	SELECT 'T013', '펀드투자1','금융','10','C' FROM DUAL UNION ALL
	SELECT 'T014', '펀드투자2','금융','20','B' FROM DUAL UNION ALL
	SELECT 'T015', '펀드투자3','금융','30','A' FROM DUAL UNION ALL
	SELECT 'T016', 'IB_기초','IB','10','C' FROM DUAL UNION ALL
	SELECT 'T017', 'IB_중급','IB','20','B' FROM DUAL UNION ALL
	SELECT 'T018', 'IB_고급','IB','30','A' FROM DUAL UNION ALL
	SELECT 'T019', '회계','IB','20','B' FROM DUAL UNION ALL
	SELECT 'T020', 'SOC','IB','20','B' FROM DUAL
;

--(13) 연수 수강이력 시퀀스 생성
CREATE SEQUENCE SEQ_TRAINING_HISTORY
	INCREMENT BY 1
	START WITH 1001
	MAXVALUE 9999
	MINVALUE 1
	NOCYCLE NOCACHE
;

--(14) 연수 수강이력 테이블 데이터 입력
INSERT INTO TRAINING_HISTORY (TRAINING_ID, EMPLOYEE_ID, TRAINING_CODE, START_DATE, END_DATE,COMPLETION_STATUS)
	SELECT SEQ_TRAINING_HISTORY.NEXTVAL
	      ,E.*
	FROM (SELECT '1666339','T001','2022-07-07','2022-07-15','1' FROM DUAL UNION ALL
		SELECT '1652368','T001','2022-07-13','2022-07-19','1' FROM DUAL UNION ALL
		SELECT '1647850','T001','2022-07-20','2022-07-29','1' FROM DUAL UNION ALL
		SELECT '1313541','T002','2022-07-21','2022-08-03','1' FROM DUAL UNION ALL
		SELECT '3066599','T002','2022-07-22','2022-07-29','1' FROM DUAL UNION ALL
		SELECT '1313541','T003','2022-07-26','2022-08-01','1' FROM DUAL UNION ALL
		SELECT '3014787','T004','2022-07-27','2022-08-02','1' FROM DUAL UNION ALL
		SELECT '1365427','T004','2022-07-30','2022-08-05','1' FROM DUAL UNION ALL
		SELECT '1650426','T004','2022-08-01','2022-08-09','1' FROM DUAL UNION ALL
		SELECT '3022558','T005','2022-08-02','2022-08-14','1' FROM DUAL UNION ALL
		SELECT '1369637','T005','2022-08-03','2022-08-10','1' FROM DUAL UNION ALL
		SELECT '1647850','T006','2022-08-04','2022-08-12','1' FROM DUAL UNION ALL
		SELECT '3077464','T007','2022-08-06','2022-08-19','1' FROM DUAL UNION ALL
		SELECT '1584553','T007','2022-08-07','2022-08-13','1' FROM DUAL UNION ALL
		SELECT '1466333','T007','2022-08-08','2022-08-14','1' FROM DUAL UNION ALL
		SELECT '1650287','T007','2022-08-10','2022-08-16','1' FROM DUAL UNION ALL
		SELECT '3054422','T008','2022-08-11','2022-08-24','1' FROM DUAL UNION ALL
		SELECT '3699410','T008','2022-08-12','2022-08-21','1' FROM DUAL UNION ALL
		SELECT '1665885','T009','2022-08-14','2022-08-25','1' FROM DUAL UNION ALL
		SELECT '1452334','T010','2022-08-15','2022-08-26','1' FROM DUAL UNION ALL
		SELECT '3052339','T010','2022-08-16','2022-08-22','1' FROM DUAL UNION ALL
		SELECT '2215360','T010','2022-08-17','2022-08-24','1' FROM DUAL UNION ALL
		SELECT '3845123','T010','2022-08-18','2022-08-29','1' FROM DUAL UNION ALL
		SELECT '1452334','T011','2022-08-21','2022-08-26','1' FROM DUAL UNION ALL
		SELECT '1650431','T011','2022-08-22','2022-08-26','1' FROM DUAL UNION ALL
		SELECT '1452334','T012','2022-08-24','2022-08-29','1' FROM DUAL UNION ALL
		SELECT '1458765','T013','2022-08-26','2022-08-31','1' FROM DUAL UNION ALL
		SELECT '2215360','T013','2022-08-29','2022-09-10','1' FROM DUAL UNION ALL
		SELECT '1452334','T013','2022-08-30','2022-09-06','1' FROM DUAL UNION ALL
		SELECT '3033326','T013','2022-09-03','2022-09-16','1' FROM DUAL UNION ALL
		SELECT '3025485','T014','2022-09-04','2022-09-11','1' FROM DUAL UNION ALL
		SELECT '1654771','T014','2022-09-05','2022-09-13','1' FROM DUAL UNION ALL
		SELECT '1652368','T015','2022-09-06','2022-09-12','1' FROM DUAL UNION ALL
		SELECT '3025485','T016','2022-09-07','2022-09-20','1' FROM DUAL UNION ALL
		SELECT '1665885','T016','2022-09-08','2022-09-19','1' FROM DUAL UNION ALL
		SELECT '1324665','T016','2022-09-10','2022-09-21','1' FROM DUAL UNION ALL
		SELECT '2215360','T016','2022-09-12','2022-09-22','1' FROM DUAL UNION ALL
		SELECT '3520140','T016','2022-07-07','2022-07-15','1' FROM DUAL UNION ALL
		SELECT '3052339','T017','2022-07-13','2022-07-19','1' FROM DUAL UNION ALL
		SELECT '3520140','T017','2022-07-20','2022-07-29','1' FROM DUAL UNION ALL
		SELECT '1655876','T017','2022-07-21','2022-08-03','1' FROM DUAL UNION ALL
		SELECT '1324665','T017','2022-07-22','2022-07-29','1' FROM DUAL UNION ALL
		SELECT '1584553','T017','2022-07-26','2022-08-01','1' FROM DUAL UNION ALL
		SELECT '3520140','T018','2022-07-27','2022-08-02','1' FROM DUAL UNION ALL
		SELECT '1650426','T018','2022-07-30','2022-08-05','1' FROM DUAL UNION ALL
		SELECT '1313541','T018','2022-08-01','2022-08-09','1' FROM DUAL UNION ALL
		SELECT '3520140','T019','2022-08-02','2022-08-14','1' FROM DUAL UNION ALL
		SELECT '1655662','T019','2022-08-03','2022-08-10','1' FROM DUAL UNION ALL
		SELECT '1255448','T019','2022-08-04','2022-08-12','1' FROM DUAL UNION ALL
		SELECT '1650287','T019','2022-08-06','2022-08-19','1' FROM DUAL UNION ALL
		SELECT '1466333','T019','2022-08-07','2022-08-13','1' FROM DUAL UNION ALL
		SELECT '3054422','T020','2022-08-08','2022-08-14','1' FROM DUAL UNION ALL
		SELECT '1647850','T020','2022-08-10','2022-08-16','1' FROM DUAL UNION ALL
		SELECT '1666339','T020','2022-08-11','2022-08-24','1' FROM DUAL UNION ALL
		SELECT '1255448','T020','2022-08-12','2022-08-21','1' FROM DUAL UNION ALL
		SELECT '1788453','T020','2022-08-14','2022-08-25','1' FROM DUAL
		) E
;

--------------------------------------------------------------------------------------------------------------------
-----------------------------------------------------화면 조회 쿼리-----------------------------------------------------
--------------------------------------------------------------------------------------------------------------------

--(15) 생성 테이블 조회
SELECT * 
FROM EMPLOYEE_INFO;

SELECT * 
FROM DEPARTMENT_INFO;

SELECT * 
FROM CERTIFICATION_INFO;

SELECT * 
FROM CERTIFICATION_HISTORY;

SELECT * 
FROM TRAINING_INFO;

SELECT * 
FROM TRAINING_HISTORY;

--(16) 직원별 정보탭
SELECT E.EMPLOYEE_ID AS 사원번호
      ,E.EMPLOYEE_NAME AS 사원명
      ,D.DEPARTMENT_NAME AS 소속부서
      ,EXTRACT(YEAR FROM SYSDATE) - EXTRACT(YEAR FROM HIRE_DATE) AS 연차
      ,E.JOB_LEVEL AS 직급
      ,E.DUTY AS 직무
      ,CASE WHEN C.상품판매자격 >=1 THEN 'O' ELSE 'X' END AS 상품판매자격
      ,NVL(C.자격증수,0) AS 자격증수
      ,NVL(T.연수마일리지,0) AS 연수마일리지
FROM EMPLOYEE_INFO E
INNER JOIN DEPARTMENT_INFO D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID 
LEFT OUTER JOIN (SELECT C.EMPLOYEE_ID AS EMPLOYEE_ID
	                   ,SUM(CASE WHEN PRODUCT_SALES_QUALIFICATION = '1' THEN 1 ELSE 0 END) AS 상품판매자격
	                   ,COUNT(C.CERTIFICATION_ID) AS 자격증수
	             FROM CERTIFICATION_HISTORY C
	             INNER JOIN CERTIFICATION_INFO CI
	             ON C.CERTIFICATION_CODE = CI.CERTIFICATION_CODE
	             WHERE CI.CERTIFICATION_TYPE = 'IT'
	             GROUP BY C.EMPLOYEE_ID) C
ON E.EMPLOYEE_ID = C.EMPLOYEE_ID
LEFT OUTER JOIN (SELECT T.EMPLOYEE_ID
                       ,SUM(TI.TRAINING_MILEAGE) AS 연수마일리지
				 FROM TRAINING_HISTORY T
	             INNER JOIN TRAINING_INFO TI
	             ON T.TRAINING_CODE = TI.TRAINING_CODE
	             GROUP BY T.EMPLOYEE_ID) T
ON E.EMPLOYEE_ID = T.EMPLOYEE_ID
--WHERE E.EMPLOYEE_NAME IN (SELECT EMPLOYEE_NAME
--						  FROM(SELECT EI.EMPLOYEE_NAME
--	                                 ,COUNT(CH.CERTIFICATION_ID) AS 자격증수
--	                           FROM CERTIFICATION_HISTORY CH
--	                           INNER JOIN EMPLOYEE_INFO EI
--	                           ON CH.EMPLOYEE_ID = EI.EMPLOYEE_ID
--	                           INNER JOIN CERTIFICATION_INFO CI
--	                           ON CH.CERTIFICATION_CODE  = CI.CERTIFICATION_CODE 
--	                           WHERE CI.CERTIFICATION_TYPE = 'IT'
--	                           GROUP BY EI.EMPLOYEE_NAME
--	                           )
--	                       WHERE 자격증수 >= 2
--                           )
-- IT 자격증 2개 이상을 가지고 있는 직원 조회 (조건검색)
;


--(17) 자격증별 조회 탭 쿼리
SELECT CI.CERTIFICATION_CODE AS 자격증코드
   , CI.CERTIFICATION_NAME AS 자격증명
   , CI.CERTIFICATION_TYPE AS 자격유형
   , CASE WHEN CI.PRODUCT_SALES_QUALIFICATION = '1' THEN 'Y' ELSE 'N' END AS 상품판매자격여부
   , TO_CHAR(CH.ACQUISITION_DATE, 'YYYY/MM/DD') AS 취득일
   , TO_CHAR(CH.REGISTRATION_DATE, 'YYYY/MM/DD') AS 등록일
   , E.EMPLOYEE_NAME AS 사원명
   , E.EMPLOYEE_ID AS 사원번호
   , E.DEPARTMENT_NAME AS 소속부서
FROM CERTIFICATION_HISTORY CH 
INNER JOIN (SELECT EI.EMPLOYEE_ID 
	            , EI.EMPLOYEE_NAME 
	            , DI.DEPARTMENT_NAME 
	         FROM EMPLOYEE_INFO ei
	         INNER JOIN DEPARTMENT_INFO di 
	         ON EI.DEPARTMENT_ID = DI.DEPARTMENT_ID) E
ON CH.EMPLOYEE_ID = E.EMPLOYEE_ID 
LEFT OUTER JOIN CERTIFICATION_INFO CI
ON CH.CERTIFICATION_CODE = CI.CERTIFICATION_CODE 
--WHERE E.EMPLOYEE_NAME IN (SELECT EMPLOYEE_NAME
--						  FROM(SELECT EI.EMPLOYEE_NAME
--	                                 ,COUNT(CH.CERTIFICATION_ID) AS 자격증수
--	                           FROM CERTIFICATION_HISTORY CH
--	                           INNER JOIN EMPLOYEE_INFO EI
--	                           ON CH.EMPLOYEE_ID = EI.EMPLOYEE_ID
--	                           INNER JOIN CERTIFICATION_INFO CI
--	                           ON CH.CERTIFICATION_CODE  = CI.CERTIFICATION_CODE 
--	                           WHERE CI.CERTIFICATION_TYPE = 'IT'
--	                           GROUP BY EI.EMPLOYEE_NAME
--	                           )
--	                       WHERE 자격증수 >= 2
--                           )
--AND CI.CERTIFICATION_TYPE ='IT'
; --IT 자격증 2개 이상을 가지고 있는 직원 조회 (조건검색)

--(18) 연수별 조회 탭 쿼리
SELECT TH. TRAINING_CODE AS 연수코드
      ,TI.TRAINING_NAME AS 연수명
      ,TI.TRAINING_SUBJECT AS 연수분야
      ,TO_CHAR(TH.START_DATE,'YYYY-MM-DD') AS 연수시작일자
      ,TO_CHAR(TH.END_DATE,'YYYY-MM-DD') AS 연수종료일자
      ,E.EMPLOYEE_ID AS 사원명
      ,E.EMPLOYEE_NAME AS 사원번호
      ,E.DEPARTMENT_NAME AS 소속부서
FROM TRAINING_HISTORY TH 
INNER JOIN ( SELECT EI.EMPLOYEE_ID
         ,EI.EMPLOYEE_NAME
         ,DI.DEPARTMENT_NAME 
          FROM EMPLOYEE_INFO ei
          INNER JOIN DEPARTMENT_INFO di 
          ON ei.DEPARTMENT_ID = di.DEPARTMENT_ID 
         ) E
ON TH.EMPLOYEE_ID = E.EMPLOYEE_ID
LEFT OUTER JOIN TRAINING_INFO TI 
ON TH.TRAINING_CODE = TI.TRAINING_CODE
WHERE E.EMPLOYEE_ID=2215360
; 









