

-- CASE ǥ���� DECODE �Լ�
SELECT
    CASE WHEN sal_cd = '100001' THEN '�⺻��'
         WHEN sal_cd = '100002' THEN '�󿩱�'
         WHEN sal_cd = '100003' THEN 'Ư���󿩱�'
         WHEN sal_cd = '100004' THEN '�߱ټ���'
         WHEN sal_cd = '100005' THEN '�ָ�����'
         WHEN sal_cd = '100006' THEN '���ɽĴ�'
         WHEN sal_cd = '100007' THEN '��������Ʈ'
         ELSE '��ȿ���� ����'
         END sal_name
FROM tb_sal;

-- DECODE �Լ��� ������ �� �������� ����
SELECT DECODE(SAL_CD, '100001', '�⺻��', '100002', '�󿩱�', '��Ÿ') AS SAL_NAME
FROM TB_SAL;


-- # �� ���� �Լ�
-- NVL(expr1, expr2)
-- expr1 : null�� ������ �� �ִ� ���̳� ǥ����
-- expr2 : expr1�� null�� ��� ����� ��

SELECT
    NVL(direct_manager_emp_no, '�ֻ�����') AS ������
FROM TB_EMP
WHERE DIRECT_MANAGER_EMP_NO IS NULL;

SELECT
    NVL(UPPER_DEPT_CD, '�ֻ����μ�') AS �����μ�
FROM TB_DEPT
WHERE UPPER_DEPT_CD IS NULL;

SELECT
    NVL(MAX(EMP_NM), '�������') AS EMP_NM
FROM TB_EMP
WHERE EMP_NM = '��ȸ��';

SELECT
    NVL(MAX(EMP_NM), '�������') AS EMP_NM
FROM TB_EMP
WHERE EMP_NM = '����ȣ';


-- NVL2 (expr1, expr2, expr3)
-- expr1�� ���� null�� �ƴϸ� expr2�� ��ȯ, null�̸� expr3�� ��ȯ
SELECT
    emp_nm,
    NVL2(direct_manager_emp_no, '�Ϲݻ��', 'ȸ���') AS ����
FROM TB_EMP;


-- COALESCE(expr1, ...)
-- ���� ǥ���� �� null�� �ƴ� ���� ���ʷ� �߰ߵǸ� �ش� ���� ����
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
-- �� ���� ������ null ����, �ٸ��� expr1 ����
SELECT
    NULLIF('����ȣ', '������')
FROM DUAL;

SELECT
    NULLIF('����ȣ', '����ȣ')
FROM DUAL;


-- # GROUP BY, HAVING��
-- 1. �����Լ�
SELECT
    MAX(BIRTH_DE) AS "���� � ���",
    MIN(BIRTH_DE) AS "���� ���� ���� ���",
    COUNT(*) AS "�� ��� ��"
FROM TB_EMP;


-- 2. GROUP BY��
SELECT
    A.DEPT_CD,
    (SELECT L.DEPT_NM FROM TB_DEPT L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM,
    MAX(A.BIRTH_DE) AS "���� ���� �������",
    MIN(A.BIRTH_DE) AS "���� ���� �������",
    COUNT(*) AS "������"
FROM TB_EMP A
GROUP BY A.DEPT_CD
ORDER BY A.DEPT_CD ASC;


-- 3. HAVING��
SELECT
    A.DEPT_CD,
    (SELECT L.DEPT_NM FROM TB_DEPT L WHERE L.DEPT_CD = A.DEPT_CD) AS DEPT_NM,
    MAX(A.BIRTH_DE) AS "���� ���� �������",
    MIN(A.BIRTH_DE) AS "���� ���� �������",
    COUNT(*) AS "������"
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


-- ���� �������� 5
SELECT 1, 2 FROM DUAL WHERE 1=2;

SELECT NVL(1, 0) FROM DUAL WHERE 1=2;

SELECT NVL(MAX(1), 1) FROM DUAL WHERE 1=2;

SELECT MAX(NVL(1, 1)) FROM DUAL WHERE 1=2;