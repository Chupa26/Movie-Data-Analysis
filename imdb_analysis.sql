-- Query 1: Average IMDb Rating by Genre Combination
-- Groups by the full genre field as-is (e.g. "Crime, Drama" as one group)

SELECT 
    Genre,
    ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
    COUNT(*) AS movie_count
FROM imdb_top_1000
GROUP BY Genre
ORDER BY avg_rating DESC;


-- Query 2: Average IMDb Rating by Individual Genre
-- Uses LIKE and UNION ALL to isolate each genre regardless of combinations

SELECT 'Drama' AS genre, ROUND(AVG(IMDB_Rating), 2) AS avg_rating, COUNT(*) AS movie_count
FROM imdb_top_1000 WHERE Genre LIKE '%Drama%'
UNION ALL
SELECT 'Action', ROUND(AVG(IMDB_Rating), 2), COUNT(*)
FROM imdb_top_1000 WHERE Genre LIKE '%Action%'
UNION ALL
SELECT 'Comedy', ROUND(AVG(IMDB_Rating), 2), COUNT(*)
FROM imdb_top_1000 WHERE Genre LIKE '%Comedy%'
UNION ALL
SELECT 'Crime', ROUND(AVG(IMDB_Rating), 2), COUNT(*)
FROM imdb_top_1000 WHERE Genre LIKE '%Crime%'
UNION ALL
SELECT 'Thriller', ROUND(AVG(IMDB_Rating), 2), COUNT(*)
FROM imdb_top_1000 WHERE Genre LIKE '%Thriller%'
UNION ALL
SELECT 'Biography', ROUND(AVG(IMDB_Rating), 2), COUNT(*)
FROM imdb_top_1000 WHERE Genre LIKE '%Biography%'
ORDER BY avg_rating DESC;


--Query 3: Average IMDB Rating by Individual Genre and by Avg Gross per Genre
--Use CAST and REPLACE to convert number text to numerics

SELECT 'Drama' AS genre,
	ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
    COUNT(*) AS movie_count,
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2) AS avg_gross_millions 
FROM imdb_top_1000.csv WHERE Genre LIKE '%Drama%'
UNION ALL
SELECT 'Action', 
	ROUND(AVG(IMDB_Rating), 2),
    COUNT(*),
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2)
FROM imdb_top_1000.csv WHERE Genre LIKE '%Action%'
UNION ALL
SELECT 'Comedy', 
	ROUND(AVG(IMDB_Rating), 2),
    COUNT(*),
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2)
FROM imdb_top_1000.csv WHERE Genre LIKE '%Comedy%'
UNION ALL
SELECT 'Crime', 
	ROUND(AVG(IMDB_Rating), 2),
    COUNT(*),
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2)
FROM imdb_top_1000.csv WHERE Genre LIKE '%Crime%'
UNION ALL
SELECT 'Thriller', 
	ROUND(AVG(IMDB_Rating), 2),
    COUNT(*),
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2)
FROM imdb_top_1000.csv WHERE Genre LIKE '%Thriller%'
UNION ALL
SELECT 'Biography', 
	ROUND(AVG(IMDB_Rating), 2),
    COUNT(*),
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2)
FROM imdb_top_1000.csv WHERE Genre LIKE '%Biography%'
ORDER BY avg_gross_millions DESC;

--Comparing Gross to Director Relationship in Action Genre

SELECT Director,
	COUNT(*) AS movie_count,
	ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2) AS avg_gross_millions
FROM imdb_top_1000.csv WHERE Genre LIKE '%Action%'
GROUP BY Director
ORDER BY avg_gross_millions DESC
LIMIT 10;

--Does start power matter or franchise weight in Action

SELECT Star1,
	COUNT(*) AS movie_count,
	ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2) AS avg_gross_millions
FROM imdb_top_1000.csv WHERE Genre LIKE '%Action%'
GROUP BY Star1
ORDER BY avg_gross_millions DESC
LIMIT 10;

--Remove Action filter

SELECT Star1,
	COUNT(*) AS movie_count,
	ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
	ROUND(AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000), 2) AS avg_gross_millions
FROM imdb_top_1000.csv
GROUP BY Star1
ORDER BY avg_gross_millions DESC
LIMIT 10;

--Practicing Queries and Advanced Filtering
--Top 10 Highest Grossing Films

SELECT Series_Title,
ROUND(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000) AS gross_millions
FROM imdb_top_1000.csv
ORDER BY Gross_millions DESC
LIMIT 10;

--Top 5 Directors By Avg Rating

SELECT Director,
ROUND(AVG(IMDB_Rating), 2) AS avg_rating,
COUNT(Director) AS movie_count
	FROM imdb_top_1000.csv
GROUP BY Director
HAVING COUNT(Director) >=5
ORDER BY avg_rating DESC
LIMIT 5;

--Films Above Avg Gross

SELECT 
    Series_Title,
    ROUND(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000, 2) AS gross_millions,
    ROUND((SELECT AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC) / 1000000) 
     FROM imdb_top_1000.csv), 2) AS avg_gross_millions
FROM imdb_top_1000.csv
WHERE CAST(REPLACE(Gross, ',', '') AS NUMERIC) > 
    (SELECT AVG(CAST(REPLACE(Gross, ',', '') AS NUMERIC)) 
     FROM imdb_top_1000.csv);

--Rank Films by Gross in Desired Genres Showing Top 3 Per Genre

WITH ranked AS (
	SELECT Series_Title,
	Genre,
	CAST(REPLACE(Gross, ',', '') AS NUMERIC) AS gross_cleaned,
	RANK() OVER(PARTITION BY Genre ORDER BY gross_cleaned DESC) AS rank
	FROM imdb_top_1000.csv)

SELECT *
FROM ranked
WHERE rank <= 3 AND gross_cleaned IS NOT NULL AND (Genre LIKE '%Action%' OR Genre LIKE '%Drama%' OR Genre LIKE '%Comedy%' OR Genre LIKE '%Sci-Fi%' OR Genre LIKE '%Romance%');


