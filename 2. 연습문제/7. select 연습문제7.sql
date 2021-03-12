
-- # ������ �������� ������ ����
-- 1. IN: ����� � ���� ������ Ȯ��
-- 2. ANY, SOME: ���� ���������� ���� ���ϵ� �� ��ϰ� ���ϴµ� �ϳ��� �����ϸ� ��
-- 3. ALL: ���� ���������� ���� ���ϵ� �� ��ϰ� ���ϴµ� ��� ���� �����ؾ� ��
-- 4. EXISTS: ����� �����ϴ� ���� �����ϴ����� ���θ� Ȯ�� (�����Ѵٸ�~)

-- ## ALL�� ANY�� ������
-- * < ANY : ���� ū ������ ������ ��
-- * > ANY : ���� ���� ������ ũ�� ��
-- * < ALL : ���� ���� ������ ������ ��
-- * > ALL : ���� ū ������ ũ�� ��
-- * = ANY : IN �� ���� ����

-- ANY, SOME : ��� david �� ���� ������ ���� david���� ������ ū �ֵ� ��ȸ
-- ALL : ��� david �� ���� ������ ū david���� ������ ū �ֵ� ��ȸ
SELECT FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > ANY (
                    SELECT SALARY
                    FROM EMPLOYEES
                    WHERE FIRST_NAME = 'David'
                );

-- ��Į�� �������� �߰� ����
-- ��� ����� �̸��� �μ� �̸��� ��ȸ

-- ���� ���
SELECT
    E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E
JOIN DEPARTMENTS D
ON E.DEPARTMENT_ID = D.DEPARTMENT_ID;

-- ��Į�� �������� ��� (������ ������ ���� ���� ��. ���� �� ���κ��� ����)
SELECT
    E.FIRST_NAME,
    (SELECT D.DEPARTMENT_NAME FROM DEPARTMENTS D WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID) AS DEPT_NAME
FROM EMPLOYEES E;


-- # �ǽ� ����
-- 1. EMPLOYEES ���̺��� NANCY���� ���� �޿��� �޴� ����� FIRST_NAME�� SALARY�� ��ȸ�ϼ���.

SELECT
    FIRST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >=
(
        SELECT SALARY
        FROM EMPLOYEES
        WHERE FIRST_NAME = 'Nancy'
);

-- 2. EMPLOYEES ���̺��� David�� ���� �μ��� �ٹ��ϴ� �����
-- �̸�(FIRST_NAME), �μ���ȣ(DEPARTMENT_ID), ����(JOB_ID)�� ��ȸ

SELECT
    FIRST_NAME, DEPARTMENT_ID, JOB_ID
FROM EMPLOYEES
WHERE DEPARTMENT_ID = ANY (
                            SELECT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE FIRST_NAME = 'David'
                          );







