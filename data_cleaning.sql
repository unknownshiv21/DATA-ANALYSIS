select *
from layoffs;

create table layoff_staging 
like layoffs;

select*
from layoff_staging;

insert into layoff_staging
select*
from layoffs;

select *,
row_number() over(
partition by company, location, industry, total_laid_off, percentage_laid_off,`date`,stage, country, funds_raised_millions) as row_num
from layoff_staging

with duplicate_cte as
(
select*,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off,`date`,stage, country, funds_raised_millions) as row_num
from layoff_staging
)
select *
from duplicate_cte
where row_num > 1;


select *
from duplicate_cte
where row_num > 1;

select*
from layoff_staging
where company = 'oda';

CREATE TABLE `layoff_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` int
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

select*
from layoff_staging2
where row_num > 1;

insert into layoff_staging2
select*,
row_number() over(partition by company, location, industry, total_laid_off, percentage_laid_off,`date`,stage, country, funds_raised_millions) as row_num
from layoff_staging;

delete
from layoff_staging2
where row_num > 1;

select*
from layoff_staging2;

select company, trim(company)
from layoff_staging2;

update layoff_staging2
set company=trim(company);

select*
from layoff_staging2;

select distinct industry
from layoff_staging2
order by 1;

select *
from layoff_staging2
where industry like 'crypto%';


update layoff_staging2
set industry ='crypto'
where industry like 'crypto%';

select location, trim(location)
from layoff_staging2;

select distinct country, trim(trailing '.' from country)
from layoff_staging2
order by 1;

update layoff_staging2
set country =  trim(trailing '.' from country)
where country like 'United States';

select `date`,
str_to_date(`date`, '%m/%d/%Y')
from layoff_staging2;

select `date`
from layoff_staging2;

update layoff_staging2
set `date`= str_to_date(`date`, '%m/%d/%Y');

alter table layoff_staging2
modify column `date` date;

select *
from layoff_staging2
where total_laid_off is null 
and percentage_laid_off is null;

select *
from layoff_staging2
where industry is null
or industry = '';

update layoff_staging2
set industry =null
where industry ='';


select *
from layoff_staging2
where company = 'Airbnb';

select t1.industry, t2.industry
from layoff_staging2 t1
join layoff_staging2 t2
on t1. company = t2.company
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

update layoff_staging2 t1
join layoff_staging2 t2
on t1. company = t2.company
set t1.industry=t2.industry
where (t1.industry is null or t1.industry='')
and t2.industry is not null;

select*
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

delete 
from layoff_staging2
where total_laid_off is null
and percentage_laid_off is null;

select*
from layoff_staging2;

alter table layoff_staging2
drop column row_num;


# Results 

### 📊 Top Layoff Rankings by Company (Cleaned SQL Output)

| Company       | Year | Total Laid Off | Ranking |
|--------------|------|----------------|---------|
| Uber         | 2020 | 7525           | 1       |
| Katerra      | 2021 | 2434           | 1       |
| Meta         | 2022 | 11000          | 1       |
| Google       | 2023 | 12000          | 1       |
| Booking.com  | 2020 | 4375           | 2       |
| Zillow       | 2021 | 2000           | 2       |
| Amazon       | 2022 | 10000          | 2       |
| Microsoft    | 2023 | 10000          | 2       |
| Groupon      | 2020 | 2800           | 3       |
| Better.com   | 2021 | 900            | 3       |
| Cisco        | 2022 | 4100           | 3       |
| Ericsson     | 2023 | 8500           | 3       |
| Airbnb       | 2020 | 1900           | 4       |
| Dropbox      | 2021 | 315            | 4       |
| Peloton      | 2022 | 4084           | 4       |
| Amazon       | 2023 | 8000           | 4       |
| Salesforce   | 2023 | 8000           | 4       |
| Agoda        | 2020 | 1500           | 5       |
| PaisaBazaar  | 2020 | 1500           | 5       |
| Bounce       | 2021 | 200            | 5       |
| Carvana      | 2022 | 4000           | 5       |
| Philips      | 2022 | 4000           | 5       |
| Dell         | 2023 | 6650           | 5       |
