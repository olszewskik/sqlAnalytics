-- removing values from row
UPDATE customers
SET email = NULL
WHERE customer_id = 3;

-- deleting table rows
DELETE
FROM products_2014
WHERE product_type = 'scooter';

DELETE FROM products_2014;

TRUNCATE TABLE products_2014;