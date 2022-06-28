CREATE TABLE [dbo].[Borrowing]
(
	[Id] INT NOT NULL PRIMARY KEY identity,
	DateBegin date not null,
	DateBack date null,
	Additional bit default 0,
	[FK_Borrowing_Copy] int not null, 
    [FK_Borrowing_User] INT NOT NULL,

)
