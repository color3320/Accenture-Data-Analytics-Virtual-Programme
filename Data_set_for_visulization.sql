-- In order to export our data to Tableau we need to create a dataset by combining relevent data from each table 
-- Let's take a look at our data again as it is now cleaned
SELECT * FROM dbo.Reactions
SELECT * FROM dbo.Content
SELECT * FROM dbo.ReactionTypes

-- I am writing a query so that all the data present in different table is merged into one table as we need to export data into power BI for visulization
-- To export data into Power BI we have 2 methods 1. Connecting MS-SQL database to Power BI and and using a SQL statement in Advanced options 
--                                                      OR
-- We can export data to a Excel file and then connect the Excel file to Power BI

SELECT r.Content_ID, c.User_ID, r.Reaction_type, r.Date, c.Content_Type, c.Category, rt.Sentiment, rt.Score
FROM
Reactions r
LEFT JOIN Content c
ON r.Content_ID = c.Content_ID
LEFT JOIN ReactionTypes rt
ON rt.Reaction_type = r.Reaction_type
