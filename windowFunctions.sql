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
select customer_id,
       title,
       first_name,
       last_name,
       gender,
       count(*) over w                                           as total_customers,
       sum(case when title is not null then 1 else 0 end) over w as total_customers_title
from customers
window w as (partition by gender order by customer_id)
order by customer_id;

-- oblicznie statystyk z użyciem funkcji okna
/*
ROW_NUMBER  - numer bieżącego wiersza w grupie, numerowane od 1
DENSE_RANK  - pozycja wiersza w grupie, nie tworzy luk
RANK        - pozycja wiersza w grupie, tworzy luki
LAG         - wartość uzyskana dla wiersza grupy poprzedzającego bieżący o przsesunięcie
LEAD        - wartość uzyskana dla wiersza grupy następującego po bieżącym o przsesunięcie
NTILE       - dzieli wiersze w grupie namożliwie równe przedziały i przypisuje do każdego wiersza liczby
              całkowiete od 1 do wartości argumentu
*/

select customer_id,
       first_name,
       last_name,
       state,
       date_added::date,
       rank() over (partition by state order by date_added) as cust_rank
from customers
order by state, cust_rank;

-- ramka okna
/*
SELECT
    { kolumny },
    { funkcje_okna } OVER (
        PARTITION BY { klucz_podziału }
        ORDER BY { klucz_porządkowania }
        { RANGE_lub_ROWS } BETWEEN { początek_ramki } AND { koniec_ramki }
    )
FROM
    { tabela };

{ początek_ramki } lub { koniec_ramki }:
UNBOUNDED PRECEDING     - użyte jako początek ramki oznacza pierwszy rekord grupy
{ liczba } PRECEDING    - liczba całkowita wierszy lub przedziałów przed bieżącym wierszem
CURRENT ROW             - bieżący wiersz
{ liczba } FOLLOWING    - liczba całkowita wierszy lub przedziałów po bieżącym wierszu
UNBOUNDED FOLLOWING     - użyte jako koniec ramki oznacza ostatni rekord grupy
 */
with daily_sales as (select sales_transaction_date::date,
                            sum(sales_amount) as total_sales
                     from sales
                     group by 1),
     moving_average_calculation_7 as (select sales_transaction_date,
                                             total_sales,
                                             avg(total_sales)
                                             over (order by sales_transaction_date rows between 6 preceding and current row ) as sales_moving_average_7,
                                             row_number() over (order by sales_transaction_date)                              as row_number
                                      from daily_sales
                                      order by 1)
select sales_transaction_date,
       case when row_number >= 7 then sales_moving_average_7 else null end as sales_moving_average_7
from moving_average_calculation_7;
