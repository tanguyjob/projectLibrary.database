CREATE TABLE [dbo].[Subscription]
(
	[Id] INT NOT NULL PRIMARY KEY identity,
	[Name] varchar(50) NOT NULL, 
    [Price] MONEY NOT NULL,
	BookNumer int NOT NULL 
)
