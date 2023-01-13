DECLARE
  ip_user_id    users.user_id%TYPE := 1;
  ip_room_stars NUMBER := 9;

  room_price     NUMBER;
  castle_id      castles.castle_id%TYPE;
  avail_balance  users.balance%TYPE;
  result_balance NUMBER;
BEGIN
  room_price := ip_room_stars * 10;

  SELECT c.castle_id
  INTO   castle_id
  FROM   users u
  JOIN   castles c ON u.user_id = c.user_id
  WHERE  u.user_id = ip_user_id;

  SELECT u.balance
  INTO   avail_balance
  FROM   users u
  WHERE  u.user_id = ip_user_id;

  IF room_price > avail_balance THEN
  
    dbms_output.put_line('Insufficient funds');
    INSERT INTO ERROR_REGISTRY
    VALUES
      (seq_errors.nextval, SYSDATE,
       'ERR_INSUFFICIENT_FUNDS',
       'The user does not have enough money to execute the operation');
  
  ELSE
    INSERT INTO ROOMS
    VALUES
      (seq_rooms.nextval, castle_id, ip_room_stars);
  
    result_balance := avail_balance - room_price;
  
    UPDATE users
    SET    balance = result_balance
    WHERE  user_id = ip_user_id;
  
  END IF;
END;