SELECT c.first_name, c.last_name, c.email, a.balance,
       a.currency_type
FROM   customers c
JOIN   accounts a ON c.customer_id = a.customer_id
WHERE  a.currency_type <> 'BGN'
