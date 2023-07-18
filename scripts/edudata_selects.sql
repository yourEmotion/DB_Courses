--Сложные запросы SELECT--

--№1--
--Запрос выводит студентов (member) и их суммарные траты за все купленные курсы.--
--Выводятся только те, кто потратил больше 10000 в порядке по убыванию.--
SELECT 
    CONCAT(m.firstname, ' ', m.surname) AS member_nm,
    SUM(price) AS paid
FROM
    edu.member m
    INNER JOIN edu.registration r1 ON m.member_id = r1.member_id
    INNER JOIN edu.payment p ON r1.payment_id = p.payment_id
GROUP BY
    m.member_id
HAVING
    SUM(price) > 10000
ORDER BY
    paid DESC;


--№2--
--Запрос выводит студентов (member) и число курсов, в которых они состоят.--
WITH member_participations AS (
    SELECT
        r.registration_id,
        CONCAT(m.firstname, ' ', m.surname) AS member_nm
    FROM
        edu.registration r INNER JOIN edu.member m ON r.member_id = m.member_id)

SELECT DISTINCT
    mp.member_nm AS member_nm,
    COUNT(*) OVER (PARTITION BY member_nm) AS participations_cnt
FROM
    member_participations mp
ORDER BY
    participations_cnt DESC;


--№3--
--Запрос выводит авторов курсов (author) и число курсов, которые они преподают.--
WITH authorities AS (
    SELECT
        a1.authority_id,
        CONCAT(a2.firstname, ' ', a2.surname) AS author_nm
    FROM
        edu.authority a1 INNER JOIN edu.author a2 ON a1.author_id = a2.author_id)


SELECT DISTINCT
    a.author_nm AS author_nm,
    COUNT(*) OVER (PARTITION BY author_nm) AS authorities_cnt
FROM
    authorities a
ORDER BY
    authorities_cnt DESC;


--№4--
--Запрос выводит отранжированный по сложности список курсов--
SELECT
    DENSE_RANK() OVER (ORDER BY complexity),
    course_nm,
    complexity
FROM
    edu.course;


--№5--
--Запрос выводит список учителей, отранжированный по суммарному доходу за все курсы, и сам доход.--
WITH course_income AS (
    SELECT
        CONCAT(firstname, ' ', surname) AS author_nm,
        income
    FROM
        (edu.author a1
        INNER JOIN edu.authority a2 ON a1.author_id = a2.author_id) a
        INNER JOIN edu.course c ON a.course_id = c.course_id)

SELECT
    RANK() OVER (ORDER BY summary_income DESC),
    author_nm,
    summary_income
FROM
    (SELECT DISTINCT
        author_nm,
        SUM(income) OVER (PARTITION BY author_nm) AS summary_income
    FROM
        course_income) sums;


--№6--
--Запрос выводит список из способов оплаты, отранжированный по суммарному числу
--этих способов оплаты, и их количество.--
SELECT
    ROW_NUMBER() OVER (ORDER BY cnt),
    pay_way,
    cnt
FROM
    (SELECT DISTINCT
        pay_way,
        COUNT(*) AS cnt
    FROM
        edu.payment
    GROUP BY
        pay_way) cnt_pay_way;
