

-- ORDER BY ����
SELECT
    CERTI_CD, CERTI_NM, ISSUE_INSTI_NM
FROM TB_CERTI
ORDER BY CERTI_NM DESC;

SELECT
    CERTI_CD, CERTI_NM, ISSUE_INSTI_NM
FROM TB_CERTI
ORDER BY 2 DESC;


SELECT
    EMP_NO, EMP_NM, BIRTH_DE, ADDR, TEL_NO,
    direct_manager_emp_no
FROM TB_EMP
WHERE BIRTH_DE LIKE '196%'
ORDER BY DIRECT_MANAGER_EMP_NO DESC;


-- SELECT ���� �������� ���� Į��(CERTI_NM)�� �������� ORDER BY�ص� ���� �����
SELECT
    CERTI_CD
    ,ISSUE_INSTI_NM
FROM TB_CERTI
ORDER BY CERTI_NM DESC;


SELECT * FROM TB_EMP;
SELECT * FROM TB_DEPT;
SELECT * FROM TB_EMP_CERTI;




-- JOIN ����
SELECT
    A.EMP_NO
    ,A.EMP_NM
    ,A.DEPT_CD
    ,B.DEPT_NM
FROM TB_EMP A, TB_DEPT B
WHERE A.DEPT_CD = B.DEPT_CD
    AND B.DEPT_NM = '��ȹ��';


SELECT
    A.EMP_NO
    ,A.EMP_NM
    ,B.DEPT_NM
    ,C.CERTI_CD
FROM TB_EMP A,
    TB_DEPT B,
    TB_EMP_CERTI C
WHERE A.DEPT_CD = B.DEPT_CD
    AND A.EMP_NO = C.EMP_NO
    AND B.DEPT_NM = '��������';


SELECT
    A.EMP_NO
    ,A.EMP_NM
    ,B.DEPT_NM
    ,C.CERTI_CD
    ,D.CERTI_NM
FROM TB_EMP A,
    TB_DEPT B,
    TB_EMP_CERTI C,
    TB_CERTI D
WHERE A.DEPT_CD = B.DEPT_CD
    AND A.EMP_NO = C.EMP_NO
    AND C.CERTI_CD = D.CERTI_CD;
    

-- # INNER JOIN = EQUI JOIN
-- 1. 2�� �̻��� ���̺��� ����Ǵ� �÷��� ���� �������� ���յǴ� ���α��
-- 2. WHERE ���� ���� �÷����� �������(=)�� ���� �񱳵ȴ�

SELECT
    A.EMP_NO, A.EMP_NM, A.ADDR,
    B.DEPT_CD, B.DEPT_NM
FROM TB_EMP A, TB_DEPT B
WHERE A.DEPT_CD = B.DEPT_CD
    AND A.ADDR LIKE '%�ϻ�%'
ORDER BY A.EMP_NO;


-- # NATURAL JOIN
-- 1. NATURAL JOIN�� ������ �̸��� ���� �÷��鿡 ���� ������ ��
-- 2. �� �ڵ����� �� ���̺��� ���� �̸��� ���� �÷��� ���� INNER JOIN�� ������
-- 3. �� ��, ���� �÷��� ������ Ÿ���� ���ƾ� �ϸ�, ALIAS�� ���̺� ��� ���� ���λ縦 ���� �� ����
-- 4. SELECT * ������ ����ϸ� ���� �÷���� �ڵ� �����ϸ�, ���� �÷����� ��� ���տ��� �� ���� ǥ����

SELECT * FROM TB_EMP;
SELECT * FROM TB_DEPT;


SELECT
    *
FROM TB_EMP A NATURAL JOIN TB_DEPT B;

SELECT
    A.EMP_NO, A.EMP_NM, DEPT_CD, B.DEPT_NM -- ���� �÷��� DEPT_CD���� ���� �ĺ��� ������ �� ��
FROM TB_EMP A NATURAL JOIN TB_DEPT B;


-- # USING �� ����
-- 1. NATURAL ���ο����� �ڵ����� �̸��� ��ġ�ϴ� ��� �÷��鿡 ���� ������ �̷��������
--    USING ���� ����ϸ� ���ϴ� �÷��� ���ؼ��� ���������� EQUI������ �����ϴ�
-- 2. USING �������� ���� �÷��� ���ؼ� ALIAS�� ���̺� ��� ���� ���λ縦 ���� �� ����

SELECT
    A.EMP_NO
    ,A.EMP_NM
    ,A.ADDR
    ,DEPT_CD
    ,B.DEPT_NM
FROM TB_EMP A
JOIN TB_DEPT B USING (DEPT_CD);


-- # JOIN ON ��
-- 1. ���� ���� ������(ON��) �Ϲ� ���� ������(WHERE��)�� �и��ؼ� �ۼ��ϱ� ���� ���
-- 2. ON���� ����ϸ� JOIN ���Ŀ� �� �����̳� ���������� ���� �߰� ������ �� �� �ִ�

SELECT
    A.EMP_NO, A.EMP_NM, A.ADDR,
    B.DEPT_CD, B.DEPT_NM
FROM TB_EMP A
JOIN TB_DEPT B
ON A.DEPT_CD = B.DEPT_CD
WHERE A.ADDR LIKE '%�ϻ�%'
ORDER BY A.EMP_NO;




