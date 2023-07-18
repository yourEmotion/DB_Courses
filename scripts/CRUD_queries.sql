--Обычные запросы SELECT--

--№1--
SELECT
    'student' AS state,
    CONCAT(firstname, ' ', surname) AS full_nm
FROM
    edu.member

UNION ALL

SELECT
    'teacher' AS state,
    CONCAT(firstname, ' ', surname) AS full_nm
FROM
    edu.author;


--№2--
SELECT *
FROM
    edu.member
WHERE
    recommendedby = 1;


--№3--
SELECT
    payment_no,
    price
FROM
    edu.payment
WHERE
    pay_way = 'Cash';


--№4--
SELECT
    CONCAT(firstname, ' ', surname) AS author_nm,
    course_nm,
    income
FROM
    (edu.author a1
    INNER JOIN edu.authority a2 ON a1.author_id = a2.author_id) a
    INNER JOIN edu.course c ON a.course_id = c.course_id;


--№5--
SELECT
    CONCAT(firstname, ' ', surname) AS member_nm,
    course_nm
FROM
    (edu.member m1
    INNER JOIN edu.registration m2 ON m1.member_id = m2.member_id) m
    INNER JOIN edu.course c ON m.course_id = c.course_id;


--№6--
SELECT
    f.field_nm AS field_nm,
    c.course_nm AS course_nm
FROM
    edu.course c LEFT JOIN edu.field f ON c.field_id = f.field_id;


--№7--
SELECT
    CONCAT(m.firstname, ' ', m.surname) AS member_nm,
    f.mark AS mark,
    f.feedback_txt AS feedback
FROM
    edu.member m LEFT JOIN edu.feedback f ON m.member_id = f.feedback_id
WHERE
    f.feedback_txt IS NOT NULL;


--№8--
SELECT
    course_nm,
    complexity
FROM
    edu.course
WHERE
    complexity > 6;


--№9--
SELECT
    CONCAT(firstname, ' ', surname) AS member_nm,
    AGE(birth_dt) AS age
FROM
    edu.member
WHERE
    DATE_PART('YEAR', AGE(birth_dt)) = 20;


--№10--
SELECT
    CONCAT(m1.firstname, ' ', m1.surname) AS member_nm,
    CONCAT(m2.firstname, ' ', m2.surname) AS recommendedby
FROM
    edu.member m1 LEFT JOIN edu.member m2 ON m1.recommendedby = m2.member_id;





--Запросы UPDATE--

--№1--
UPDATE edu.member SET phone = '+79992741129' WHERE member_id = 3;

--№2--
UPDATE edu.course SET complexity = 7 WHERE course_nm LIKE '%Python';

--№3--
UPDATE edu.authority SET income = 0 WHERE author_id = 10;





--Запросы DELETE--

--№1--
DELETE FROM edu.feedback WHERE mark < 5;

--№2--
DELETE FROM edu.authority WHERE author_id = 11;

--№3--
DELETE FROM edu.author WHERE author_id = 11;





--Запросы INSERT--

--№1--
INSERT INTO edu.feedback VALUES
    (11, 3, 2, 6, NULL);

--№2--
INSERT INTO edu.member VALUES
    (16, 'Карпов', 'Олег', '2003-06-03', '+79258461939', NULL, 8);

--№3--
INSERT INTO edu.payment VALUES
    (29, 8924078320788241, 'Discount card', 1000);

--№4--
INSERT INTO edu.registration VALUES
    (29, 16, 1, 29, '2023-03-05', '2023-03-05', '2023-04-02');

