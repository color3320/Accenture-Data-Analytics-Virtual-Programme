--First let's take a look at our data
SELECT * FROM dbo.Reactions
SELECT * FROM dbo.Content
SELECT * FROM dbo.ReactionTypes

-- Data cleaning for Reactions table
SELECT * FROM dbo.Reactions

-- As the data is large I don't think we require time in the Datetime column so we start by seperating Date from Datetime
SELECT Datetime, CAST(Datetime AS DATE) AS Date FROM dbo.Reactions
ALTER TABLE dbo.Reactions ADD Date DATE

UPDATE dbo.Reactions
SET Date = CAST(Datetime AS DATE)
		   FROM dbo.Reactions

-- So we have created a Date column now let's remove the original Datetime column 
ALTER TABLE dbo.Reactions
DROP COLUMN Datetime

SELECT * FROM dbo.Reactions

--Data Cleaning for Content Table
SELECT * FROM dbo.Content
SELECT COUNT(*) FROM dbo.Content
SELECT DISTINCT Category FROM dbo.Content

--Here we can see that some values have double quotes over them let's clean those rows
UPDATE dbo.Content
SET Category = REPLACE(Category, '"', '')

-- The double quotes are now removed but there is irregularity in data as some values in Category have upper case first letter and some have lower case
-- Let's convert it to lower case for better visulization of data afterwords.
SELECT DISTINCT Category, LOWER(Category) FROM dbo.Content
UPDATE Content SET Category = LOWER(Category)
-- SELECT INITCAP(Category) AS Category FROM dbo.Content; --(In postgres INITCAP can capitalize first letter of each word in a column)  

-- As there are multiple column named Type with different values present in them, let's distinguish them by renaming them
-- Reactions table
 EXEC SP_RENAME 'dbo.Reactions.Type', 'Reaction_type';

 -- Content table
EXEC SP_RENAME 'dbo.Content.Type', 'Content_type';

 --ReactionTypes table
EXEC SP_RENAME 'dbo.ReactionTypes.Type', 'Reaction_type';

-- The URL field is not required as it is not related to any other field in the table and doesn't provide any insights.
ALTER TABLE dbo.Content DROP COLUMN URL

-- As the User_ID field has NULL values in Reactions table we can remove that column as Content_ID column can be used as Primary key for joining tables
ALTER TABLE dbo.Reactions DROP COLUMN URL
ALTER TABLE dbo.Content DROP COLUMN URL

-- Here I have concluded the part of data cleaning 