DECLARE
  ip_user_id users.user_id%TYPE := 1;
  ip_room_id rooms.room_id%TYPE := 1;

  -- S - small; M - medium; L - large
  ip_cat_type cats.type%TYPE := 'M';

  ip_cat_name   cats.name%TYPE := 'Nick';
  ip_cat_fur    cats.fur_color%TYPE := 'White';
  ip_cat_weight cats.weight%TYPE := 3;

  is_room_empty NUMBER;
  is_owner      NUMBER;

  castle_id castles.castle_id%TYPE;

  cat_level NUMBER;

  room_stars     rooms.stars%TYPE;
  cat_price      NUMBER;
  avail_balance  NUMBER;
  result_balance NUMBER;

  room_cat_compatible NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO   is_room_empty
  FROM   cats
  WHERE  room_id = ip_room_id;

  SELECT COUNT(*)
  INTO   is_owner
  FROM   users u
  JOIN   castles c ON u.user_id = c.user_id
  JOIN   rooms r ON c.castle_id = r.castle_id
  WHERE  u.user_id = ip_user_id
  AND    r.room_id = ip_room_id;

  IF is_owner <> 0 THEN
    dbms_output.put_line('The user is the owner');
  
    IF is_room_empty = 0 THEN
      dbms_output.put_line('The room IS empty');
    
      SELECT r.stars
      INTO   room_stars
      FROM   rooms r
      WHERE  r.room_id = ip_room_id;
    
      IF ip_cat_type = 'S' THEN
        IF room_stars BETWEEN 1 AND 10 THEN
          room_cat_compatible := 1;
        END IF;
      ELSIF ip_cat_type = 'M' THEN
        IF room_stars BETWEEN 11 AND 25 THEN
          room_cat_compatible := 1;
        END IF;
      ELSIF ip_cat_type = 'L' THEN
        IF room_stars BETWEEN 26 AND 99 THEN
          room_cat_compatible := 1;
        END IF;
      END IF;
    
      IF room_cat_compatible = 1 THEN
        IF ip_cat_type = 'S' THEN
          cat_price := 150;
        ELSIF ip_cat_type = 'M' THEN
          cat_price := 500;
        ELSIF ip_cat_type = 'L' THEN
          cat_price := 750;
        END IF;
      
        SELECT u.balance
        INTO   avail_balance
        FROM   users u
        WHERE  u.user_id = ip_user_id;
      
        IF cat_price > avail_balance THEN
        
          dbms_output.put_line('Insufficient funds');
          INSERT INTO ERROR_REGISTRY
          VALUES
            (seq_errors.nextval, SYSDATE,
             'ERR_INSUFFICIENT_FUNDS',
             'The user does not have enough money to execute the operation');
        ELSE
          result_balance := cat_price - avail_balance;
        
          CASE ip_cat_type
            WHEN 'S' THEN
              cat_level := 1;
            WHEN 'M' THEN
              cat_level := 11;
            WHEN 'L' THEN
              cat_level := 25;
          END
          
          INSERT INTO cats VALUES(seq_cats.nextval, ip_user_id, ip_cat_name, ip_cat_fur, ip_cat_weight, ip_cat_type, cat_level, ip_room_id);
        
          UPDATE users
          SET    balance = result_balance
          WHERE  user_id = ip_user_id;
        END IF;
      
      ELSE
        dbms_output.put_line('The room is not compatible with the cat');
        INSERT INTO ERROR_REGISTRY
        VALUES
          (seq_errors.nextval, SYSDATE,
           'ERR_ROOM_CAT_INCOMP',
           'The room is not compatible with the cat');
      END IF;
    ELSE
      dbms_output.put_line('The room is NOT empty');
      INSERT INTO ERROR_REGISTRY
      VALUES
        (seq_errors.nextval, SYSDATE, 'ERR_ROOM_TAKEN',
         'The room has already been taken by a cat');
    
    END IF;
  ELSE
    dbms_output.put_line('The user is NOT the owner');
    INSERT INTO ERROR_REGISTRY
    VALUES
      (seq_errors.nextval, SYSDATE, 'ERR_NOT_OWNER',
       'The user is not the owner of the selected room');
  
  END IF;
END;