use harrel28;

-- 1. How many points Real Madrid won last season
Select play_ID,  SUM(Points) As total from Matches
Group by play_ID with rollup;

-- 2. The head coach and who he seclected to be a starter 
-- ordered by player positioning
SELECT Player.F_Name, Player.L_Name, Player.Number, Player.Position, Staff.F_Name, Staff.L_Name Staff_ID, Title 
FROM Player JOIN Staff
ON Player.Team_Team_Id = Staff.Team_Team_Id
WHERE Title = 'Head Coach' AND isStarter = 1
ORDER BY Position;

-- 3. How many goals Real Madrid scored as a team for the season
SELECT SUM(Goals) AS all_goals FROM Player
GROUP BY 'Number' WITH ROLLUP;

-- 4. Total games Real Madrid won by more than 1 goal 
--    and which games they were
Select play_ID, Count(play_ID) From Matches
Where Points = 3 AND 
Venue = 'Home' AND Score_Home > Score_Away AND Score_Home - Score_Away > 1 OR 
Venue = 'Away' AND Score_Home < Score_Away AND Score_Away - Score_Home > 1
Group By play_ID with rollup;

-- 5. Show the highest valued player off the bench
--    who trains under the assistant coach
SELECT  Value AS HIGH_VALUE, p.F_Name, p.L_Name, s.F_name, s.L_Name, s.Staff_ID, s.Title
FROM Player p JOIN Staff s ON p.Team_Team_Id = s.Team_Team_Id
WHERE isStarter = 0 AND Title LIKE 'Assistant C%'
#GROUP BY p.F_Name, p.L_Name, s.F_name, s.L_Name, s.Staff_ID, s.Title
ORDER BY Value DESC
LIMIT 1;