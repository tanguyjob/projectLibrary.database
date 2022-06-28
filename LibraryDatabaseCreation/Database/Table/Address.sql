CREATE TABLE [dbo].[Address]
(
	[Id] INT NOT NULL PRIMARY KEY identity,
	City varchar(50) NOT NULL, 
    [PostCode] VARCHAR(50) NOT NULL, 
    [Street] VARCHAR(50) NOT NULL, 
    [Number] VARCHAR(50) NOT NULL, 
    [Box] VARCHAR(50) NULL 
)
