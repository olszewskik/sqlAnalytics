UPDATE products_2014
SET base_msrp=299.99
WHERE product_type = 'scooter'
  AND year < 2018;

UPDATE products_2022
SET base_msrp = base_msrp * 1.10
WHERE model = 'Model Chi'
  AND year = 2022;