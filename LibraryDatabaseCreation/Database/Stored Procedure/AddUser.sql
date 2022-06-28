CREATE PROCEDURE [dbo].[AddUser]
	@Name  varchar(50),
	@Firstname varchar(50),
	@BirthDate date,
	@Email varchar(50),
	@Password varchar(50),
	@Phone varchar(50),
	@FK_User_Address int,
	@FK_User_Subscription int,
	@FK_User_Profile int
	
AS
	INSERT INTO [User] ([Name],Firstname, BirthDate, Email,[Password], Phone, FK_User_Address, FK_User_Subscription, FK_User_Profile)
	values (@Name,@Firstname,@BirthDate,@Email,@password,@Phone,@FK_User_Address, @FK_User_Subscription,@FK_User_Profile)
RETURN 0
