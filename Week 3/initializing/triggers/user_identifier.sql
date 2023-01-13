CREATE OR REPLACE TRIGGER user_identifier
  BEFORE INSERT ON users
  FOR EACH ROW
DECLARE
BEGIN
  :new.identifier := UPPER(SUBSTR(:new.first_name, 1, 1) || UPPER(SUBSTR(:new.last_name, 1,1)) || '_' || :new.user_id);
END user_identifier;
