--aggregation functions
select count(base_msrp)                  count,
       min(base_msrp)                    min,
       max(base_msrp)                    max,
       sum(base_msrp)                    sum,
       avg(base_msrp)                    avg,
       sum(base_msrp) / count(base_msrp) avg2,
       stddev(base_msrp)                 stddev, -- standard deviation
       count(distinct base_msrp)         countdistinct
from products;

--aggregation functions with group by clause
select state,
       count(*)
from customers
group by state
order by 1;

select product_type,
       min(base_msrp),
       max(base_msrp),
       avg(base_msrp),
       stddev(base_msrp)
from products
group by product_type
order by product_type;

select to_char(date_added, 'YYYY'),
       count(*)
FROM customers
group by to_char(date_added, 'YYYY')
order by 1;

-- group by clause for many columns
select state, gender, count(*)
from customers
group by state, gender
order by state, gender;

select year,
       product_type,
       count(base_msrp)          count,
       min(base_msrp)            min,
       max(base_msrp)            max,
       sum(base_msrp)            sum,
       avg(base_msrp)            avg,
       stddev(base_msrp)         stddev,
       count(distinct base_msrp) countdistinct
from products
group by year, product_type;

--grouping sets clause
select state,
       gender,
       count(*)
from customers
group by grouping sets ((state),
                        (state, gender))
order by 1, 2;

-- aggregation functions for ordered sets
select percentile_cont(0.5) within group ( order by base_msrp ) as mediana,
       mode() within group ( order by base_msrp ),
       percentile_disc(0.5) within group ( order by base_msrp )
from products;

-- heaving clause
select state, count(*)
from customers
group by state
having count(*) >= 1000
order by state;

-- using aggregation functions to clean data and check them quality
select sum(
               case
                   when
                       state is null or state in ('') then 1
                   else 0 end
       )::float / count(*) as mising_state
from customers;

select count(state)::numeric / count(*)     as non_null_state,
       1 - count(state)::numeric / count(*) as null_state
from customers;

-- checking the uniqueness of data using aggregation functions (true = unique, false = non unique)
select count(distinct customer_id) = count(*) as equal_ids
from customers;

-- data analysis (example)
select count(*) as total_products
from products;

select c.state,
       sum(s.sales_amount)::decimal(12, 2) as total_sales_amount
from sales s
         left join customers c on s.customer_id = c.customer_id
group by c.state
order by 1;

select dealership_id,
       count(*),
       sum(sales_amount)::decimal(12, 2) as total_sales_amount
from sales
where channel like 'dealership'
group by dealership_id
order by 2 desc
limit 5;

select channel,
       product_id,
       avg(sales_amount) as avg_sales_amount
from sales
group by grouping sets ((channel), (product_id), (channel, product_id));
