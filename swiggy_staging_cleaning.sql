select * from swiggy;

select count(distinct name)
from swiggy;

--Created copy table for work
create table swiggy_staging 
(like swiggy );
insert into swiggy_staging
select * from swiggy;

select * from swiggy_staging;

--data cleaning
--1) Remove duplicates
--2) Split data of cuisine into 2 columns for better anaylsis
--3) Removed unwanted columns
--4) Handeled null values 

with duplicate as (
  select * ,
  row_number() over(partition by "id", "lic_no") as row_num
  from swiggy_staging
)
select * 
from duplicate 
where row_num > 1;
--there is no duplicate values in it 

select distinct rating_count
from swiggy_staging
order by rating_count;

alter table swiggy_staging add column rating_count_encoded int;

UPDATE swiggy_staging
SET rating_count_encoded = CASE
    WHEN rating_count IN ('Too Few Ratings', 'NA') THEN 0
    WHEN rating_count = '20+ ratings' THEN 1
    WHEN rating_count = '50+ ratings' THEN 2
    WHEN rating_count = '100+ ratings' THEN 3
    WHEN rating_count = '500+ ratings' THEN 4
    WHEN rating_count = '1K+ ratings' THEN 5
    WHEN rating_count = '5K+ ratings' THEN 6
    WHEN rating_count = '10K+ ratings' THEN 7
    ELSE NULL
END;
-- rating_count categories into ordinal encoding

SELECT cuisine, array_length(string_to_array(cuisine, ','), 1) AS num_parts -- Checked here how many part cuisine have
FROM swiggy_staging
ORDER BY num_parts DESC
LIMIT 10;

alter table swiggy_staging 
add column cuisine_primary text ,
add column cuisine_secondary text;

update swiggy_staging 
set cuisine_primary = split_part(cuisine,',',1),
    cuisine_secondary = nullif(split_part(cuisine,',',2) , '');

alter table swiggy_staging
add column area text,
add column cities text;


update swiggy_staging
set area = split_part(city,',',1),
    cities = nullif(split_part(city , ',' , 2) , '');
	


SELECT DISTINCT tag -- Maked list of Unique value from both columns
FROM (
    SELECT cuisine_primary AS tag FROM swiggy_staging
    UNION
    SELECT cuisine_secondary AS tag FROM swiggy_staging
) t
WHERE tag IS NOT NULL
ORDER BY tag;

update swiggy_staging -- Standarisied with space and captilization
set cuisine_primary = initcap(trim(cuisine_primary)),
    cuisine_secondary = initcap(trim(cuisine_secondary));

UPDATE swiggy_staging -- Found 2 same values made it same 
SET cuisine_primary = 'Beverages'
WHERE cuisine_primary = 'Beverage';

UPDATE swiggy_staging -- Found 2 same values made it same 
SET cuisine_secondary = 'Beverages'
WHERE cuisine_secondary = 'Beverage';

alter table swiggy_staging
add column cuisine_type text,
add column cuisine_food text;

update swiggy_staging -- Created 2 columns for type and food 
set cuisine_type = case 
    WHEN cuisine_primary IN ('Afghani','African','American','Andhra','Arabian','Asian','Assamese','Australian','Awadhi','Bangladeshi','Bengali','Bhutanese','Bihari','British','Burmese','Chettinad','Chinese','Coastal','Continental','European','French','German','Goan','Greek','Gujarati','Hyderabadi','Indian','Indonesian','Italian','Italian-American','Japanese','Kashmiri','Kerala','Konkan','Korean','Lebanese','Lucknowi','Maharashtrian','Malaysian','Malwani','Mangalorean','Mediterranean','Mexican','Middle Eastern','Mongolian','Mughlai','Naga','Nepalese','North Eastern','North Indian','Oriental','Oriya','Pan-Asian','Parsi','Persian','Portuguese','Punjabi','Rajasthani','Rayalaseema','Sindhi','Singaporean','South American','South Indian','Spanish','Sri Lankan','Tex-Mex','Thai','Telangana','Tibetan','Tribal','Turkish','Vietnamese')
    then cuisine_primary
	WHEN cuisine_secondary IN ('Afghani','African','American','Andhra','Arabian','Asian','Assamese','Australian','Awadhi','Bangladeshi','Bengali','Bhutanese','Bihari','British','Burmese','Chettinad','Chinese','Coastal','Continental','European','French','German','Goan','Greek','Gujarati','Hyderabadi','Indian','Indonesian','Italian','Italian-American','Japanese','Kashmiri','Kerala','Konkan','Korean','Lebanese','Lucknowi','Maharashtrian','Malaysian','Malwani','Mangalorean','Mediterranean','Mexican','Middle Eastern','Mongolian','Mughlai','Naga','Nepalese','North Eastern','North Indian','Oriental','Oriya','Pan-Asian','Parsi','Persian','Portuguese','Punjabi','Rajasthani','Rayalaseema','Sindhi','Singaporean','South American','South Indian','Spanish','Sri Lankan','Tex-Mex','Thai','Telangana','Tibetan','Tribal','Turkish','Vietnamese')
    then cuisine_secondary
	else null
end,
cuisine_food = case
    WHEN cuisine_primary IN ('Bakery','Bakery products','Barbecue','Beverages','Biryani','Bowl Company','Burgers','Cafe','Chaat','Combo','Desserts','Fast Food','Grill','Haleem','Healthy Food','Home Food','Ice Cream','Ice Cream Cakes','Jain','Juices','Kebabs','Keto','Meat','Paan','Pastas','Pizzas','Salads','Seafood','Snacks','Steakhouse','Street Food','Sushi','Sweets','Tandoor','Thalis','Waffle')
    then cuisine_primary
	WHEN cuisine_secondary IN ('Bakery','Bakery products','Barbecue','Beverages','Biryani','Bowl Company','Burgers','Cafe','Chaat','Combo','Desserts','Fast Food','Grill','Haleem','Healthy Food','Home Food','Ice Cream','Ice Cream Cakes','Jain','Juices','Kebabs','Keto','Meat','Paan','Pastas','Pizzas','Salads','Seafood','Snacks','Steakhouse','Street Food','Sushi','Sweets','Tandoor','Thalis','Waffle')
    then cuisine_secondary
	else null
end; 

alter table swiggy_staging 
drop column cuisine_primary;

alter table swiggy_staging 
drop column cuisine_secondary;

ALTER TABLE swiggy_staging
DROP COLUMN cuisine;

update swiggy_staging 
set rating = null
where rating in ('--','NEW','NA');

alter table swiggy_staging
alter column rating type numeric using rating :: numeric;

select 
sum(CASE WHEN rating IS NULL THEN 1 ELSE 0 END) as rating_null,
SUM(CASE WHEN name IS NULL THEN 1 ELSE 0 END) AS null_names,
SUM(CASE WHEN city IS NULL THEN 1 ELSE 0 END) AS null_city
from swiggy_staging;


SELECT 
    ROUND(COUNT(*) FILTER (WHERE rating IS NULL) * 100.0 / COUNT(*), 2) AS null_pct
FROM swiggy_staging;


