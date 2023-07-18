CREATE SCHEMA edu;

CREATE TABLE edu.member (
	member_id INTEGER PRIMARY KEY,
	firstname VARCHAR(30) NOT NULL,
	surname VARCHAR(30) NOT NULL,
	birth_dt DATE NOT NULL,
	phone VARCHAR(20) NOT NULL,
	mail VARCHAR(60),
	recommendedby INTEGER,
	FOREIGN KEY (recommendedby) REFERENCES edu.member(member_id)
);

CREATE TABLE edu.field (
	field_id INTEGER PRIMARY KEY,
	field_nm VARCHAR(30) NOT NULL
);

CREATE TABLE edu.course (
	course_id INTEGER PRIMARY KEY,
	field_id INTEGER,
	course_nm VARCHAR(80) NOT NULL,
	start_dt DATE NOT NULL,
	end_dt DATE NOT NULL,
	complexity INTEGER NOT NULL,
	FOREIGN KEY (field_id) REFERENCES edu.field(field_id)
);

CREATE TABLE edu.author (
	author_id INTEGER PRIMARY KEY,
	firstname VARCHAR(30) NOT NULL,
	surname VARCHAR(30) NOT NULL,
	birth_dt DATE NOT NULL
);

CREATE TABLE edu.authority (
	authority_id INTEGER PRIMARY KEY,
	author_id INTEGER NOT NULL,
	course_id INTEGER NOT NULL,
	income INTEGER NOT NULL,
	FOREIGN KEY (author_id) REFERENCES edu.author(author_id),
	FOREIGN KEY (course_id) REFERENCES edu.course(course_id)
);

CREATE TABLE edu.payment (
	payment_id INTEGER PRIMARY KEY,
	payment_no NUMERIC UNIQUE,
	pay_way VARCHAR(15) NOT NULL,
	price INTEGER NOT NULL
);

CREATE TABLE edu.registration (
	registration_id INTEGER PRIMARY KEY,
	member_id INTEGER NOT NULL,
	course_id INTEGER NOT NULL,
	payment_id INTEGER NOT NULL,
	enrollment_dttm TIMESTAMP NOT NULL,
	valid_from_dttm TIMESTAMP NOT NULL,
	valid_to_dttm TIMESTAMP DEFAULT '9999-12-31',
	FOREIGN KEY (member_id) REFERENCES edu.member(member_id),
	FOREIGN KEY (course_id) REFERENCES edu.course(course_id),
	FOREIGN KEY (payment_id) REFERENCES edu.payment(payment_id)
);

CREATE TABLE edu.feedback (
	feedback_id INTEGER PRIMARY KEY,
	member_id INTEGER,
	course_id INTEGER,
	mark INTEGER NOT NULL,
	feedback_txt TEXT,
	FOREIGN KEY (member_id) REFERENCES edu.member(member_id),
	FOREIGN KEY (course_id) REFERENCES edu.course(course_id)
);

