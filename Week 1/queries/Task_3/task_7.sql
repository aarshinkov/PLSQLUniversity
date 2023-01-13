SELECT e.first_name, e.last_name, e.email, e.salary
FROM   employees e
WHERE  e.hire_date < add_months(SYSDATE, -12 * 5)
AND    SALARY > 5000
ORDER  BY e.first_name DESC
