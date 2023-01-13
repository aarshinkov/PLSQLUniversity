SELECT d.department_name, SUM(e.salary) AS "SALARY"
FROM   employees e
JOIN   departments d ON e.department_id = d.department_id
WHERE  e.salary = (SELECT MIN(SUM(e.salary)) AS "SALARY"
                   FROM   employees e
                   JOIN   departments d ON e.department_id = d.department_id
                   GROUP  BY e.department_id)
GROUP  BY d.department_id, d.department_name
