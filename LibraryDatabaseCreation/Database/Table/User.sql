CREATE TABLE [dbo].[User]
(
	[Id] INT NOT NULL PRIMARY KEY identity, 
    [Name] VARCHAR(50) NOT NULL, 
    [Firstname] VARCHAR(50) NOT NULL, 
    [Birthdate] DATE NOT NULL, 
    [Email] VARCHAR(50) NOT NULL,
    [Password] varchar(50) NOT NULL,
    [Phone] VARCHAR(50) NOT NULL, 
    [IsActive] BIT default 1, 
    [FK_User_Address] INT NOT NULL, 
    [FK_User_Subscription] INT default 1, 
    [FK_User_Profile] INT default 1
)

GO

CREATE TRIGGER [dbo].[Trigger_Instead_Delete]
    ON [dbo].[User]
    INSTEAD OF DELETE
    AS
    BEGIN
          SET NoCount ON
        update [User] set isActive = 0
        where id in (select id from deleted) and isActive=1;
    END