--№1--
--Хранит информацию по курсам: название курса, время начала и конца, сложность, область--
--и всех авторов курса с их доходом за курс.--
CREATE VIEW edu.course_info AS
    SELECT
    	c.course_nm,
    	c.start_dt,
    	c.end_dt,
    	c.complexity,
    	f.field_nm, 
	array_agg(CONCAT(CONCAT(a.firstname, ' ', a.surname), ': ', ca.income, '₽')) AS authors_info
    FROM
    	edu.course c
	JOIN edu.field f ON f.field_id = c.field_id
	JOIN edu.authority ca ON c.course_id = ca.course_id
	JOIN edu.author a ON ca.author_id = a.author_id
    GROUP BY
    	c.course_nm,
    	c.start_dt,
    	c.end_dt,
    	c.complexity,
    	f.field_nm;


--№2--
--Хранит информацию об отзыве на каждый курс.--
CREATE VIEW edu.course_feedback AS
    SELECT
        c.course_nm,
        CONCAT(m.firstname, ' ', m.surname) AS member_nm,
        f.mark,
        f.feedback_txt
    FROM
        edu.feedback f
        JOIN edu.member m ON f.member_id = m.member_id
        JOIN edu.course c ON f.course_id = c.course_id;


--№3--
--Хранит статистику по продажам для каждой области курсов.--
CREATE VIEW edu.sales_stats AS
    SELECT
    	f.field_nm,
    	COUNT(*) AS sales_count,
    	SUM(p.price) AS total_revenue
    FROM edu.course c
	JOIN edu.field f ON c.field_id = f.field_id
	JOIN edu.registration r ON c.course_id = r.course_id
	JOIN edu.payment p ON r.payment_id = p.payment_id
    GROUP BY
    	f.field_nm;


--№4--
--Хранит безопасную информацию о платежах со скрытым номером платежа (требуется в задании).--
CREATE VIEW edu.safety_payment_info AS
    SELECT
    	CONCAT('************', RIGHT(payment_no::TEXT, 4)) AS payment_no,
    	pay_way,
    	price
    FROM
    	edu.payment;


--№5--
--Хранит безопасную информацию о персональных данных пользователя (требуется в задании).--
CREATE VIEW edu.safety_member_info AS
    SELECT
    	CONCAT(firstname, ' ', surname) AS member_nm,
    	birth_dt,
    	CONCAT(LEFT(phone, 2), '******', RIGHT(phone, 4)) AS phone,
	CASE
	    WHEN mail IS NOT NULL THEN CONCAT(LEFT(mail, 3), '****', RIGHT(mail, 7))
	    ELSE NULL
	END AS mail
    FROM edu.member;


--№6--
--Хранит информации об авторе каждого курса (имя, дата рождения и возраст на момент создания курса).--
CREATE VIEW edu.course_authors AS
    SELECT
    	c.course_id,
    	CONCAT(a.firstname, ' ', a.surname) AS author_nm,
    	a.birth_dt,
    	(c.start_dt - a.birth_dt) / 365 AS age_at_creation
    FROM
    	edu.course c
    	JOIN edu.authority au ON c.course_id = au.course_id
	JOIN edu.author a ON au.author_id = a.author_id; 

