

-- # 서브 쿼리
-- ## 서브 쿼리를 사용할 수 있는 곳
-- [ select절 (스칼라 서브쿼리), from절 (인라인 뷰),
-- where, having, order by, insert의 value절, update set절 ]

-- ## 서브쿼리 사용 유의점
-- 1. 반드시 괄호로 감쌀 것!
-- 2. 비교연산자 오른쪽에 위치시킬 것! (ex. oo = xx에서 xx의 자리에 위치할 것)
-- 3. 서브쿼리에 order by를 사용할 수 없음!
-- 4. 단일 행 서브쿼리에는 단일 행 연산자만, 다중 행 서브쿼리에는 다중 행 연산자를 사용!


-- # 단일 행 서브쿼리

-- 사원번호가 1000000005번인 사원이 속한 부서의 모든 직원 정보
SELECT EMP_NO, EMP_NM, DEPT_CD
FROM TB_EMP
WHERE DEPT_CD =
(
        SELECT DEPT_CD
        FROM TB_EMP
        WHERE EMP_NO = '1000000005'
);

-- 20150525에 받은 급여가 회사 전체 평균 급여보다 높은 사원들의 정보 조회
SELECT
    A.EMP_NO, B.EMP_NM, A.PAY_DE, A.PAY_AMT
FROM TB_SAL_HIS A
INNER JOIN TB_EMP B
ON A.EMP_NO = B.EMP_NO
WHERE A.PAY_DE = '20200525'
    AND A.PAY_AMT >= (
                        SELECT AVG(S.PAY_AMT)
                        FROM TB_SAL_HIS S
                        WHERE S.PAY_DE = '20200525'
                      );


-- # 다중 행 서브쿼리
-- 서브쿼리 조회 건수가 다중 행인 것 (IN, ANY, ALL, EXISTS)

-- 한국데이터베이스진흥원에서 발급한 자격증을 가지고 있는 사원번호와 자격증 개수를 조회
SELECT
    EMP_NO, COUNT(*) CNT
FROM TB_EMP_CERTI
WHERE CERTI_CD IN (
                    SELECT CERTI_CD
                    FROM TB_CERTI
                    WHERE ISSUE_INSTI_NM = '한국데이터베이스진흥원'
                  )
GROUP BY EMP_NO
ORDER BY EMP_NO;

-- 부서원이 2명 이상인 부서 중에서 각 부서의 가장 나이 많은 사람의 정보를 조회
SELECT
    A.EMP_NO, A.EMP_NM, A.DEPT_CD, B.DEPT_NM, A.BIRTH_DE
FROM TB_EMP A
INNER JOIN TB_DEPT B
ON A.DEPT_CD = B.DEPT_CD
WHERE (A.DEPT_CD, A.BIRTH_DE) IN (
                                    SELECT
                                        E.DEPT_CD, MIN(E.BIRTH_DE) AS MIN_BIRTH
                                    FROM TB_EMP E
                                    GROUP BY E.DEPT_CD
                                    HAVING COUNT(*) > 1
                                  )
ORDER BY A.EMP_NO;

-- 주소가 강남인 직원들의 부서정보를 조회
SELECT A.DEPT_CD, A.DEPT_NM
FROM TB_DEPT A
WHERE EXISTS (
                SELECT 1 FROM TB_EMP K WHERE K.DEPT_CD = A.DEPT_CD
                                         AND K.ADDR LIKE '%강남%'
             );


-- # 스칼라 서브쿼리
SELECT
    A.EMP_NO,
    (SELECT L.EMP_NM FROM TB_EMP L WHERE L.EMP_NO = A.EMP_NO) AS EMP_NM,
    A.CERTI_CD,
    (SELECT C.CERTI_NM FROM TB_CERTI C WHERE C.CERTI_CD = A.CERTI_CD) AS CERTI_NM
FROM TB_EMP_CERTI A
WHERE CERTI_CD IN (
                    SELECT K.CERTI_CD
                    FROM TB_CERTI K
                    WHERE K.ISSUE_INSTI_NM = '한국데이터베이스진흥원'
                  )
ORDER BY CERTI_NM;
