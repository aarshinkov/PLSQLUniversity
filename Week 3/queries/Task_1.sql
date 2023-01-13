DECLARE
  ip_first_name   users.first_name%TYPE := 'John';
  ip_last_name    users.last_name%TYPE := 'Doe';
  ip_email        users.email%TYPE := 'john.doe@test.com';
  ip_password     users.password%TYPE := 'test1234';
  ip_confirm_pass users.password%TYPE := 'test1234';

  ip_cat_name   cats.name%TYPE := 'Blacky';
  ip_cat_fur    cats.fur_color%TYPE := 'Black';
  ip_cat_weight cats.weight%TYPE := 3;

  user_id   users.user_id%TYPE;
  castle_id castles.castle_id%TYPE;
  room_id   rooms.room_id%TYPE;

  is_email_taken NUMBER;

BEGIN
  SELECT COUNT(*)
  INTO   is_email_taken
  FROM   users u
  WHERE  u.email = ip_email;

  IF is_email_taken = 0 THEN
  
    IF ip_password <> ip_confirm_pass THEN
      INSERT INTO ERROR_REGISTRY
      VALUES
        (seq_errors.nextval, SYSDATE, 'ERR_PASS_CONFIRM',
         'The two passwords do not match.');
    ELSE
      user_id   := seq_users.nextval;
      castle_id := seq_castles.nextval;
      room_id   := seq_rooms.nextval;
    
      INSERT INTO USERS
      VALUES
        (user_id, null, ip_first_name, ip_last_name, ip_email,
         ip_password, 100);
    
      INSERT INTO CASTLES
      VALUES
        (castle_id, user_id);
    
      INSERT INTO ROOMS VALUES (room_id, castle_id, 1);
    
      INSERT INTO CATS
      VALUES
        (seq_cats.nextval, user_id, ip_cat_name, ip_cat_fur,
         ip_cat_weight, 'S', 1, room_id);
    END IF;
  
  ELSE
    INSERT INTO ERROR_REGISTRY
    VALUES
      (seq_errors.nextval, SYSDATE, 'ERR_EMAIL_TAKEN',
       'The email that the user tries to register with has already been taken.');
  END IF;
END;