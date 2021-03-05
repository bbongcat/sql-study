

-- CASE 표현과 DECODE 함수
SELECT
    CASE WHEN sal_cd = '100001' THEN '기본급'
         WHEN sal_cd = '100002' THEN '상여급'
         WHEN sal_cd = '100003' THEN '특별상여급'
         WHEN sal_cd = '100004' THEN '야근수당'
         WHEN sal_cd = '100005' THEN '주말수당'
         WHEN sal_cd = '100006' THEN '점심식대'
         WHEN sal_cd = '100007' THEN '복지포인트'
         ELSE '유효하지 않음'
         END sal_name
FROM tb_sal;

-- DECODE 함수는 조건이 두 개까지만 가능
SELECT DECODE(SAL_CD, '100001', '기본급', '100002', '상여급', '기타') AS SAL_NAME
FROM TB_SAL;


-- # 널 관련 함수
-- NVL(expr1, expr2)
-- expr1 : null을 포함할 수 있는 값이나 표현식
-- expr2 : expr1이 null일 경우 사용할 값

SELECT
    NVL(direct_manager_emp_no, '최상위자') AS 관리자
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NULL;

SELECT
    NVL(UPPER_DEPT_CD, '최상위부서') AS 상위부서
FROM TB_DEPT
WHERE UPPER_DEPT_CD IS NULL;

SELECT
    NVL(MAX(EMP_NM), '존재안함') AS EMP_NM
FROM TB_EMP
WHERE EMP_NM = '김회장';

SELECT
    NVL(MAX(EMP_NM), '존재안함') AS EMP_NM
FROM TB_EMP
WHERE EMP_NM = '박찬호';


-- NVL2 (expr1, expr2, expr3)
-- expr1의 값이 null이 아니면 expr2를 반환, null이면 expr3을 반환
SELECT
    emp_nm,
    NVL2(direct_manager_emp_no, '일반사원', '회장님') AS 직위
FROM TB_EMP;


-- COALESCE(expr1, ...)
-- 많은 표현식 중 null이 아닌 값이 최초로 발견되면 해당 값을 리턴
SELECT
    COALESCE(NULL, NULL, 0) AS SAL
FROM DUAL;

SELECT
    COALESCE(5000, NULL, 0) AS SAL
FROM DUAL;

SELECT
    COALESCE(NULL, 6000, 0) AS SAL
FROM DUAL;


-- NULLIF(expr1, expr2)
-- 두 값이 같으면 null 리턴, 다르면 expr1 리턴
SELECT
    NULLIF('박찬호', '박지성')
FROM DUAL;

SELECT
    NULLIF('박찬호', '박찬호')
FROM DUAL;


-- # GROUP BY, HAVING절
-- 1. 집계함수
SELECT
    MAX(BIRTH_DE) AS "가장 어린 사람",
    MIN(BIRTH_DE) AS "가장 나이 많은 사람",
    COUNT(*) AS "총 사원 수"
FROM TB_EMP;


-- 2. GROUP BY절
SELECT
    A.DEPT_CD,
    (SELECT L.DEPT_NM FROM TB_DEPT L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM,
    MAX(A.BIRTH_DE) AS "가장 늦은 생년월일",
    MIN(A.BIRTH_DE) AS "가장 빠른 생년월일",
    COUNT(*) AS "직원수"
FROM TB_EMP A
GROUP BY A.DEPT_CD
ORDER BY A.DEPT_CD ASC;


-- 3. HAVING절
SELECT
    A.DEPT_CD,
    (SELECT L.DEPT_NM FROM TB_DEPT L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM,
    MAX(A.BIRTH_DE) AS "가장 늦은 생년월일",
    MIN(A.BIRTH_DE) AS "가장 빠른 생년월일",
    COUNT(*) AS "직원수"
FROM TB_EMP A
GROUP BY A.DEPT_CD
HAVING COUNT(*) >= 2
ORDER BY A.DEPT_CD ASC;

SELECT
    a.emp_no,
    (SELECT L.EMP_NM FROM TB_EMP L WHERE L.EMP_NO = A.EMP_NO) AS EMP_NM,
    MAX(A.PAY_AMT) AS MAX_PAY_AMT,
    MIN(A.PAY_AMT) AS MIN_PAY_AMT,
    ROUND(AVG(A.PAY_AMT), 2) AS AVG_PAY_AMT
FROM TB_SAL_HIS A
WHERE A.PAY_DE BETWEEN '20190101' AND '20191231'
GROUP BY A.EMP_NO
HAVING ROUND(AVG(A.PAY_AMT), 2) >= 4700000
ORDER BY A.EMP_NO;


-- 교안 연습문제 5
SELECT 1, 2 FROM DUAL WHERE 1=2;

SELECT NVL(1, 0) FROM DUAL WHERE 1=2;

SELECT NVL(MAX(1), 1) FROM DUAL WHERE 1=2;

SELECT MAX(NVL(1, 1)) FROM DUAL WHERE 1=2;