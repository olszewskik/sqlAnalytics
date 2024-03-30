-- DISTINCT and DISTINCT ON functions
SELECT DISTINCT year
FROM products
ORDER BY 1;

SELECT DISTINCT year, product_type
FROM products
ORDER BY 1, 2;

SELECT DISTINCT ON (first_name) *
FROM salespeople
ORDER BY first_name, hire_date