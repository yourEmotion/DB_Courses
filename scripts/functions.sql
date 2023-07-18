--№1--
--Функция, которая для конкретного id пользователя считает количество курсов, проходимых прямо сейчас (на момент выполнения функции).--
CREATE FUNCTION edu.courses_taken_now(arg_member_id INTEGER) RETURNS INTEGER AS $$
    DECLARE courses_count INTEGER;
    BEGIN
        SELECT COUNT(*) INTO courses_count
        FROM edu.registration r
        WHERE r.member_id = arg_member_id AND current_date BETWEEN r.valid_from_dttm AND r.valid_to_dttm;
    RETURN courses_count;
    END;
$$ LANGUAGE plpgsql;


--№2--
--Функция, которая для конкретного id курса считает среднюю оценку, оставленную пользователями.--
CREATE FUNCTION edu.average_rating(arg_course_id INTEGER) RETURNS DECIMAL(4,2) AS $$
    DECLARE total_marks INTEGER := 0;
    DECLARE feedback_count INTEGER := 0;
    DECLARE avg_rating DECIMAL(4,2) := 0;
    
    BEGIN
        SELECT
            SUM(f.mark),
            COUNT(*) INTO total_marks,
            feedback_count
        FROM
            edu.feedback f
        WHERE
            f.course_id = arg_course_id;
        IF feedback_count > 0 THEN
            avg_rating := 1.0 * total_marks / feedback_count;
        ELSE
            avg_rating := 0;
        END IF;
    RETURN avg_rating;
    END;
$$ LANGUAGE plpgsql;
