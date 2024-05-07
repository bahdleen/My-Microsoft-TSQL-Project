-- Programmer: Edjenuwa Anthony Efemena
-- SQL Database (European Soccer Leagues – Seasons from 2008-2015)
-- Teesside University Middlesbrough


USE EuroLeagues;

GO
-- Select and execute the following query to retrieve all columns
-- all rows from player table
SELECT *
FROM
player

USE EuroLeagues;
GO
-- Select and execute the following query to retrieve all columns
-- all rows from player table
SELECT match.id, match.season, match.stage, match.home_team_api_id, match.season, match.mdate
FROM match;

USE EuroLeagues;
GO
-- Select and execute the following query to retrieve all columns
-- To generate a DISTINCT query from player_attributes
SELECT DISTINCT overall_rating, heading_accuracy, short_passing, sprint_speed
FROM player_attributes;

USE EuroLeagues;
GO
SELECT DISTINCT league_id, home_team_goal, id
-- Select and execute the following query to retrieve all columns
-- To generate a DISTINCT query from player_attributes
FROM match

USE EuroLeagues;

GO

SELECT 
-- p is the alias for the player table.
-- pa is the alias for the player_attributes table.
-- m is the alias for the match table.
-- t is the alias for the team table.
-- l is the alias for the league table.

    p.player_name AS 'Player Name', 
    pa.overall_rating AS 'Overall Rating', 
    t.team_long_name AS 'Team Name', 
    l.name AS 'League Name'

FROM 

    player AS p
INNER JOIN 
    player_attributes AS pa ON p.player_api_id = pa.player_api_id
INNER JOIN 
-- Assuming we’re only interested in the matches
    match AS m ON p.player_api_id = m.match_api_id  
INNER JOIN 
    team AS t ON m.home_team_api_id = t.team_api_id
INNER JOIN 
    league AS l ON m.league_id = l.id;

USE EuroLeagues;
GO
-- This CASE expression evaluates the goals to determine the match result as 'Home Win', 'Away Win', or 'Draw'.
SELECT 
    m.id AS MatchID,
    CASE 
        WHEN home_team_goal > away_team_goal THEN 'Home Win'
        WHEN home_team_goal < away_team_goal THEN 'Away Win'
        ELSE 'Draw'
    END AS MatchResult
FROM 
    match m;

USE EuroLeagues;
GO
-- This CASE expression evaluates the goals to determine the match result as 'Home Win', 'Away Win', or 'Draw'.
SELECT 
-- ht and at are aliases for the team table
-- m is the alias for the match table
-- HomeTeam, MatchID and AwayTeam

    m.id AS MatchID,
    ht.team_long_name AS HomeTeam,
    at.team_long_name AS AwayTeam,
    CASE 
        WHEN m.home_team_goal > m.away_team_goal THEN 'Home Win'
        WHEN m.home_team_goal < m.away_team_goal THEN 'Away Win'
        ELSE 'Draw'
-- This query will return a list of matches with the respective home and away team names and the match outcome
    END AS MatchResult
FROM 
    match m
INNER JOIN 
    team ht ON m.home_team_api_id = ht.team_api_id
INNER JOIN 
    team at ON m.away_team_api_id = at.team_api_id;


USE EuroLeagues;
GO
SELECT p.*, pa.*
-- selected all columns from both the player and player_attributes tables (p.* and pa.*)
-- Joined them on the player_api_id which is common to both tables.
FROM player p
JOIN player_attributes pa ON p.player_api_id = pa.player_api_id

USE EuroLeagues;
GO
-- Joining a different set of tables, like team with team_attributes, usingthe team_api_id
SELECT t.*, ta.*
-- From the table, the match involves player and team data
-- Joining match, team, and player tables together gives the data about home players and their teams in a particular match
FROM team t
JOIN team_attributes ta ON t.team_api_id = ta.team_api_id

USE EuroLeagues;

SELECT t.*, ta.*
-- This query will join match, team, and player tables
-- The query information returned includes team attributes, matching on team_api_id.

FROM team t
INNER JOIN team_attributes ta ON t.team_api_id = ta.team_api_id;

USE EuroLeagues;

SELECT l.name AS league_name, c.name AS country_name, m.*

-- This query returns league names, country names, and match details.
-- Using the alias makes it more easier to understand the query

FROM league l
INNER JOIN country c ON l.country_id = c.id
INNER JOIN match m ON l.id = m.league_id;

USE EuroLeagues;
-- In SQL, OUTER JOINs fetch rows from one table that may or may not match records in another. 
-- Three sorts of OUTER JOINS:
-- LEFT OUTER JOIN (or simply LEFT JOIN)
-- RIGHT OUTER JOIN (or simply RIGHT JOIN)
-- FULL OUTER JOIN

SELECT p.*, pa.*
-- OUTER JOINs are used to select rows from one table that may 
-- Or may not have matching rows in another table
FROM player p
FULL OUTER JOIN player_attributes pa ON p.player_api_id = pa.player_api_id;

USE EuroLeagues;


SELECT p.*, pa.*
-- A LEFT JOIN returns all records from the left table
-- and the matched records from the right table
-- If there is no match, the result is NULL on the right side.
FROM player p
LEFT JOIN player_attributes pa ON p.player_api_id = pa.player_api_id;

USE EuroLeagues;

SELECT p.*, pa.*
-- A RIGHT JOIN returns all records from the right table
-- and the matched records from the left table
-- If there is no match, the result is NULL on the left side.

FROM player p
RIGHT JOIN player_attributes pa ON p.player_api_id = pa.player_api_id;

USE EuroLeagues;

SELECT p.*, t.*
-- Cross joins match every row in the first and second tables.
-- This code, creates a complete combination of player with team
FROM player p
CROSS JOIN team t;

USE EuroLeagues;

SELECT A.player_name AS PlayerA, B.player_name AS PlayerB, A.height

-- Self-join often involves comparing rows within the same table
-- The query compares players based on their heights to find pairs of players who have the same height
-- A and B are aliases for the player table
-- The table is joined under the condition that its height is the same.
-- The extra condition A.id!= B.id prevents player duplication.

FROM player A
INNER JOIN player B ON A.height = B.height AND A.id != B.id;

USE EuroLeagues;

SELECT player_name, height
-- Sorts from tallest to shortest player
FROM player
ORDER BY height DESC; 

USE EuroLeagues;

SELECT p.player_name, pa.overall_rating, pa.potential
-- Sorts first by overall rating in descending order, then by potential in descending order
FROM player p
JOIN player_attributes pa ON p.player_api_id = pa.player_api_id
ORDER BY pa.overall_rating DESC, pa.potential DESC;

USE EuroLeagues;

SELECT *
-- This will return players taller than 180cm
FROM player
WHERE height > 180;  

USE EuroLeagues;

SELECT *
-- This will return teams whose long name starts with 'FC'
FROM team
WHERE team_long_name LIKE 'FC%';  

USE EuroLeagues;

SELECT *
-- Returns player attributes for players with an overall rating of 85 or higher
FROM player_attributes
WHERE overall_rating >= 85;  

USE EuroLeagues;

SELECT TOP 10 *
-- This query will give you the top 10 player attributes with the highest overall ratings.
FROM player_attributes
ORDER BY overall_rating DESC;

USE EuroLeagues;

SELECT *
--This query will skip the top 10 highest rated players and give you the next set of 10 players.
FROM player_attributes
ORDER BY overall_rating DESC
OFFSET 10 ROWS
FETCH NEXT 10 ROWS ONLY;

USE EuroLeagues;

SELECT p.player_name, pa.overall_rating
-- This query finds players for whom there are no attribute records
-- overall_rating is NULL when there is no corresponding row in player_attributes

FROM player p
LEFT JOIN player_attributes pa ON p.player_api_id = pa.player_api_id
WHERE pa.overall_rating IS NULL;


USE EuroLeagues;

SELECT player_name, COALESCE(height, 0) AS height
-- This query lists all players, replacing unknown height values with 0
FROM player;


USE EuroLeagues;

SELECT *
-- VARCHAR is for strings of variable length
FROM team
WHERE team_long_name LIKE 'Manchester%';


USE EuroLeagues;

SELECT *
-- FLOAT or DECIMAL data type
-- This data type handles decimal numbers.
-- Player overall_ratings need precision.
FROM player_attributes
WHERE overall_rating > 75.5;


USE EuroLeagues;

SELECT player_name, CAST(height AS FLOAT) as height_float
-- This query 'height' is stored as an integer but you need it as a float for some calculation
FROM player;

USE EuroLeagues;

SELECT player_name, SUBSTRING(player_name, 1, 3) AS short_name
-- This query extracts a string using the SUBSTRING function
FROM player;


USE EuroLeagues;

SELECT *
-- Finds any team whose name starts with "Real"
FROM team
WHERE team_long_name LIKE 'Real%';  


USE EuroLeagues;
 
SELECT YEAR(CAST(CAST(mdate AS VARCHAR(MAX)) AS DATETIME)) AS MatchYear, COUNT(*) AS TotalMatches
-- In this query, we first convert the text to a VARCHAR(MAX)
-- Then convert that result to a DATETIME.
-- The table doesn't have any time added

FROM match
GROUP BY YEAR(CAST(CAST(mdate AS VARCHAR(MAX)) AS DATETIME));

USE EuroLeagues;
 
SELECT *
-- In this query theb double casting first converts mdate to VARCHAR(MAX)
-- which is then converted to DATETIME to allow for the date comparison.
FROM match
WHERE CAST(CAST(mdate AS VARCHAR(MAX)) AS DATETIME) >= '2008-01-01'
AND CAST(CAST(mdate AS VARCHAR(MAX)) AS DATETIME) <= '2016-12-31';


USE EuroLeagues;
 
-- In this query INSERT statement, a subquery (SELECT MAX(id) FROM player) + 1
-- 
INSERT INTO player (id, player_api_id, player_name, birthday, height, weight)
VALUES ((SELECT MAX(id) FROM player) + 1, 2548409, 'Anthony Edjenuwa', '1999-02-14', 180, 75);

USE EuroLeagues;
 

SELECT *
-- This query will retrieve the record you just inserted
FROM player
WHERE player_api_id = 2548409;

USE EuroLeagues;
-- This query will add new player attributes 
INSERT INTO player_attributes (player_api_id, date, overall_rating, potential, preferred_foot)
VALUES (2548409, '2023-04-01', 85, 90, 'right');

USE EuroLeagues;

UPDATE player
-- This query modify existing data we just created with player_api_id = '2548409'
-- The query will replace 2548409 initial weight of 75 t0 185
SET weight = 185
WHERE player_api_id = 2548409;


USE EuroLeagues;

SELECT *
-- This query will retrieve the record just modified
FROM player
WHERE player_api_id = 2548409;

USE EuroLeagues;

DELETE FROM match
WHERE id = 1001;

USE EuroLeagues;

-- This code automatically generates timestamps for when records are created or updated
ALTER TABLE player ADD creation_date DATETIME DEFAULT GETDATE();

USE EuroLeagues;

SELECT *
-- The result of this query showed a new column 'creation_date'
-- The column is all NULL because no data is inputed yet
FROM player

USE EuroLeagues;

SELECT team_api_id, 
-- This query is a Conditional Function
-- The query will get list of teams with a column indicating,
-- if they have high or low defence pressure from the team_attributes table
       CASE 
           WHEN defencePressure > 50 THEN 'High' 
           ELSE 'Low' 
       END AS DefencePressureLevel
FROM team_attributes;

USE EuroLeagues;

SELECT UPPER(CAST(player_name AS VARCHAR(MAX))) AS PlayerNameUpper
-- This query gets the uppercase version of player names from the player table:
FROM player;

USE EuroLeagues;

SELECT player_name
-- To find all players whose name starts with 'Alex'
FROM player
WHERE player_name LIKE 'Alex%';

USE EuroLeagues;

SELECT COUNT(*) AS TotalHighRatedPlayers
-- This query will join player and player_attributes and,
-- get the total number of players with an overall rating above 80:
FROM player p
JOIN player_attributes pa ON p.player_api_id = pa.player_api_id
WHERE pa.overall_rating > 80;

USE EuroLeagues;

-- Convert the 'date' column to a different date format
SELECT CAST(date AS VARCHAR(10)) FROM team_attributes;

-- Convert a string to an integer
SELECT CAST(goal_difference AS INT) FROM 
(SELECT home_team_goal - away_team_goal AS goal_difference FROM match) AS SubQuery;

USE EuroLeagues;

-- Convert a 'text' date to 'datetime' after converting it to 'VARCHAR(MAX)'
SELECT CAST(CAST(mdate AS VARCHAR(MAX)) AS DATETIME) AS FormattedDate FROM match;

USE EuroLeagues;

-- Assigning a performance category based on the overall_rating in player_attributes
SELECT player_api_id,
       CASE
           WHEN overall_rating >= 80 THEN 'Excellent'
           WHEN overall_rating >= 70 THEN 'Good'
           WHEN overall_rating >= 60 THEN 'Average'
           ELSE 'Below Average'
       END AS PerformanceCategory
FROM player_attributes;

USE EuroLeagues;

-- Returning the first non-null score from home or away team
SELECT id,
       COALESCE(home_team_goal, away_team_goal) AS first_team_goal
FROM match;

USE EuroLeagues;

-- A simple check to see if the home team scored more goals than the away team
SELECT id,
       IIF(home_team_goal > away_team_goal, 'Home team wins', 'Home team does not win') AS MatchOutcome
FROM match;

USE EuroLeagues;

-- Setting the value to NULL if the home team and away team goals are the same (indicating a draw)
SELECT id,
       NULLIF(home_team_goal, away_team_goal) AS goal_difference
FROM match;

USE EuroLeagues;

-- Find matches where the home team scored more than 2 goals and the away team scored less than 2 goals
SELECT id
FROM match
WHERE home_team_goal > 2 AND away_team_goal < 2;

USE EuroLeagues;

-- Check if there are any matches from a particular league
SELECT *
FROM league l
WHERE EXISTS (SELECT 1 FROM match m WHERE m.league_id = l.id);

USE EuroLeagues;

SELECT *
-- This query select records where a column is not NULL
FROM match
WHERE away_team_goal IS NOT NULL;

USE EuroLeagues;

-- This query will Return NULL if home and away team goals are equal,
-- otherwise home team goals
SELECT id,
       NULLIF(home_team_goal, away_team_goal) AS goal_difference
FROM match;


