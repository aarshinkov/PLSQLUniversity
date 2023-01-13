SELECT e.first_name, e.last_name, e.email,
       (SELECT EXTRACT(YEAR FROM SYSDATE) -
                 EXTRACT(YEAR FROM e.hire_date)
         FROM   dual) AS internship, e.hire_date
FROM   employees e
WHERE  e.hire_date < add_months(SYSDATE, -12 * 5)
