CREATE TABLE [dbo].[Copy]
(
	[Id] INT NOT NULL PRIMARY KEY identity, 
    [FK_Copy_Book] INT NOT NULL, 
    [FK_Copy_Library] INT NOT NULL,

)
