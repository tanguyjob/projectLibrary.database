CREATE PROCEDURE [dbo].[AddAuthor]
	@Name varchar(50),
	@Firstname varchar(50),
	@BirthDate date,
	@IsActive int
AS
	INSERT INTO Author ([Name], Firstname, Birthdate)
	values (@Name, @Firstname, @BirthDate)
RETURN 0
