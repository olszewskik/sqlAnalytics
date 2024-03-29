SELECT email
FROM customers
WHERE state = 'FL'
ORDER BY email;

SELECT first_name
     , last_name
     , email
FROM customers
WHERE state = 'NY'
  AND city = 'New York City'
ORDER BY last_name, first_name;