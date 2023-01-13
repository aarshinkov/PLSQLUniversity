DECLARE
  ip_cat_id cats.cat_id%TYPE := 1;

  curr_cat_level cats.cat_level%TYPE;
  room_id        cats.room_id%TYPE;
  user_id        cats.user_id%TYPE;
  curr_quantity  user_foods.quantity%TYPE;
BEGIN
  SELECT c.cat_level
  INTO   curr_cat_level
  FROM   cats c
  WHERE  c.cat_id = ip_cat_id;

  SELECT c.cat_level
  INTO   room_id
  FROM   cats c
  WHERE  c.cat_id = ip_cat_id;

  UPDATE cats c
  SET    c.cat_level =
         (curr_cat_level + 1)
  WHERE  cat_id = ip_cat_id;

  SELECT c.cat_level
  INTO   curr_cat_level
  FROM   cats c
  WHERE  c.cat_id = ip_cat_id;

  IF curr_cat_level BETWEEN 11 AND 25 THEN
    UPDATE cats c
    SET    c.type = 'M'
    WHERE  c.cat_id = ip_cat_id;
  ELSIF curr_cat_level BETWEEN 26 AND 99 THEN
    UPDATE cats c
    SET    c.type = 'L'
    WHERE  c.cat_id = ip_cat_id;
  END IF;

  UPDATE rooms r
  SET    r.stars =
         (curr_cat_level + 1)
  WHERE  r.room_id = room_id;

  SELECT c.user_id
  INTO   user_id
  FROM   cats c
  WHERE  c.cat_id = ip_cat_id;

  SELECT uf.quantity
  INTO   curr_quantity
  FROM   user_foods uf
  WHERE  uf.user_id = user_id;

  UPDATE user_foods SET quantity = curr_quantity - 1;
END;