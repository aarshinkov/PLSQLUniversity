SELECT *
FROM   employees
WHERE  LOWER(first_name) LIKE '%i%'
OR     LOWER(last_name) LIKE '%i%'
OR     LOWER(addit_name) LIKE '%i%'
