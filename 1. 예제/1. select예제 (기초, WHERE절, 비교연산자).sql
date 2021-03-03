
-- SELECT [DISTINCT] { 열이름 .... } 
-- FROM  테이블 또는 뷰 이름
-- JOIN  테이블 또는 뷰 이름
-- ON    조인 조건
-- WHERE 조회 조건
-- GROUP BY  열을 그룹화
-- HAVING    그룹화 조건
-- ORDER BY  정렬할 열 [ASC | DESC];


-- SELECT 기본
SELECT 
    A.certi_cd, A.certi_nm, A.issue_insti_nm
FROM tb_certi A;

-- DISTINCT : 중복 데이터 제거
SELECT DISTINCT
    issue_insti_nm
FROM tb_certi;

-- 별칭(ALIAS) 지정
SELECT 
    A.certi_cd AS 자격증코드, 
    A.certi_nm AS 자격증이름, 
    A.issue_insti_nm AS 발급기관명
FROM tb_certi A;

-- 합성 연산자를 이용한 데이터 조합 연결
SELECT 
    certi_nm || '(' || certi_cd || ')' || '-' || issue_insti_nm AS 자격증정보
FROM tb_certi;

-- DUAL테이블을 이용한 연산
SELECT
    ( (1+1)*3 ) / 6 AS 연산결과
FROM DUAL;

-- BETWEEN, IN, LIKE
SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE birth_de BETWEEN '19900101' AND '19991231'
;

SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE dept_cd IN ('100004', '100006')
;

SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE emp_nm LIKE '이%'
;

SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE emp_nm LIKE '이%'
    AND dept_cd IN ('100003', '100004', '100006') 
    AND birth_de BETWEEN '19900101' AND '19991231'
;

SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE emp_nm LIKE '이__'
;

SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr,
    NVL(direct_manager_emp_no, '상사없음') AS 직속상사코드
FROM tb_emp
WHERE direct_manager_emp_no IS NULL -- NULL은 = 으로 비교 불가
;

-- 논리연산자 AND, OR, NOT
SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE emp_nm LIKE '이%'
    AND dept_cd IN ('100004', '100006')
    AND NOT ( addr LIKE '%수원시%' OR addr LIKE '%성남시%' )
;

-- 부정 비교연산자
SELECT
    sal_his_no,
    pay_de,
    pay_amt,
    emp_no
FROM tb_sal_his
WHERE pay_de >= '20200501'
    AND pay_de <= '20200531'
    AND NOT pay_amt >= 5500000
;

SELECT
    emp_no,
    emp_nm,
    sex_cd,
    birth_de,
    dept_cd,
    addr
FROM tb_emp
WHERE emp_nm LIKE '이%'
    AND dept_cd IN ('100004', '100006')
    AND sex_cd <> '1'
;
