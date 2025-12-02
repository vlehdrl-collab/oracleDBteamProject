-- 1. 전체 총 매출 조회
SELECT SUM(payment_amount) AS "총 매출"
FROM payment;

-- 2. 월별 매출 분석
SELECT TO_CHAR(payment_date, 'YYYY-MM') AS "년-월",
       SUM(payment_amount)              AS "월별 매출"
FROM payment
GROUP BY TO_CHAR(payment_date, 'YYYY-MM')
ORDER BY "년-월";

-- 3. 상품 카테고리별 매출
SELECT CASE
           WHEN p.pro_id LIKE 'BK_%' THEN '도서'
           WHEN p.pro_id LIKE 'SUP_%' THEN '문구'
           END                          AS "카테고리",
       SUM(oi.unit_price * oi.quantity) AS "매출"
FROM order_item oi
         JOIN product p ON oi.pro_id = p.pro_id
GROUP BY CASE
             WHEN p.pro_id LIKE 'BK_%' THEN '도서'
             WHEN p.pro_id LIKE 'SUP_%' THEN '문구'
             END;

-- 4. 회원 등급별 매출
SELECT u.grade               AS "회원 등급",
       SUM(p.payment_amount) AS "매출"
FROM payment p
         JOIN orders o ON p.order_id = o.order_id
         JOIN user_info u ON o.u_id = u.u_id
GROUP BY u.grade;

