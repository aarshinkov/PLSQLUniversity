SELECT e.first_name, e.last_name, e.email,
       COUNT(dh.employee_id) AS "DEPARTMENTS_COUNT"
FROM   dep_history dh
JOIN   employees e ON e.employee_id = dh.employee_id
GROUP  BY dh.employee_id, e.first_name, e.last_name, e.email
HAVING COUNT(dh.employee_id) = 1
