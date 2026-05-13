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
