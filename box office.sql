CREATE DATABASE IF NOT EXISTS box_office_db;
USE box_office_db;

DROP TABLE IF EXISTS box_office;

CREATE TABLE box_office (
    Rank INT,
    Release_Group VARCHAR(255),
    Worldwide BIGINT,
    Domestic BIGINT,
    Domestic_Percentage DECIMAL(5,2),
    Foreign_Collection BIGINT,
    Foreign_Percentage DECIMAL(5,2),
    Year INT,
    Genres VARCHAR(255),
    Rating DECIMAL(3,1),
    Vote_Count INT,
    Original_Language VARCHAR(100),
    Production_Countries VARCHAR(255)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/box office data_Cleaned.csv'
INTO TABLE box_office
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(
Rank,
Release_Group,
Worldwide,
Domestic,
Domestic_Percentage,
Foreign_Collection,
Foreign_Percentage,
Year,
Genres,
Rating,
Vote_Count,
Original_Language,
Production_Countries
);

SELECT * FROM box_office;

SELECT COUNT(*) AS Total_Movies FROM box_office;

SELECT * FROM box_office WHERE Release_Group IS NULL;

SELECT * FROM box_office WHERE Rating IS NULL;

SELECT * FROM box_office WHERE Worldwide IS NULL;

SELECT Release_Group, Year, COUNT(*)
FROM box_office
GROUP BY Release_Group, Year
HAVING COUNT(*) > 1;

SELECT Release_Group, Worldwide
FROM box_office
ORDER BY Worldwide DESC
LIMIT 10;

SELECT Release_Group, Domestic
FROM box_office
ORDER BY Domestic DESC
LIMIT 10;

SELECT Release_Group, Foreign_Collection
FROM box_office
ORDER BY Foreign_Collection DESC
LIMIT 10;

SELECT Release_Group, Worldwide
FROM box_office
ORDER BY Worldwide
LIMIT 10;

SELECT
MAX(Rating),
MIN(Rating),
ROUND(AVG(Rating),2)
FROM box_office;

SELECT Release_Group, Rating
FROM box_office
ORDER BY Rating DESC
LIMIT 10;

SELECT Release_Group, Rating
FROM box_office
WHERE Rating >= 8
ORDER BY Rating DESC;

SELECT Year, COUNT(*)
FROM box_office
GROUP BY Year
ORDER BY Year;

SELECT Year, SUM(Worldwide)
FROM box_office
GROUP BY Year
ORDER BY SUM(Worldwide) DESC;

SELECT Year, ROUND(AVG(Worldwide),0)
FROM box_office
GROUP BY Year
ORDER BY Year;

SELECT Original_Language, COUNT(*)
FROM box_office
GROUP BY Original_Language
ORDER BY COUNT(*) DESC;

SELECT COUNT(*)
FROM box_office
WHERE Original_Language='English';

SELECT Genres, COUNT(*)
FROM box_office
GROUP BY Genres
ORDER BY COUNT(*) DESC
LIMIT 15;

SELECT Production_Countries, COUNT(*)
FROM box_office
GROUP BY Production_Countries
ORDER BY COUNT(*) DESC
LIMIT 15;

SELECT Release_Group, Vote_Count
FROM box_office
ORDER BY Vote_Count DESC
LIMIT 10;

SELECT
MAX(Vote_Count),
ROUND(AVG(Vote_Count),0)
FROM box_office;

SELECT
Release_Group,
Domestic,
Foreign_Collection,
Worldwide
FROM box_office
ORDER BY Worldwide DESC;

SELECT
SUM(Domestic),
SUM(Foreign_Collection)
FROM box_office;

SELECT *
FROM box_office
WHERE Year > 2015;

SELECT *
FROM box_office
WHERE Year < 2000;

SELECT Release_Group, Rating
FROM box_office
WHERE Rating >
(
SELECT AVG(Rating)
FROM box_office
);

SELECT Release_Group, Worldwide
FROM box_office
WHERE Worldwide >
(
SELECT AVG(Worldwide)
FROM box_office
);

SELECT
Year,
COUNT(*),
ROUND(AVG(Rating),2)
FROM box_office
GROUP BY Year
ORDER BY Year;

SELECT
Year,
COUNT(*)
FROM box_office
GROUP BY Year
HAVING COUNT(*) >= 5;

SELECT
Release_Group,
Worldwide,
DENSE_RANK() OVER(ORDER BY Worldwide DESC) AS World_Rank
FROM box_office;

SELECT *
FROM
(
SELECT
Year,
Release_Group,
Worldwide,
ROW_NUMBER() OVER(PARTITION BY Year ORDER BY Worldwide DESC) AS Movie_Rank
FROM box_office
) t
WHERE Movie_Rank <= 5;

SELECT
COUNT(*) AS Total_Movies,
SUM(Worldwide) AS Total_Worldwide,
SUM(Domestic) AS Total_Domestic,
SUM(Foreign_Collection) AS Total_Foreign,
ROUND(AVG(Rating),2) AS Average_Rating,
MAX(Worldwide) AS Highest_BoxOffice,
MAX(Rating) AS Highest_Rating,
MAX(Vote_Count) AS Highest_Votes
FROM box_office;

SELECT
Release_Group,
Worldwide,
Rating
FROM box_office
ORDER BY Worldwide DESC
LIMIT 10;