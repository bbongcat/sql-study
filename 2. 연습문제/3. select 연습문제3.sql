

-- �ǽ� ����

-- 1. employees���̺��� �� ����� �μ��� �μ� ��ȣ(department_id)�� ��� �޿�(salary)�� ��ȸ�ϼ���. 
SELECT
    NVL(DEPARTMENT_ID, 0), ROUND(AVG(SALARY), 2) AS "Salary Average"
FROM employees
GROUP BY DEPARTMENT_ID;

-- 2. employees���̺��� �μ��� �μ� ��ȣ(department_id)�� �μ��� �� ��� ���� ��ȸ�ϼ���.
SELECT
    NVL(DEPARTMENT_ID, 0),
    count(*) AS "�� ��� ��"
FROM employees
GROUP BY DEPARTMENT_ID;

-- 3. employees���̺��� �μ��� �޿� ����� 8000�� �ʰ��ϴ� �μ��� �μ���ȣ�� �޿� ����� ��ȸ�ϼ���.
SELECT
    NVL(DEPARTMENT_ID, 0), ROUND(AVG(SALARY), 2) AS "Salary Average"
FROM employees
GROUP BY DEPARTMENT_ID
HAVING ROUND(AVG(SALARY), 2) > 8000;

-- 4. employees���̺��� �޿� ����� 8000�� �ʰ��ϴ� �� ����(job_id)�� ���Ͽ� 
--    ���� �̸�(job_id)�� SA�� �����ϴ� ����� �����ϰ� ���� �̸��� �޿� ����� 
--    �޿� ����� ���� ������ �����Ͽ� ��ȸ�ϼ���.
SELECT
    JOB_ID,
    ROUND(AVG(SALARY), 2) AS "�޿� ���"
FROM employees
WHERE JOB_ID NOT LIKE 'SA%'
GROUP BY JOB_ID
HAVING ROUND(AVG(SALARY), 2) > 8000
ORDER BY ROUND(AVG(SALARY), 2) DESC;


-- �߰� ����
-- COUNT(*)�� NULL�� ������ ���� ����
-- ������ �����Լ��� NULL�� ���� ���
SELECT * FROM employees;
SELECT COUNT(*) FROM EMPLOYEES;
SELECT COUNT(commission_pct) FROM EMPLOYEES;

-- ��ü ����� ���ʽ������ �ƴ�, ���ʽ��� ���� ����� ����� �� ���
SELECT
    ROUND(AVG(SALARY * commission_pct), 2) AS AVG_BONUS
FROM employees; -- AVG�� NULL�� �������� �����Ƿ� �� ������ �ƴ� 35�� ���

-- ���� ��� ��� : NULL�� 0���� ��ü�Ͽ� ���
SELECT
    ROUND(AVG(NVL(SALARY * commission_pct, 0)), 2) AS AVG_BONUS
FROM employees;
