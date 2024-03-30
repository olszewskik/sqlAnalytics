-- CASE WHEN function
SELECT CASE
           WHEN postal_code = '33111' THEN 'VIP'
           WHEN postal_code = '33124' THEN 'Premium'
           ELSE 'Normal'
           END AS customer_type,
       *
FROM customers;

SELECT c.customer_id,
       CASE
           WHEN c.state IN ('MA', 'NH', 'VT', 'ME', 'CT', 'RI') THEN 'New England'
           WHEN c.state IN ('GA', 'FL', 'MS', 'AL', 'LA', 'KY', 'VA', 'NC', 'SC', 'TN', 'VI', 'WV', 'AR')
               THEN 'Southeast'
           ELSE 'Other' END AS region
FROM customers c
ORDER BY 1;

-- COALESCE function - replacing NULL value with selected standard value
SELECT first_name,
       last_name,
       COALESCE(phone, 'NO NUMBER') AS phone
FROM customers
ORDER BY 1;

-- NULLIF function - takes two values and returns NULL value if first value is equal to second
SELECT customer_id,
       NULLIF(title, 'Honorable') AS title,
       first_name,
       last_name,
       suffix,
       email,
       ip_address,
       phone,
       street_address,
       city,
       state,
       postal_code
FROM customers
ORDER BY 1;

-- LEAST and GREATEST functions - takes enu number of values and return smallest or largest of them
SELECT product_id,
       model,
       year,
       product_type,
       base_msrp,
       LEAST(600.00, base_msrp) AS new_base_msrp,
       production_start_date,
       production_end_date
FROM products
WHERE product_type = 'scooter'
ORDER BY 1;

-- CASTING function - changes data type in query
SELECT product_id,
       model,
       year::TEXT,
       product_type,
       base_msrp,
       production_start_date,
       production_end_date
FROM products
;