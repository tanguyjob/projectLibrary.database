CREATE PROCEDURE [dbo].[SelectAllUserById]
	@Id int 
AS
	SELECT distinct u.Id as UserId, u.[Name] as UserName, u.Firstname, u.Email, u.Birthdate,a.Id as AddressId,a.City,a.PostCode,a.Street,a.Number, a.box, p.Id as ProfileId, P.Name as ProfileName
	from [User] u	
	join [Address] a
	on a.Id = u.FK_User_Address
	join [Profile] p
	on p.Id = u.FK_User_Profile
	join subscription s
	on u.FK_User_Subscription = u.FK_User_Subscription
	where u.Id = @Id
RETURN 0
