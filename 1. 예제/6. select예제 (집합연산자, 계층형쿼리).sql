

-- # 집합 연산자
-- ## UNION
-- 1. 수학에서의 합집합과 같은 의미
-- 2. 첫 번째 쿼리와 두 번째 쿼리의 중복된 정보는 한 번만 보여줌
-- 3. 첫 번째 쿼리의 열의 개수와 타입이 두 번째 쿼리의 열의 개수와 타입과 동일해야 함

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
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231'; -- 사번이 다른 이관심을 중복 데이터로 처리하여 한명만 출력

-- ## UNION ALL
-- 1. 첫 번째 쿼리와 두 번째 쿼리에 있는 모든 데이터를 합쳐서 보여줌
-- 2. 중복된 정보도 모두 보여줌
-- 3. UNION과 달리 자동 정렬 기능을 제공하지 않음 (위 쿼리 전부 출력 후 아래 쿼리 전부 출력)
-- 4. 성능 면에서 UNION보다 빠르기 때문에 실무에서 많이 사용
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
WHERE BIRTH_DE BETWEEN '19700101' AND '19791231'; -- 사번 다른 이관심 둘 다 출력


-- ## INTERSECT
-- 1. 첫 번째 쿼리와 두 번째 쿼리에서 중복된 행만을 출력
-- 2. 수학에서의 교집합과 같은 의미

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
    AND A.ADDR LIKE '%용인%';
    
SELECT
    A.EMP_NO, A.EMP_NM, A.ADDR, B.CERTI_CD, C.CERTI_NM
FROM TB_EMP A, TB_EMP_CERTI B, TB_CERTI C
WHERE A.EMP_NO = B.EMP_NO
    AND B.CERTI_CD = C.CERTI_CD
    AND C.CERTI_NM = 'SQLD'
    AND A.ADDR LIKE '%용인%'; -- AND조건 하나만 추가해도 결과가 동일


-- ## MINUS (EXCEPT)
-- 1. 수학에서의 차집합과 같은 의미
-- 2. 하위 쿼리에는 없고 첫 번째 쿼리에만 있는 데이터를 보여줌

SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP
MINUS
SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP WHERE DEPT_CD = '100001'
MINUS
SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP WHERE DEPT_CD = '100004'
MINUS
SELECT EMP_NO, EMP_NM, SEX_CD, DEPT_CD FROM TB_EMP WHERE SEX_CD = '1';


-- # 계층형 질의
-- 1. 관계형이라는 의미는 데이터가 서로 평등하고 수평적인 관계를 의미하는 반면
--    계층형은 계급적이고 수직적인 관계를 의미함
-- 2. 웹사이트에서 사용하는 답변형 게시판이나 카테고리 정보들이 계층형 구조에 해당됨

-- 계층형 전용 키워드
-- 1. START WITH 다음엔 TOP_LEVEL_CONDITION을 줘야 함
--    : 루트노드를 지정하는 조건임. 이 조건을 만족하는 모든 행들은 루트노드가 됨
-- 2. CONNECT BY [PRIOR(생략 가능)] CONNECT_CONDITION
--    : 이 조건에는 부모와 자식 노드들의 사이의 관계를 명시함.
--      이 조건에 따라 부모와 자식 노드들의 사이를 연결함.
--      PRIOR는 부모 노드 컬럼을 식별하는데 사용

SELECT 
    LEVEL AS LVL,
    LPAD(' ', 4*(LEVEL-1)) || emp_no || '(' || emp_nm || ')' AS "조직인원",
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

