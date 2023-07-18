--№1--
--Тригер, который при удалении пользователя из edu.member удаляет все связанные с ним записи в других таблицах.--

CREATE OR REPLACE FUNCTION delete_member_data()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM edu.registration WHERE member_id = OLD.member_id;
  DELETE FROM edu.feedback WHERE member_id = OLD.member_id;
  UPDATE edu.member SET recommendedby = NULL WHERE recommendedby = OLD.member_id;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_member_trigger
BEFORE DELETE ON edu.member
FOR EACH ROW
EXECUTE FUNCTION delete_member_data();


--№2--
--Триггер, который при удалении пользователя из edu.author удаляет все связанные с ним записи в других таблицах.--
CREATE OR REPLACE FUNCTION delete_author_data()
RETURNS TRIGGER AS $$
BEGIN
  DELETE FROM edu.authority WHERE author_id = OLD.author_id;
  RETURN OLD;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER delete_author_trigger
BEFORE DELETE ON edu.author
FOR EACH ROW
EXECUTE FUNCTION delete_author_data();
