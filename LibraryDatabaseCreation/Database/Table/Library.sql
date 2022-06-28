CREATE TABLE [dbo].[Library]
(
	[Id] INT NOT NULL PRIMARY KEY identity,
	[Name] varchar(50) NOT NULL, 
	Email varchar(50) NOT NULL, 
    [Phone] VARCHAR(50) NOT NULL, 
    [Address] VARCHAR(50) NOT NULL 
)
