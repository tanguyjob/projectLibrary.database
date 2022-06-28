CREATE TABLE [dbo].[Book]
(
	[Id] INT NOT NULL PRIMARY KEY IDENTITY,
	Title varchar(50) NOT NULL, 
	[Resume] varchar(500) NOT NULL,
    [PublicationDate] DATE NOT NULL,
	LanguageId int	NOT NULL
)
