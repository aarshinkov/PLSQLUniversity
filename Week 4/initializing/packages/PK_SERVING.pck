CREATE OR REPLACE PACKAGE PK_SERVING IS

  PROCEDURE pay_by_card(ip_card_id   IN NVARCHAR2,
                        ip_branch_id IN NUMBER,
                        ip_prod_id   IN NUMBER,
                        ip_quant     IN NUMBER);

  FUNCTION get_card_balance(ip_card_id IN NVARCHAR2)
    RETURN NUMBER;

  FUNCTION get_final_price(ip_prod_id IN NUMBER,
                           ip_quant   IN NUMBER)
    RETURN NUMBER;

END PK_SERVING;
/
CREATE OR REPLACE PACKAGE BODY PK_SERVING IS

  -- pay_by_card
  PROCEDURE pay_by_card(ip_card_id   IN NVARCHAR2,
                        ip_branch_id IN NUMBER,
                        ip_prod_id   IN NUMBER,
                        ip_quant     IN NUMBER) IS
    v_is_in_stock    NUMBER;
    v_avail_quantity NUMBER := 0;
    v_card_balance   NUMBER;
    v_price_to_pay   NUMBER;
    v_cash_balance   NUMBER;
  BEGIN
    -- Ako potrebitel iska 0 ili otricatelen broi artikuli
    IF ip_quant <= 0 THEN
      dbms_output.put_line('Error - client require 0 or negative products');
      INSERT INTO error_registry
      VALUES
        (seq_errors.nextval, 'ERR_INV_PROD_QUANT', SYSDATE);
      RETURN;
    END IF;
  
    -- Proverka dali produkta e nalichen v restoranta
    SELECT COUNT(*)
    INTO   v_is_in_stock
    FROM   branch_products
    WHERE  branch_id = ip_branch_id
    AND    prod_id = ip_prod_id;
  
    IF v_is_in_stock = 0 THEN
      dbms_output.put_line('No available products found');
      INSERT INTO error_registry
      VALUES
        (seq_errors.nextval, 'ERR_NO_AVAIL_PROD', SYSDATE);
      RETURN;
    END IF;
  
    -- Kolko ima v nalichnost ot produkta
    SELECT avail_quant
    INTO   v_avail_quantity
    FROM   branch_products
    WHERE  branch_id = ip_branch_id
    AND    prod_id = ip_prod_id;
  
    dbms_output.put_line('Available quantity: ' ||
                         v_avail_quantity);
    dbms_output.put_line('Quantity required: ' || ip_quant);
  
    -- Ako se napravi opit da se prodadat poveche produkti ot nalichnite
    IF ip_quant > v_avail_quantity THEN
      dbms_output.put_line('Inserting into error registry - you require more that the available products');
      INSERT INTO error_registry
      VALUES
        (seq_errors.nextval, 'ERR_INSUFF_PRODUCTS', SYSDATE);
      RETURN;
    END IF;
  
    v_price_to_pay := get_final_price(ip_prod_id, ip_quant);
    dbms_output.put_line('Price to pay: ' ||
                         v_price_to_pay);
  
    dbms_output.put_line('');
    dbms_output.put_line('Processing card payment...');
    dbms_output.put_line('Price to pay: ' ||
                         v_price_to_pay);
    dbms_output.put_line('Branch ID: ' || ip_branch_id);
    dbms_output.put_line('Card ID: ' || ip_card_id);
  
    SELECT balance
    INTO   v_cash_balance
    FROM   cash_desks
    WHERE  branch_id = ip_branch_id;
  
    dbms_output.put_line('Cash balance: ' ||
                         v_cash_balance);
  
    SELECT card_amount
    INTO   v_card_balance
    FROM   dc_info
    WHERE  card_id = ip_card_id;
  
    IF (v_card_balance - v_price_to_pay) < 0 THEN
      dbms_output.put_line('No money left in the card');
      RETURN;
    END IF;
  
    dbms_output.put_line('Card balance: ' ||
                         v_card_balance);
  
    dbms_output.put_line('');
  
    dbms_output.put_line('New cash balance: ' ||
                         (v_cash_balance + v_price_to_pay));
    UPDATE cash_desks
    SET    balance =
           (v_cash_balance + v_price_to_pay)
    WHERE  branch_id = ip_branch_id;
  
    dbms_output.put_line('New card balance: ' ||
                         (v_card_balance - v_price_to_pay));
  
    UPDATE dc_info
    SET    card_amount =
           (v_card_balance - v_price_to_pay)
    WHERE  card_id = ip_card_id;
  
    dbms_output.put_line('Quantity left: ' ||
                         (v_avail_quantity - ip_quant));
  
    UPDATE branch_products
    SET    avail_quant = v_avail_quantity - ip_quant
    WHERE  prod_id = 3
    AND    branch_id = 4;
  
  EXCEPTION
    WHEN NO_DATA_FOUND THEN
      dbms_output.put_line('No data has been found! The purchase cannot be finished.');
  END pay_by_card;

  -- get_card_balance
  FUNCTION get_card_balance(ip_card_id IN NVARCHAR2)
    RETURN NUMBER IS
    v_balance NUMBER;
  BEGIN
    SELECT card_amount
    INTO   v_balance
    FROM   dc_info
    WHERE  card_id = ip_card_id;
  
    RETURN v_balance;
  END get_card_balance;

  -- get_final_price
  FUNCTION get_final_price(ip_prod_id IN NUMBER,
                           ip_quant   IN NUMBER)
    RETURN NUMBER IS
    v_final_price NUMBER;
  BEGIN
    SELECT (price * ip_quant)
    INTO   v_final_price
    FROM   products
    WHERE  prod_id = ip_prod_id;
  
    RETURN v_final_price;
  END get_final_price;
END PK_SERVING;
/
