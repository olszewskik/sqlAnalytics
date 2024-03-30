-- inner join
SELECT s.*
FROM salespeople AS s
         INNER JOIN dealerships AS d
                    ON d.dealership_id = s.dealership_id
WHERE d.state = 'CA'
ORDER BY 1;

-- left outer join
SELECT *
FROM customers AS c
         LEFT JOIN emails AS e ON e.customer_id = c.customer_id
ORDER BY c.customer_id
LIMIT 1000;

SELECT c.customer_id,
       c.title,
       c.first_name,
       c.last_name,
       c.suffix,
       c.email,
       e.email_id,
       e.email_subject,
       e.opened,
       e.clicked,
       e.bounced,
       e.sent_date,
       e.opened_date,
       e.clicked_date
FROM customers c
         LEFT JOIN emails e ON c.customer_id = e.customer_id
WHERE e.customer_id IS NULL
ORDER BY c.customer_id
LIMIT 1000;

-- right outer join
SELECT e.email_id,
       e.email_subject,
       e.opened,
       e.clicked,
       e.bounced,
       e.sent_date,
       e.opened_date,
       e.clicked_date,
       c.customer_id,
       c.title,
       c.first_name,
       c.last_name,
       c.suffix,
       c.email
FROM emails e
         RIGHT JOIN customers c ON e.customer_id = c.customer_id
ORDER BY c.customer_id
LIMIT 1000;

-- full outer join
SELECT *
FROM emails e
         FULL OUTER JOIN customers c ON e.customer_id = c.customer_id;

-- cross join
SELECT p1.product_id, p1.model, p2.product_id, p2.model
FROM products p1
         CROSS JOIN products p2
ORDER BY p1.product_id, p2.product_id;

SELECT c.customer_id, c.first_name, c.last_name, c.phone
FROM sales s
         INNER JOIN customers c ON c.customer_id = s.customer_id
         INNER JOIN products p on p.product_id = s.product_id
WHERE p.product_type = 'automobile'
  AND c.phone IS NOT NULL;

-- sub query
SELECT salespeople.*
FROM salespeople
         INNER JOIN (SELECT *
                     FROM dealerships
                     WHERE state = 'CA') d
                    ON d.dealership_id = salespeople.dealership_id
ORDER BY 1;

SELECT *
FROM salespeople
WHERE dealership_id IN (SELECT dealerships.dealership_id
                        FROM dealerships
                        WHERE state = 'CA')
ORDER BY 1;

-- union
(SELECT street_address, city, state, postal_code
 FROM customers
 WHERE street_address IS NOT NULL)
UNION
(SELECT street_address, city, state, postal_code
 FROM dealerships
 WHERE street_address IS NOT NULL)
ORDER BY 1;

(SELECT first_name, last_name, 'Customer' as guest_type
 FROM customers
 WHERE city = 'Los Angeles'
   AND state = 'CA')
UNION
(SELECT first_name, last_name, 'Employee' as guest_type
 FROM salespeople s
          INNER JOIN dealerships d ON d.dealership_id = s.dealership_id
 WHERE d.city = 'Los Angeles'
   AND d.state = 'CA');

-- CTE common table expressions (WITH)
WITH d AS (SELECT *
           FROM dealerships
           WHERE state = 'CA')
SELECT *
FROM salespeople
         INNER JOIN d ON d.dealership_id = salespeople.dealership_id
ORDER BY 1;
