

-- 3개의 테이블 조인
SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.dept_cd, B.dept_nm, C.certi_cd
FROM tb_emp A, tb_dept B, tb_emp_certi C
WHERE A.dept_cd = B.dept_cd
    AND A.addr LIKE '%수원%'
    AND A.emp_no = C.emp_no;
    

SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.dept_cd, B.dept_nm, C.certi_cd
FROM tb_emp A 
JOIN tb_dept B 
ON A.dept_cd = B.dept_cd
JOIN tb_emp_certi C
ON A.emp_no = C.emp_no
WHERE A.addr LIKE '%수원%';    
    
    
-- 4개 테이블 조인    
-- 위 3개 테이블 + tb_certi
-- 추가로 자격증 이름(certi_nm)까지 조회할 수 있게 조인해보세요.
SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.dept_cd, B.dept_nm, C.certi_cd, D.certi_nm
FROM tb_emp A, tb_dept B, tb_emp_certi C, tb_certi D
WHERE A.dept_cd = B.dept_cd
    AND A.addr LIKE '%수원%'
    AND A.emp_no = C.emp_no
    AND C.certi_cd = D.certi_cd;
    
SELECT
    A.emp_no, A.emp_nm, A.addr,
    B.dept_cd, B.dept_nm, C.certi_cd, D.certi_nm
FROM tb_emp A 
JOIN tb_dept B 
ON A.dept_cd = B.dept_cd
JOIN tb_emp_certi C
ON A.emp_no = C.emp_no
JOIN tb_certi D
ON C.certi_cd = D.certi_cd
WHERE A.addr LIKE '%수원%';  


-- # SELF JOIN
-- 1. SELF JOIN은 자기 자신의 테이블을 조인하는 개념입니다.
-- 2. 자기 테이블의 컬럼들을 매칭하여 조회하는 기법입니다.

SELECT
    A.emp_no, A.emp_nm, A.direct_manager_emp_no, B.emp_nm AS "상사이름"
FROM tb_emp A, tb_emp B
WHERE A.direct_manager_emp_no = B.emp_no
    AND A.emp_nm = '김나라'
ORDER BY emp_no;



-- OUTER JOIN 실습환경 세팅
INSERT INTO tb_dept VALUES ('100014', '4차산업혁명팀', '999999');
INSERT INTO tb_dept VALUES ('100015', '포스트코로나팀', '999999');
COMMIT;

SELECT * FROM tb_dept;

ALTER TABLE tb_emp DROP CONSTRAINT fk_tb_emp01;

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000041', '이순신', '19811201', '1', '경기도 용인시 수지구 죽전1동 435', '010-5656-7878',
        NULL, '006', '003', '114-554-223433', '000000', 'N');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000042', '정약용', '19820402', '1', '경기도 고양시 덕양구 화정동 231', '010-4054-6547',
        NULL, '004', '001', '110-223-553453', '000000', 'Y');

INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
                    final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000043', '박지원', '19850611', '1', '경기도 수원시 팔달구 매탄동 553', '010-1254-1116',
        NULL, '004', '001', '100-233-664234', '000000', 'N');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000044', '장보고', '19870102', '1', '경기도 성남시 분당구 정자동 776', '010-1215-8784',
        NULL, '004', '002', '180-345-556634', '000000', 'Y');
        
INSERT INTO tb_emp (emp_no, emp_nm, birth_de, sex_cd, addr, tel_no, direct_manager_emp_no, 
            final_edu_se_cd, sal_trans_bank_cd, sal_trans_accnt_no, dept_cd, lunar_yn)
VALUES ('1000000045', '김종서', '19880824', '1', '경기도 고양시 일산서구 백석동 474', '010-3687-1245',
        NULL, '004', '002', '325-344-45345', '000000', 'Y');
        
COMMIT;
    
 
SELECT * FROM tb_emp ORDER BY emp_no DESC;

SELECT * FROM tb_dept;

-- # OUTER JOIN
-- 1. 조인 조건을 만족하지 않는 행들도 조회하기 위해 사용합니다.
-- 2. OUTER 조인 연산자는 더하기 기호 (+)입니다.
-- 3. EQUI조인은 조인 조건을 만족하지 않으면 해당 행을 출력되지 않습니다
--    그러나 OUTER 조인은 방향(LEFT, RIGHT)에 맞게 조건에 매칭되지 않는
--    행들도 모두 null행을 생성해서 출력합니다.


-- # LEFT OUTER JOIN
-- 왼쪽 테이블 정보는 모두 조회하고 오른쪽 테이블은 조인조건에 매칭된 것만 조회
SELECT * FROM tb_emp;

SELECT 
    A.emp_no, A.emp_nm, B.dept_cd, B.dept_nm
FROM tb_emp A
LEFT OUTER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
WHERE A.dept_cd IN ('000000', '100003');

-- # RIGHT OUTER JOIN
-- 오른쪽 테이블 정보는 모두 조회하고 왼쪽 테이블은 조인조건에 매칭된 것만 조회
SELECT * FROM tb_dept;

-- 모든 부서를 조회하고 싶은데 혹시 해당 부서에 사원정보가 있으면 그 정보까지 보고싶다.
SELECT
    A.emp_no, A.emp_nm,
    B.dept_cd, B.dept_nm
FROM tb_emp A
JOIN tb_dept B
ON A.dept_cd(+) = B.dept_cd;

SELECT
    A.emp_no, A.emp_nm,
    B.dept_cd, B.dept_nm
FROM tb_emp A
RIGHT OUTER JOIN tb_dept B
ON A.dept_cd = B.dept_cd;

-- FULL OUTER JOIN
SELECT 
    A.emp_no, A.emp_nm,
    B.dept_cd, B.dept_nm
FROM tb_emp A
FULL OUTER JOIN tb_dept B
ON A.dept_cd = B.dept_cd
ORDER BY B.dept_cd DESC, A.emp_no DESC;
 
 
-- 실습 종료 후 처리
DELETE FROM tb_dept 
WHERE dept_cd IN ('100014', '100015');

DELETE FROM tb_emp 
WHERE emp_no IN ('1000000041', '1000000042', '1000000043', '1000000044', '1000000045');

COMMIT;

ALTER TABLE tb_emp 
ADD CONSTRAINT fk_tb_emp01 
FOREIGN KEY (dept_cd) 
REFERENCES tb_dept (dept_cd);
 
 
 
 
 
 
 