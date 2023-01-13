SELECT *
FROM   (SELECT em.first_name, em.last_name, em.email,
                em.position, em.salary, em.department_id
         FROM   employees em
         WHERE  em.salary =
                (SELECT MAX(SALARY)
                 FROM   employees e
                 WHERE  e.department_id = em.department_id
                 GROUP  BY e.department_id)
         ORDER  BY salary DESC)
WHERE  ROWNUM <= 5
