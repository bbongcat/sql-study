
-- # 다중행 서브쿼리 연산자 정리
-- 1. IN: 목록의 어떤 값과 같은지 확인
-- 2. ANY, SOME: 값을 서브쿼리에 의해 리턴된 값 목록과 비교하는데 하나라도 만족하면 됨
-- 3. ALL: 값을 서브쿼리에 의해 리턴된 값 목록과 비교하는데 모든 값을 만족해야 함
-- 4. EXISTS: 결과를 만족하는 값이 존재하는지의 여부를 확인 (존재한다면~)

-- ## ALL과 ANY의 차이점
-- * < ANY : 가장 큰 값보다 작으면 됨
-- * > ANY : 가장 작은 값보다 크면 됨
-- * < ALL : 가장 작은 값보다 작으면 됨
-- * > ALL : 가장 큰 값보다 크면 됨
-- * = ANY : IN 과 같은 역할

-- ANY, SOME : 모든 david 중 가장 월급이 작은 david보다 월급이 큰 애들 조회
-- ALL : 모든 david 중 가장 월급이 큰 david보다 월급이 큰 애들 조회
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (
                    SELECT SALARY
                    FROM EMPLOYEES
                    WHERE FIRST_NAME = 'David'
                );

-- 스칼라 서브쿼리 추가 예제
-- 모든 사원의 이름과 부서 이름을 조회

-- 조인 방식
SELECT
    E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- 스칼라 서브쿼리 방식 (조인의 남발을 막기 위해 씀. 성능 상 조인보다 유리)
SELECT
    E.FIRST_NAME,
    (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPT_NAME
FROM EMPLOYEES E;


-- # 실습 문제
-- 1. EMPLOYEES 테이블에서 NANCY보다 많은 급여를 받는 사원의 FIRST_NAME과 SALARY를 조회하세요.

SELECT
    FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >=
(
        SELECT SALARY
        FROM EMPLOYEES
        WHERE FIRST_NAME = 'Nancy'
);

-- 2. EMPLOYEES 테이블에서 David와 같은 부서의 근무하는 사원의
-- 이름(FIRST_NAME), 부서번호(DEPARTMENT_ID), 직무(JOB_ID)를 조회

SELECT
    FIRST_NAME, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ANY (
                            SELECT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE FIRST_NAME = 'David'
                          );







