DECLARE
  ip_user_id       users.user_id%TYPE := 1;
  ip_food_name     foods.food_name%TYPE := 'BitScas';
  ip_food_quantity NUMBER := 2;

  is_user_foods_exists NUMBER;

  current_quantity NUMBER;
BEGIN
  SELECT COUNT(*)
  INTO   is_user_foods_exists
  FROM   user_foods uf
  WHERE  uf.user_id = 1;

  IF is_user_foods_exists <> 0 THEN
  
    SELECT uf.quantity
    INTO   current_quantity
    FROM   user_foods uf
    WHERE  uf.user_id = ip_user_id;
  
    UPDATE user_foods SET quantity = current_quantity + 1;
  
  ELSE
    INSERT INTO user_foods
    VALUES
      (seq_user_foods.nextval, ip_user_id, ip_food_name,
       ip_food_quantity);
  
  END IF;
END;