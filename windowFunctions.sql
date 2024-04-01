/*
podstawowa składnia funkcji okna

SELECT {kolumny},
{funkcja_okna} OVER (PARTITION BY {klucz_podziału} ORDER BY {klucz_porządkowania})
FROM tabela;
 */

select customer_id,
       title,
       first_name,
       last_name,
       gender,
       count(*) over (partition by gender) as total_customers
from customers
order by customer_id;

select customer_id,
       title,
       first_name,
       last_name,
       gender,
       count(*) over (order by customer_id) as total_customers
from customers
order by customer_id;

select customer_id,
       title,
       first_name,
       last_name,
       gender,
       count(*) over (partition by gender order by customer_id) as total_customers
from customers
order by customer_id;

select customer_id,
       street_address,
       date_added::date,
       count(case when street_address is not null then customer_id else null end)
       over (order by date_added::date)          as non_null_street_address,
       count(*) over (order by date_added::date) as total_street_address
from customers
order by date_added;


with daily_rolling_count as (select customer_id,
                                    street_address,
                                    date_added::date,
                                    count(case when street_address is not null then customer_id else null end)
                                    over (order by date_added::date)          as non_null_street_address,
                                    count(*) over (order by date_added::date) as total_street_address
                             from customers)
select distinct date_added,
                non_null_street_address,
                total_street_address,
                100 - non_null_street_address::numeric * 100 / total_street_address as null_address_percentage
from daily_rolling_count
order by date_added;

-- słowo kluczowe WINDOW
