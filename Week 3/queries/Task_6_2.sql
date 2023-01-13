SELECT u.first_name, u.last_name, c.name, c.fur_color,
       c.weight,
       CASE c.type
          WHEN 'S' THEN
           'Small'
          WHEN 'M' THEN
           'Medium'
          WHEN 'L' THEN
           'Large'
        END AS TYPE, c.cat_level
FROM   users u
JOIN   cats c ON u.user_id = c.user_id