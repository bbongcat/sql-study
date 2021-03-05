

-- 실습 문제

-- 1. employees테이블에서 각 사원의 부서별 부서 번호(department_id)와 평균 급여(salary)를 조회하세요. 
SELECT
    NVL(DEPARTMENT_ID, 0), ROUND(AVG(SALARY), 2) AS "Salary Average"
FROM employees
GROUP BY DEPARTMENT_ID;

-- 2. employees테이블에서 부서별 부서 번호(department_id)와 부서별 총 사원 수를 조회하세요.
SELECT
    NVL(DEPARTMENT_ID, 0),
    count(*) AS "총 사원 수"
FROM employees
GROUP BY DEPARTMENT_ID;

-- 3. employees테이블에서 부서의 급여 평균이 8000을 초과하는 부서의 부서번호와 급여 평균을 조회하세요.
SELECT
    NVL(DEPARTMENT_ID, 0), ROUND(AVG(SALARY), 2) AS "Salary Average"
FROM employees
GROUP BY DEPARTMENT_ID
HAVING ROUND(AVG(SALARY), 2) > 8000;

-- 4. employees테이블에서 급여 평균이 8000을 초과하는 각 직무(job_id)에 대하여 
--    직무 이름(job_id)가 SA로 시작하는 사원은 제외하고 직무 이름과 급여 평균을 
--    급여 평균이 높은 순서로 정렬하여 조회하세요.
SELECT
    JOB_ID,
    ROUND(AVG(SALARY), 2) AS "급여 평균"
FROM employees
WHERE JOB_ID NOT LIKE 'SA%'
GROUP BY JOB_ID
HAVING ROUND(AVG(SALARY), 2) > 8000
ORDER BY ROUND(AVG(SALARY), 2) DESC;


-- 추가 사항
-- COUNT(*)은 NULL을 포함한 수를 세줌
-- 나머지 집계함수는 NULL을 빼고 계산
SELECT * FROM employees;
SELECT COUNT(*) FROM EMPLOYEES;
SELECT COUNT(commission_pct) FROM EMPLOYEES;

-- 전체 사원의 보너스평균이 아님, 보너스를 받은 사람만 평균을 낸 결과
SELECT
    ROUND(AVG(SALARY * commission_pct), 2) AS AVG_BONUS
FROM employees; -- AVG는 NULL을 포함하지 않으므로 전 직원이 아닌 35명만 계산

-- 옳은 계산 결과 : NULL을 0으로 대체하여 계산
SELECT
    ROUND(AVG(NVL(SALARY * commission_pct, 0)), 2) AS AVG_BONUS
FROM employees;
