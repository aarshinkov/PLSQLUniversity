SELECT e.first_name, e.last_name,
       lower(e.first_name || '.' || e.last_name ||
              '@bankoftomorrow.bg') AS email
FROM   employees e
