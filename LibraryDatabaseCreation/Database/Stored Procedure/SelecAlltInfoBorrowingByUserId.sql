CREATE PROCEDURE [dbo].[SelectAllInfoBorrowingByUserId]
	@Id int
AS
	SELECT b.Id as borrowingId, b.DateBack, b.DateBegin, b.Additional, c.Id as CopyId, bo.Id as BookId, bo.Title,bo.[Resume], bo.PublicationDate,
	u.Id as userId, u.Name as userName,u.Firstname,u.Birthdate, u.Email, u.[Password], u.Phone, u.IsActive, u.FK_User_Address, u.FK_User_Subscription, u.FK_User_Profile
	from Borrowing b
	join [Copy] c
	on b.FK_Borrowing_Copy = c.Id
	join Book bo
	on bo.Id = c.FK_Copy_Book
	join [User] u 
	on u.Id =b.FK_Borrowing_User
	where u.Id = @Id
RETURN 0
