

-- # ������ ���� �߰� ����
SELECT EMPLOYEE_ID, FIRST_NAME, MANAGER_ID
FROM EMPLOYEES;

SELECT
    EMPLOYEE_ID,
    LPAD(' ', 4*(LEVEL-1)) || FIRST_NAME || ' ' || LAST_NAME AS "NAME",
    LEVEL
FROM EMPLOYEES
START WITH MANAGER_ID IS NULL
-- CONNECT BY PRIOR �ڽ� = �θ�
CONNECT BY PRIOR EMPLOYEE_ID = MANAGER_ID
ORDER SIBLINGS BY first_name ASC;



-- # �ǽ�����
-- 1. EMPLOYEES ���̺��� �Ի���(HIRE_DATE)�� 04���̰ų�
--    �μ���ȣ(DEPARTMENT_ID)�� 20���� ����� ������̵�(EMPLOYEE_ID)�� �̸�(FIRST_NAME)�� ��ȸ�ϼ���.
--    UNION ����� ��!
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.hire_date LIKE '04%'
UNION
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.DEPARTMENT_ID LIKE '20';



-- 2. employees ���̺��� �Ի���(hire_date)�� 04���̰�
--    �μ���ȣ(department_id)�� 20���� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    INTERSECT�� ����� ��!
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.hire_date LIKE '04%'
INTERSECT
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.DEPARTMENT_ID LIKE '20';

-- 3. employees ���̺��� �Ի���(hire_date)�� 04�⿡ �Ի��Ͽ�����
--    �μ���ȣ(department_id)�� 20���� �ƴ� ����� ������̵�(employee_id)�� �̸�(first_name)�� ��ȸ�ϼ���.
--    MINUS�� ����� ��!
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.hire_date LIKE '04%'
MINUS
SELECT
    EMPLOYEE_ID, FIRST_NAME
FROM EMPLOYEES A
WHERE a.DEPARTMENT_ID LIKE '20';

