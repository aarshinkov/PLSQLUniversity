SELECT 'INSERT INTO DEP_HISTORY VALUES (' || action_id || ', ' ||
        employee_id || ', ' || department_id || ', ' ||
        'TO_DATE(' || TO_CHAR(action_date, 'DD/MM/YYYY') ||
        ', ''dd-mm-yyyy'');'
FROM   dep_history
