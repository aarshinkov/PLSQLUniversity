SELECT u.first_name, u.last_name, c.name, c.fur_color,
       c.weight,
       CASE c.type
          WHEN 'S' THEN
           'Small'
          WHEN 'M' THEN
           'Medium'
          WHEN 'L' THEN
           'Large'
        END AS TYPE, c.room_id
FROM   cats c
JOIN   users u ON c.user_id = u.user_id
ORDER  BY u.first_name