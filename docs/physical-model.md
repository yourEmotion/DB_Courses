# Physical model

---

Table `member`:

| Attribute        | Desctiption           | Data type     | Restrictions   |
|-----------------|--------------------|----------------|---------------|
| `member_id`         | Identifier      | `SERIAL`      | `PRIMARY KEY` |
| `firstname`       | Member's firstname    | `VARCHAR(30)` | `NOT NULL`    |
'| `surname`       | Member's surname    | `VARCHAR(30)` | `NOT NULL`    |
| `birth_dt`       | Member's date of birth      | `DATE` | `NOT NULL`    |
| `phone`     | Member's phone number     | `VARCHAR(20)`  | `UNIQUE`    |
| `mail`      | Member's email  | `VARCHAR(60)`    |     |
| `recommendedby`      | Member who invited | `INTEGER`    | `FOREIGN KEY`    |

Table `field`:

| Attribute             | Description                                         | Data type     | Restrictions   |
|-------------|---------------------------------|-------------|---------------|
| `field_id`    | Identifier             | `SERIAL`   | `PRIMARY KEY` |
| `field_nm`     | Field's full name           | `VARCHAR(30)`   | `NOT NULL` |

Table `course`:

| Attribute             | Description                                         | Data type     | Restrictions   |
|----------------------|--------------------------------------------------|----------------|---------------|
| `course_id`              | Identifier                                    | `SERIAL`      | `PRIMARY KEY` |
| `field_id`               | Identifier of the field to which the course belongs                                              | `SERIAL` | `FOREIGN KEY`    |
| `course_nm`         | Course's full name                | `VARCHAR(80)`      | `NOT NULL`    |
| `start_dt`          | Date when course starts                | `DATE`      | `NOT NULL`    |
| `end_dt`      | Date when course ends           | `DATE`      | `NOT NULL`    |
| `complexity`      | Mark from 0 (very easy) to 10 (extremely hard)           | `INTEGER`      | `CHECK (complexity >= 0 AND complexity <= 10)`    |

Table `author`:

| Attribute             | Description                                         | Data type     | Restrictions   |
|-------------|---------------------------------|-------------|---------------|
| `author_id`    | Identifier             | `SERIAL`   | `PRIMARY KEY` |
| `firstname`     | Author's firstname        | `VARCHAR(30)`   | `NOT NULL` |
| `surname`     | Author's surname          | `VARCHAR(30)`   | `NOT NULL` |
| `birth_dt`     | Author's date of birth             | `DATE`   | `NOT NULL` |

Table `authority`:

| Attribute        | Desctiption           | Data type     | Restrictions   |
|-----------------|--------------------|----------------|---------------|
| `authority_id`         | Identifier      | `SERIAL`      | `PRIMARY KEY` |
| `author_id`       | Author of the course   | `SERIAL` | `FOREIGN KEY`    |
| `course_id`       | Course      | `SERIAL` | `FOREIGN KEY`    |
| `income`     | Total author's income for this course   | `INTEGER`  | `NOT NULL`    |

Table `payment`:

| Attribute        | Desctiption           | Data type     | Restrictions   |
|-----------------|--------------------|----------------|---------------|
| `payment_id`         | Identifier      | `SERIAL`      | `PRIMARY KEY` |
| `payment_no`       | Unique 16-digit number    | `NUMERIC` | `UNIQUE`    |
| `pay_way`     | One of the words: "Cash", "Bank card", "Discount card", "Online"     | `VARCHAR(15)`  | `NOT NULL`    |
| `price`      | Amount of money for paying in rubles | `INTEGER`    | `NOT NULL`    |


Table `registration`:

| Attribute        | Desctiption           | Data type     | Restrictions   |
|-----------------|--------------------|----------------|---------------|
| `registration_id`         | Identifier      | `SERIAL`      | `PRIMARY KEY` |
| `member_id`       | Member of the registration    | `SERIAL` | `FOREIGN KEY`    |
| `course_id`       | Course for registration      | `SERIAL` | `FOREIGN KEY`    |
| `payment_id`     | Payment of the course     | `SERIAL`  | `FOREIGN KEY`    |
| `enrollment_dttm`      | Date of registration for the course | `TIMESTAMP`    | `NOT NULL`    |
| `valid_from_dttm`      | Date of subscription actication | `TIMESTAMP`    | `NOT NULL`    |
| `valid_to_dttm`      | Date of subscription end | `TIMESTAMP`    | `DEFAULT '9999-12-31'`    |

Table `feedback`:

| Attribute        | Desctiption           | Data type     | Restrictions   |
|-----------------|--------------------|----------------|---------------|
| `feedback_id`         | Identifier      | `SERIAL`      | `PRIMARY KEY` |
| `member_id`       | Member who left the feedback    | `SERIAL` | `NOT NULL`    |
| `course_id`       | Reviewed course      | `SERIAL` | `NOT NULL` |
| `mark`     | Mark from 0 (awful) to 10 (perfect)     | `INTEGER`  | `CHECK (mark >= 0 AND mark <= 10)`    |
| `feedback_txt`      | Feedback from the member | `TEXT`    |     |

---

Table `member`:

```postgresql
CREATE TABLE edu.member (
	member_id SERIAL PRIMARY KEY,
	firstname VARCHAR(30) NOT NULL,
	surname VARCHAR(30) NOT NULL,
	birth_dt DATE NOT NULL,
	phone VARCHAR(20) NOT NULL,
	mail VARCHAR(60),
	recommendedby INTEGER,
	FOREIGN KEY (recommendedby) REFERENCES edu.member(member_id)
);
```

Table `field`:

```postgresql
CREATE TABLE edu.field (
	field_id SERIAL PRIMARY KEY,
	field_nm VARCHAR(30) NOT NULL
);
```

Table `course`:

```postgresql
CREATE TABLE edu.course (
	course_id SERIAL PRIMARY KEY,
	field_id SERIAL,
	course_nm VARCHAR(80) NOT NULL,
	start_dt DATE NOT NULL,
	end_dt DATE NOT NULL,
	complexity INTEGER CHECK (complexity >= 0 AND complexity <= 10),
	FOREIGN KEY (field_id) REFERENCES edu.field(field_id)
);
```

Table `author`:

```postgresql
CREATE TABLE edu.author (
	author_id SERIAL PRIMARY KEY,
	firstname VARCHAR(30) NOT NULL,
	surname VARCHAR(30) NOT NULL,
	birth_dt DATE NOT NULL
);
```

Table `authority`:

```postgresql
CREATE TABLE edu.authority (
	authority_id SERIAL PRIMARY KEY,
	author_id SERIAL NOT NULL,
	course_id SERIAL NOT NULL,
	income INTEGER NOT NULL,
	FOREIGN KEY (author_id) REFERENCES edu.author(author_id),
	FOREIGN KEY (course_id) REFERENCES edu.course(course_id)
);
```

Table `payment`:

```postgresql
CREATE TABLE edu.payment (
	payment_id SERIAL PRIMARY KEY,
	payment_no NUMERIC UNIQUE,
	pay_way VARCHAR(15) NOT NULL,
	price INTEGER NOT NULL
);
```

Table `registration`:

```postgresql
CREATE TABLE edu.registration (
	registration_id SERIAL PRIMARY KEY,
	member_id SERIAL NOT NULL,
	course_id SERIAL NOT NULL,
	payment_id SERIAL NOT NULL,
	enrollment_dttm TIMESTAMP NOT NULL,
	valid_from_dttm TIMESTAMP NOT NULL,
	valid_to_dttm TIMESTAMP DEFAULT '9999-12-31',
	FOREIGN KEY (member_id) REFERENCES edu.member(member_id),
	FOREIGN KEY (course_id) REFERENCES edu.course(course_id),
	FOREIGN KEY (payment_id) REFERENCES edu.payment(payment_id)
);
```

Table `feedback`:

```postgresql
CREATE TABLE edu.feedback (
	feedback_id SERIAL PRIMARY KEY,
	member_id SERIAL,
	course_id SERIAL,
	mark INTEGER CHECK (mark >= 0 AND mark <= 10),
	feedback_txt TEXT,
	FOREIGN KEY (member_id) REFERENCES edu.member(member_id),
	FOREIGN KEY (course_id) REFERENCES edu.course(course_id)
);
```










