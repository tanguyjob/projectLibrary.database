CREATE PROCEDURE [dbo].[AddBook]
	@title varchar(50),
	@Resume varchar(500),
	@date date,
	@languageId int
AS
	insert into Book (Title,[Resume],PublicationDate,LanguageId)
	values (@title,@Resume, @date,@languageId)
RETURN 0
