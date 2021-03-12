

-- # ���� ����
-- ## ���� ������ ����� �� �ִ� ��
-- [ select�� (��Į�� ��������), from�� (�ζ��� ��),
-- where, having, order by, insert�� value��, update set�� ]

-- ## �������� ��� ������
-- 1. �ݵ�� ��ȣ�� ���� ��!
-- 2. �񱳿����� �����ʿ� ��ġ��ų ��! (ex. oo = xx���� xx�� �ڸ��� ��ġ�� ��)
-- 3. ���������� order by�� ����� �� ����!
-- 4. ���� �� ������������ ���� �� �����ڸ�, ���� �� ������������ ���� �� �����ڸ� ���!


-- # ���� �� ��������

-- �����ȣ�� 1000000005���� ����� ���� �μ��� ��� ���� ����
SELECT EMP_NO, EMP_NM, DEPT_CD
FROM TB_EMP
WHERE DEPT_CD =
(
        SELECT DEPT_CD
        FROM TB_EMP
        WHERE EMP_NO = '1000000005'
);

-- 20150525�� ���� �޿��� ȸ�� ��ü ��� �޿����� ���� ������� ���� ��ȸ
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


-- # ���� �� ��������
-- �������� ��ȸ �Ǽ��� ���� ���� �� (IN, ANY, ALL, EXISTS)

-- �ѱ������ͺ��̽���������� �߱��� �ڰ����� ������ �ִ� �����ȣ�� �ڰ��� ������ ��ȸ
SELECT
    EMP_NO, COUNT(*) CNT
FROM TB_EMP_CERTI
WHERE CERTI_CD IN (
                    SELECT CERTI_CD
                    FROM TB_CERTI
                    WHERE ISSUE_INSTI_NM = '�ѱ������ͺ��̽������'
                  )
GROUP BY EMP_NO
ORDER BY EMP_NO;

-- �μ����� 2�� �̻��� �μ� �߿��� �� �μ��� ���� ���� ���� ����� ������ ��ȸ
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

-- �ּҰ� ������ �������� �μ������� ��ȸ
SELECT A.DEPT_CD, A.DEPT_NM
FROM TB_DEPT A
WHERE EXISTS (
                SELECT 1 FROM TB_EMP K WHERE K.DEPT_CD = A.DEPT_CD
                                         AND K.ADDR LIKE '%����%'
             );


-- # ��Į�� ��������
SELECT
    A.EMP_NO,
    (SELECT L.EMP_NM FROM TB_EMP L WHERE L.EMP_NO = A.EMP_NO) AS EMP_NM,
    A.CERTI_CD,
    (SELECT C.CERTI_NM FROM TB_CERTI C WHERE C.CERTI_CD = A.CERTI_CD) AS CERTI_NM
FROM TB_EMP_CERTI A
WHERE CERTI_CD IN (
                    SELECT K.CERTI_CD
                    FROM TB_CERTI K
                    WHERE K.ISSUE_INSTI_NM = '�ѱ������ͺ��̽������'
                  )
ORDER BY CERTI_NM;
