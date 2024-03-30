-- simple create statement
DROP TABLE IF EXISTS state_populations;
CREATE TABLE state_populations
(
    state      VARCHAR(2) PRIMARY KEY,
    population NUMERIC
);

DROP TABLE IF EXISTS countries;
CREATE TABLE countries
(
    key           INT PRIMARY KEY,
    name          TEXT UNIQUE,
    founding_year INT,
    capital       TEXT
);

-- creating tables using select query
CREATE TABLE products_2014 AS
    (SELECT *
     FROM products
     WHERE year = 2014);

select column_name, data_type
from information_schema.columns
where table_name = 'products_2014';

CREATE TABLE products_2022 AS
    (SELECT *
     FROM products
     WHERE year = 2022);