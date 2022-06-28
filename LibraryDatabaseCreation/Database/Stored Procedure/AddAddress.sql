CREATE PROCEDURE [dbo].[AddAddress]
	@City varchar(50),
	@PostCode varchar(50),
	@Street varchar(50),
	@Number varchar(50),
	@Box varchar(50)
	
AS
	insert into [Address] (City,PostCode,Street,Number, Box)
	values (@City,@PostCode,@Street,@Number,@Box)
RETURN 0
