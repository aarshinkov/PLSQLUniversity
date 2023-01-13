UPDATE accounts a
SET    account_name =
       (SELECT lower(c.first_name || '.account.' ||
                      a.currency_type)
        FROM   customers c
        WHERE  c.customer_id = a.customer_id)
