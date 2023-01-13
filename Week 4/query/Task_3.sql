SELECT b.city,
       CASE b.branch_size
          WHEN 'S' THEN
           'Small'
          WHEN 'M' THEN
           'Medium'
          WHEN 'L' THEN
           'Large'
        END branch_size,
       CASE b.is_special
          WHEN 'Y' THEN
           'Yes'
          WHEN 'N' THEN
           'No'
        END is_special, bp.avail_quant,
       CASE bp.avail_quant
          WHEN 0 THEN
           'The product is not available'
        END information
FROM   branch_products bp
JOIN   branches b ON bp.branch_id = b.branch_id
WHERE  bp.branch_id = 1
