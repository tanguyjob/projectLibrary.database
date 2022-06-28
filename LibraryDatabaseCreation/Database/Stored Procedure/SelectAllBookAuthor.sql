CREATE PROCEDURE [dbo].[SelectAllBookAuthor]

AS
	SELECT b.Id as BookId, b.Title ,b.Resume,b.PublicationDate,a.Firstname,a.[Name] as AuthorName,a.Birthdate, g.Id as [GenreId], g.[Name] as GenreName, l.[Name] as LanguageName 
	from Book b
	join BookAuthor ba
	on b.Id = ba.BookId 
	join Author a
	on a.Id=ba.AuthorId
	join GenreBook gb
	on gb.BookId = b.Id
	join Genre g
	on g.Id = gb.GenreId
	join Language l
	on l.Id = b.LanguageId

	
	 
RETURN 0
