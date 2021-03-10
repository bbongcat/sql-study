

-- # 계층형 쿼리 추가 예제
SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
FROM EMPLOYEES;

SELECT
    EMPLOYEE_ID,
    LPAD(' ', 4*(LEVEL-1)) || FIRST_NAME || ' ' || LAST_NAME AS "NAME",
    LEVEL
FROM EMPLOYEES
START WITH MANAGER_ID IS NULL
-- CONNECT BY PRIOR 자식 = 부모
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
ORDER SIBLINGS BY first_name ASC;



-- # 실습문제
-- 1. EMPLOYEES 테이블에서 입사일(HIRE_DATE)가 04년이거나
--    부서번호(DEPARTMENT_ID)가 20번인 사람의 사원아이디(EMPLOYEE_ID)와 이름(FIRST_NAME)을 조회하세요.
--    UNION 사용할 것!
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.hire_date LIKE '04%'
UNION
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.DEPARTMENT_ID LIKE '20';



-- 2. employees 테이블에서 입사일(hire_date)가 04년이고
--    부서번호(department_id)가 20번인 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    INTERSECT을 사용할 것!
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.hire_date LIKE '04%'
INTERSECT
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.DEPARTMENT_ID LIKE '20';

-- 3. employees 테이블에서 입사일(hire_date)가 04년에 입사하였지만
--    부서번호(department_id)가 20번이 아닌 사람의 사원아이디(employee_id)와 이름(first_name)을 조회하세요.
--    MINUS을 사용할 것!
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.hire_date LIKE '04%'
MINUS
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.DEPARTMENT_ID LIKE '20';

