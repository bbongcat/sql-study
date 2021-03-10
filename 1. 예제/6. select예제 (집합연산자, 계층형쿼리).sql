

-- # ���� ������
-- ## UNION
-- 1. ���п����� �����հ� ���� �ǹ�
-- 2. ù ��° ������ �� ��° ������ �ߺ��� ������ �� ���� ������
-- 3. ù ��° ������ ���� ������ Ÿ���� �� ��° ������ ���� ������ Ÿ�԰� �����ؾ� ��

SELECT EMP_NO, EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19600101' AND '19691231'
UNION
SELECT EMP_NO, EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231';

SELECT EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19600101' AND '19691231'
UNION
SELECT EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231'; -- ����� �ٸ� �̰����� �ߺ� �����ͷ� ó���Ͽ� �Ѹ� ���

-- ## UNION ALL
-- 1. ù ��° ������ �� ��° ������ �ִ� ��� �����͸� ���ļ� ������
-- 2. �ߺ��� ������ ��� ������
-- 3. UNION�� �޸� �ڵ� ���� ����� �������� ���� (�� ���� ���� ��� �� �Ʒ� ���� ���� ���)
-- 4. ���� �鿡�� UNION���� ������ ������ �ǹ����� ���� ���
SELECT EMP_NO, EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT EMP_NO, EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231';

SELECT EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19600101' AND '19691231'
UNION ALL
SELECT EMP_NM, BIRTH_DE
FROM TB_EMP
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231'; -- ��� �ٸ� �̰��� �� �� ���


-- ## INTERSECT
-- 1. ù ��° ������ �� ��° �������� �ߺ��� �ุ�� ���
-- 2. ���п����� �����հ� ���� �ǹ�

SELECT
    A.EMP_NO, A.EMP_NM, A.ADDR, B.CERTI_CD, C.CERTI_NM
FROM TB_EMP A, TB_EMP_CERTI B, TB_CERTI C
WHERE A.EMP_NO = B.EMP_NO
    AND B.CERTI_CD = C.CERTI_CD
    AND C.CERTI_NM = 'SQLD'
INTERSECT
SELECT
    A.EMP_NO, A.EMP_NM, A.ADDR, B.CERTI_CD, C.CERTI_NM
FROM TB_EMP A, TB_EMP_CERTI B, TB_CERTI C
WHERE A.EMP_NO = B.EMP_NO
    AND B.CERTI_CD = C.CERTI_CD
    AND A.ADDR LIKE '%����%';
    
SELECT
    A.EMP_NO, A.EMP_NM, A.ADDR, B.CERTI_CD, C.CERTI_NM
FROM TB_EMP A, TB_EMP_CERTI B, TB_CERTI C
WHERE A.EMP_NO = B.EMP_NO
    AND B.CERTI_CD = C.CERTI_CD
    AND C.CERTI_NM = 'SQLD'
    AND A.ADDR LIKE '%����%'; -- AND���� �ϳ��� �߰��ص� ����� ����


-- ## MINUS (EXCEPT)
-- 1. ���п����� �����հ� ���� �ǹ�
-- 2. ���� �������� ���� ù ��° �������� �ִ� �����͸� ������

SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP
MINUS
SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP WHERE DEPT_CD = '100001'
MINUS
SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP WHERE DEPT_CD = '100004'
MINUS
SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP WHERE SEX_CD = '1';


-- # ������ ����
-- 1. �������̶�� �ǹ̴� �����Ͱ� ���� ����ϰ� �������� ���踦 �ǹ��ϴ� �ݸ�
--    �������� ������̰� �������� ���踦 �ǹ���
-- 2. ������Ʈ���� ����ϴ� �亯�� �Խ����̳� ī�װ� �������� ������ ������ �ش��

-- ������ ���� Ű����
-- 1. START WITH ������ TOP_LEVEL_CONDITION�� ��� ��
--    : ��Ʈ��带 �����ϴ� ������. �� ������ �����ϴ� ��� ����� ��Ʈ��尡 ��
-- 2. CONNECT BY [PRIOR(���� ����)] CONNECT_CONDITION
--    : �� ���ǿ��� �θ�� �ڽ� ������ ������ ���踦 �����.
--      �� ���ǿ� ���� �θ�� �ڽ� ������ ���̸� ������.
--      PRIOR�� �θ� ��� �÷��� �ĺ��ϴµ� ���

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "�����ο�",
    A.dept_cd,
    B.dept_nm,
    CONNECT_BY_ISLEAF
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd = B.dept_cd
START WITH A.direct_manager_emp_no IS NULL
CONNECT BY PRIOR A.emp_no = A.direct_manager_emp_no;

SELECT EMP_NO, EMP_NM, direct_manager_emp_no
FROM TB_EMP;

