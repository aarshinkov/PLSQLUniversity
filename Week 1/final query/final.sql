/* Task 1 */
/* Exc_1 */
SELECT d.* FROM DEPARTMENTS d

/* Exc_2 */
SELECT e.first_name, e.last_name, e.salary FROM employees e

/* Exc_3 */
SELECT e.first_name, e.last_name,
       lower(e.first_name || '.' || e.last_name ||
              '@bankoftomorrow.bg') AS email
FROM   employees e

/* Exc_4 */
SELECT e.first_name, e.last_name, e.email,
       (SELECT EXTRACT(YEAR FROM SYSDATE) -
                 EXTRACT(YEAR FROM e.hire_date)
         FROM   dual) AS internship, e.hire_date
FROM   employees e
WHERE  e.hire_date < add_months(SYSDATE, -12 * 5)

/* Exc_5 */
SELECT e.* FROM employees e WHERE e.first_name LIKE 'S%'

/* Exc_6 */
SELECT * FROM employees WHERE LOWER(address) <> 'bulgaria'

/* Exc_7 */
SELECT *
FROM   employees
WHERE  LOWER(first_name) LIKE '%i%'
OR     LOWER(last_name) LIKE '%i%'
OR     LOWER(addit_name) LIKE '%i%'


/* Task 2 */
/* Exc_2 */
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

/* Exc_3 */
SELECT e.first_name, e.last_name, e.email,
       COUNT(dh.employee_id) AS "DEPARTMENTS_COUNT"
FROM   dep_history dh
JOIN   employees e ON e.employee_id = dh.employee_id
GROUP  BY dh.employee_id, e.first_name, e.last_name, e.email
HAVING COUNT(dh.employee_id) = 1

/* Task 3 */
/* Exc_1 */
/* Status 4 is FIRED */
SELECT * FROM employees WHERE status = 4

/* Exc_2 */
/* Status 3 is MOTHERHOOD */
SELECT * FROM employees WHERE status = 3

/* Exc_3 */
/* Status 2 is HOLIDAY/ILL */
SELECT * FROM employees WHERE status = 2

/* Exc_4 */
SELECT * FROM employees WHERE salary BETWEEN 2000 AND 3000

/* Exc_5 */
SELECT *
FROM   employees
WHERE  salary = 2500
OR     salary = 3000
OR     salary = 3500
OR     salary = 5000

/* Exc_6 */
SELECT * FROM employees WHERE manager_id IS NULL

/* Exc_7 */
SELECT e.first_name, e.last_name, e.email, e.salary
FROM   employees e
WHERE  e.hire_date < add_months(SYSDATE, -12 * 5)
AND    SALARY > 5000
ORDER  BY e.first_name DESC

/* Exc_8 */
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

/* Exc_9 */
SELECT d.department_name, SUM(e.salary) AS "SALARY"
FROM   employees e
JOIN   departments d ON e.department_id = d.department_id
WHERE  e.salary = (SELECT MIN(SUM(e.salary)) AS "SALARY"
                   FROM   employees e
                   JOIN   departments d ON e.department_id = d.department_id
                   GROUP  BY e.department_id)
GROUP  BY d.department_id, d.department_name

/* Exc_10 */
SELECT d.department_name, AVG(e.salary) AS "AVERAGE_SALARY"
FROM   employees e
JOIN   departments d ON e.department_id = d.department_id
GROUP  BY e.department_id, d.department_name


/* Task 4 */
/* Exc_1 */
SELECT c.first_name, c.last_name, c.email, a.balance,
       a.currency_type
FROM   customers c
JOIN   accounts a ON c.customer_id = a.customer_id
WHERE  a.currency_type <> 'BGN'

/* Exc_2 */
SELECT c.first_name, c.last_name, c.addit_name, c.email,  a.balance,
       a.currency_type
FROM   customers c
JOIN   accounts a ON c.customer_id = a.customer_id
WHERE  a.balance = 0

/* Exc_3 */
UPDATE accounts a
SET    account_name =
       (SELECT lower(c.first_name || '.account.' ||
                      a.currency_type)
        FROM   customers c
        WHERE  c.customer_id = a.customer_id)
