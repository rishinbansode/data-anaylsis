select * from swiggy_staging;

select area , avg(rating) as avg_rating
from swiggy_staging
group by area
having avg(rating) is not null
order by avg_rating desc;

UPDATE swiggy_staging
SET cost = NULL
WHERE cost = 'NA';


update swiggy_staging 
set cost = replace(cost , '₹' , ' ' );

alter table swiggy_staging 
alter column cost type numeric using cost::numeric;


select cuisine_type , cuisine_food , max(cost) as max_cost
from swiggy_staging
group by cuisine_type , cuisine_food 
having max(cost) is not null
order by max_cost desc;

select cuisine_type , cuisine_food , min(cost) as min_cost
from swiggy_staging
group by cuisine_type , cuisine_food 
order by min_cost;

SELECT id, name, cost , cuisine_type , cuisine_food 
FROM swiggy_staging
WHERE cost < 50
ORDER BY cost;

SELECT COUNT(*) FROM swiggy_staging WHERE cost < 50;

UPDATE swiggy_staging
SET cost = NULL
WHERE cost < 50;

select cities , count(*) as totla_resturant -- numbers of hotel in city 
from swiggy_staging
group by cities
order by totla_resturant desc;

-- Top 5 cities with highest average restaurant rating?
select cities , avg(rating) as avg_rating
from swiggy_staging
group by  cities 
order by avg_rating desc
limit 5;

-- Q6: Which cuisines have the highest average rating?
select cuisine_food, 
       avg(rating) as high_avg_rating
from swiggy_staging
where rating is not null
group by cuisine_food
order by high_avg_rating desc;

-- Q7: Restaurants with rating above 4.5 and more than 1000 ratings
select name , rating
from swiggy_staging
where rating > 4.5 
and rating_count_encoded >= 5
order by rating;


-- which city has best value for money?
-- (high rating, low cost)
select cities , avg(rating) as avg_rating , avg(cost) as avg_cost
from swiggy_staging
group by cities
having avg(rating) is not null
order by avg_rating desc , avg_cost ;

-- Which area has the highest average restaurant cost
select area , avg(cost) as avg_cost
from swiggy_staging
group by area
order by avg_cost desc;

-- Which city has the highest average restaurant cost
select cities, avg(cost) as avg_cost
from swiggy_staging
group by cities 
order by avg_cost desc;

-- Which city which area charge how much?
select trim(cities), area , avg(cost) as avg_cost
from swiggy_staging
group by cities , area
order by trim(cities) , avg_cost desc;


with total_area as (
   select trim(cities) as cities, area , avg(cost) as avg_cost
   from swiggy_staging
   group by cities , area
   order by trim(cities) , avg_cost desc
) 
select cities , area, avg_cost, 
sum(avg_cost) over(partition by cities order by avg_cost desc) as rolling_total
from total_area
order by cities , avg_cost desc ;

-- Famous resturants in city 
select name , cities, rating
from(
   select name , cities, rating,
   ROW_NUMBER() OVER (PARTITION BY cities ORDER BY rating DESC) as row_num
   from swiggy_staging
   where rating > 4.5 
   and rating_count_encoded >= 5
   order by rating desc , cities
) as t 
where row_num < 2;

-- numbers of restaurants per city
SELECT cities, COUNT(*) AS total_restaurants
FROM swiggy_staging
GROUP BY cities
ORDER BY total_restaurants DESC;

