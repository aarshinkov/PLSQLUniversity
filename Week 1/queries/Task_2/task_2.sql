SELECT e.first_name, e.last_name, e.email
FROM   employees e
JOIN   dep_history dh ON e.employee_id = dh.employee_id
WHERE  dh.action_date > add_months(SYSDATE, -2)
INTERSECT
SELECT e.first_name, e.last_name, e.email
FROM   dep_history dh
JOIN   employees e ON e.employee_id = dh.employee_id
GROUP  BY dh.employee_id, e.first_name, e.last_name, e.email
HAVING COUNT(dh.employee_id) >= 2
