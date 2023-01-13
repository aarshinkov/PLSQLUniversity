DECLARE
  ip_trader_type traders.trader_type%TYPE := 'I';
  ip_trader_name traders.trader_name%TYPE := 'Atanas Arshinkov';

  is_registered     NUMBER;
  is_questionable   NUMBER;
  ip_curr_trader_id traders.trader_id%TYPE;

BEGIN
  ip_curr_trader_id := seq_traders.nextval;

  IF ip_trader_type = 'I' THEN
    SELECT COUNT(*)
    INTO   is_registered
    FROM   traders t
    WHERE  t.trader_name = ip_trader_name;
  
    IF is_registered = 0 THEN
    
      INSERT INTO traders
      VALUES
        (ip_curr_trader_id, 'I', ip_trader_name);
    
      INSERT INTO batches
      VALUES
        (ip_curr_trader_id, ip_curr_trader_id, 0, SYSDATE);
    END IF;
  
  ELSIF ip_trader_type = 'C' THEN
    SELECT COUNT(*)
    INTO   is_questionable
    FROM   traders t
    JOIN   questionable_traders qt ON t.trader_id =
                                      qt.trader_id
    WHERE  qt.status = 'D'
    AND    t.trader_name = ip_trader_name;
  
    IF is_questionable = 0 THEN
      INSERT INTO traders
      VALUES
        (ip_curr_trader_id, 'C', ip_trader_name);
    
      INSERT INTO batches
      VALUES
        (ip_curr_trader_id, ip_curr_trader_id, 0, SYSDATE);
    
    ELSIF is_questionable <> 0 THEN
      INSERT INTO questionable_traders
      VALUES
        (ip_curr_trader_id, 'M', SYSDATE);
    
      INSERT INTO batches
      VALUES
        (ip_curr_trader_id, ip_curr_trader_id, 0, SYSDATE);
    
    END IF;
  END IF;
END;
