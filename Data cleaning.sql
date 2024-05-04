select * from layoffs;
#1.remove duplicates 2. standarized the data 3. Null values or blank values 4. remove any columns
Create table layoffs_staging LIKE layoffs; #建立一個複製版本 避免更動到原始data
insert layoffs_staging select * from layoffs;
select * from layoffs_staging where company= "Hibob";
-- 1.remove duplicates
select *, row_number() over(partition by company,industry,total_laid_off,`date`) as row_num from layoffs_staging;
#建立編號看有無重複
WITH duplicate_cte AS
(select *, row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num from layoffs_staging)
select * from duplicate_cte where row_num > 1; #要filter出>1的row 所以建立CTE表格來處理
#MYSQL裡面 CTE沒辦法直接刪除>1的欄位 因此會有下列方法
CREATE TABLE `layoffs_staging2` (
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
select * from layoffs_staging2;
Insert into layoffs_staging2 select *, row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off,`date`,stage,country,funds_raised_millions) as row_num from layoffs_staging;
select * from layoffs_staging2 where row_num>1;
Delete from layoffs_staging2 where row_num>1;
select * from layoffs_staging2 where row_num>1;
-- 2.Standardize data
select company, TRIM(company) from layoffs_staging2; #TRIM is whip out the space in the head.
update layoffs_staging2 SET company=TRIM(company);
select Distinct Industry from layoffs_staging2 order by 1;
select * from layoffs_staging2 where industry LIKe "%crypto%";
update layoffs_staging2 SET industry ='Crypto' where industry LIKE '%crypto%';
select distinct country from layoffs_staging2 order by 1;
select distinct country, trim(trailing "." from country) from layoffs_staging2 order by 1; #把US後面的.去掉
update layoffs_staging2 SET country=trim(trailing "." from country) where country LIKE "%United States%";
select * from layoffs_staging2;
select `date`, STR_TO_DATE(`date`,"%m/%d/%Y") from layoffs_staging2;
update layoffs_staging2 SET `date` = STR_TO_DATE(`date`,"%m/%d/%Y");
Alter table layoffs_staging2 MODIFY COLUMN `date` date;
select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;
select * from layoffs_staging2 where industry is null or industry = '';
select * from layoffs_staging2 where company = 'Carvana';
select * from layoffs_staging2 t1 JOIN layoffs_staging2 t2 on t1.company=t2.company 
where (t1.industry is null or t1.industry='') AND t2.industry is not null;
update layoffs_staging2 SET industry = null where industry= ''; #將空白的改成null
update layoffs_staging2 t1 join layoffs_staging2 t2 SET t1.industry=t2.industry where t1.industry is null AND t2.industry is not null;  #將t2的值複寫到t1 null欄位裡
select * from layoffs_staging2;
select * from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null;
delete from layoffs_staging2 where total_laid_off is null and percentage_laid_off is null; #delete from 不用加*
alter table layoffs_staging2 drop column row_num;
select * from layoffs_staging2;
-- Exploratory data analysis
select max(total_laid_off) from layoffs_staging2;
select * from layoffs_staging2 where percentage_laid_off=1 order by total_laid_off DESC;
select company, sum(total_laid_off) from layoffs_staging2 group by company order by 2 DESC;
select industry, sum(total_laid_off) from layoffs_staging2 group by industry order by 2 DESC;
select MIN(`date`), MAX(`date`) from layoffs_staging2; #date range of the data
select country, sum(total_laid_off) from layoffs_staging2 group by country order by 2 DESC;
select YEAR(`date`), sum(total_laid_off) from layoffs_staging2 group by YEAR(`date`) order by 1 DESC; #YEAR(DATE)直接看哪一年
select substring(`date`,1,7) as `month`, sum(total_laid_off) from layoffs_staging2 where substring(`date`,1,7) is not null group by `month` order by 1 ASC;
With Rolling_Total AS 
(select substring(`date`,1,7) as `month`, sum(total_laid_off) as total_off from layoffs_staging2 where substring(`date`,1,7) is not null group by `month` order by 1 ASC
) select `month`, total_off,sum(total_off) over(order by `month`) as rolling_total from Rolling_Total;
select company,YEAR(`date`),sum(total_laid_off) from layoffs_staging2 group by company,YEAR(`date`) order by company ;
WITH Company_Year(Company,Years,Total_Laid_Off) AS 
(
select company,YEAR(`date`),sum(total_laid_off) from layoffs_staging2 group by company,YEAR(`date`)
), 
Company_Year_Rank as (
select *, DENSE_RANK() OVER(partition by years order by total_laid_off DESC) as ranking from Company_Year where Years is not null)
select * from Company_Year_Rank where ranking <=5;

