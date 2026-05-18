# Movie-Data-Analysis

Project Overview

An exploratory data analysis of the IMDb Top 1000 movies dataset sourced from Kaggle. The goal is to uncover relationships between ratings, genres, directors, box office performance, and other variables using SQL queries of increasing complexity.

Goals

Practice and apply SQL skills developed through DataCamp's Associate Data Analyst track
Build toward a Power BI dashboard that visualizes key insights
Document the learning process as skills grow

Tools Used

SQL (DataCamp workspace)
Dataset: IMDb Top 1000 — Kaggle
AI-assisted debugging and query review: Claude (Anthropic)

Status: In progress — queries and findings updated as new SQL skills are developed

Key Findings So Far
Ratings vs. Box Office Disconnect
Drama dominates by volume (724 of 1000 films) and has the highest average IMDb rating (7.96), yet Action films earn more than double at the box office ($141M avg gross vs Drama's lower figure). Comedy and Thriller also outgross higher-rated genres commercially.
This suggests a measurable gap between critical/audience acclaim and commercial performance — audiences and studios prioritize different things.

Director & Actor Analysis — Action Genre
Queried top 10 Action directors and top-billed actors by average gross revenue. Anthony Russo ranked first among directors with 4 films averaging the highest gross, consistent with his work on high-performing Marvel franchise films.
Star Power vs. Franchise Power
Top-billed actors in high-grossing Action films largely represent franchise properties rather than individual star draws (e.g. Star Wars, Marvel). When the Action genre filter was removed and the query run across the full dataset, the top earners remained largely unchanged — suggesting modern box office performance is driven by franchise brand rather than individual actors regardless of genre.
SQL Techniques Applied This Session

REPLACE and CAST for cleaning and converting text-formatted currency data
LIKE with UNION ALL for isolating individual genres from multi-value fields
Aggregations: AVG, COUNT, ROUND
GROUP BY, ORDER BY, LIMIT
Independently debugged column alias errors and table reference issues

Visualization Attempt

Dataset Imported Into Power BI
Genres were not split
Averages of Rating and Gross were looked at by natively grouped genres using horizontal bar charts

Analysis
The dataset suggests that critical and audience acclaim, as measured by IMDb rating, shows little correlation with box office performance at the genre level. Genres with the highest average ratings do not consistently produce the highest grossing films, implying that factors beyond perceived quality — franchise brand, marketing, mass appeal — drive commercial success.

Further comparative analysis to confirm thesis using scatter plot

Individual Film Analysis — Scatter Plot
A scatter plot of IMDb Rating vs. Gross revenue at the individual film level confirms the genre-level finding. The Shawshank Redemption, the highest rated film in the dataset at 9.3, is among the lowest grossing. Star Wars Episode 7, rated 7.5, earned nearly $900M. The data shows no clear upward trend between rating and gross revenue, reinforcing that perceived quality does not drive commercial success — franchise brand does.


SQL Practice — Subqueries & Advanced Filtering

Practiced three additional queries with increasing complexity using a plan-first approach before writing code:

Top 10 Highest Grossing Films — identified text-to-numeric conversion as a prerequisite before sorting, correcting an initial alphabetic sort error independently.

Top 5 Directors by Average Rating (min. 5 films) — used GROUP BY, HAVING, and ROUND to filter on aggregated results. Christopher Nolan ranked first at 8.46 across 8 films. Notably Charles Chaplin and Sergio Leone appeared, suggesting timeless critical regard for classic era directors.

Films Above Average Gross — introduced subqueries to calculate dataset average gross and filter against it. 239 of 1000 films beat the average, consistent with expected skew from franchise blockbuster outliers.


