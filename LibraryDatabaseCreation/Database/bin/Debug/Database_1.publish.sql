/*
Script de déploiement pour LibraryInAdo

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "LibraryInAdo"
:setvar DefaultFilePrefix "LibraryInAdo"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER01\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL14.MSSQLSERVER01\MSSQL\DATA\"

GO
:on error exit
GO
/*
Détectez le mode SQLCMD et désactivez l'exécution du script si le mode SQLCMD n'est pas pris en charge.
Pour réactiver le script une fois le mode SQLCMD activé, exécutez ce qui suit :
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Le mode SQLCMD doit être activé de manière à pouvoir exécuter ce script.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Création de la base de données $(DatabaseName)...'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                RECOVERY FULL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Impossible de modifier les paramètres de base de données. Vous devez être administrateur système pour appliquer ces paramètres.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Création de Table [dbo].[Address]...';


GO
CREATE TABLE [dbo].[Address] (
    [Id]       INT          IDENTITY (1, 1) NOT NULL,
    [City]     VARCHAR (50) NOT NULL,
    [PostCode] VARCHAR (50) NOT NULL,
    [Street]   VARCHAR (50) NOT NULL,
    [Number]   VARCHAR (50) NOT NULL,
    [Box]      VARCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Author]...';


GO
CREATE TABLE [dbo].[Author] (
    [Id]        INT          IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (50) NOT NULL,
    [Firstname] VARCHAR (50) NOT NULL,
    [Birthdate] DATE         NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Book]...';


GO
CREATE TABLE [dbo].[Book] (
    [Id]              INT          IDENTITY (1, 1) NOT NULL,
    [Name]            VARCHAR (50) NOT NULL,
    [PublicationDate] DATE         NOT NULL,
    [LanguageId]      INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[BookAuthor]...';


GO
CREATE TABLE [dbo].[BookAuthor] (
    [BookId]   INT NOT NULL,
    [AuthorId] INT NOT NULL,
    CONSTRAINT [PrimaryKeyBookAuthor] PRIMARY KEY CLUSTERED ([BookId] ASC, [AuthorId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Borrowing]...';


GO
CREATE TABLE [dbo].[Borrowing] (
    [Id]                INT  IDENTITY (1, 1) NOT NULL,
    [DateBegin]         DATE NOT NULL,
    [DateBack]          DATE NULL,
    [Additional]        BIT  NULL,
    [FK_Borrowing_Copy] INT  NOT NULL,
    [FK_Borrowing_User] INT  NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Copy]...';


GO
CREATE TABLE [dbo].[Copy] (
    [Id]              INT IDENTITY (1, 1) NOT NULL,
    [FK_Copy_Book]    INT NOT NULL,
    [FK_Copy_Library] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Genre]...';


GO
CREATE TABLE [dbo].[Genre] (
    [Id]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[GenreBook]...';


GO
CREATE TABLE [dbo].[GenreBook] (
    [GenreId] INT NOT NULL,
    [BookId]  INT NOT NULL,
    CONSTRAINT [PrimaryKeyGenreBook] PRIMARY KEY CLUSTERED ([GenreId] ASC, [BookId] ASC)
);


GO
PRINT N'Création de Table [dbo].[Language]...';


GO
CREATE TABLE [dbo].[Language] (
    [Id]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Library]...';


GO
CREATE TABLE [dbo].[Library] (
    [Id]      INT          IDENTITY (1, 1) NOT NULL,
    [Name]    VARCHAR (50) NOT NULL,
    [Email]   VARCHAR (50) NOT NULL,
    [Phone]   VARCHAR (50) NOT NULL,
    [Address] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Profile]...';


GO
CREATE TABLE [dbo].[Profile] (
    [Id]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[Subscription]...';


GO
CREATE TABLE [dbo].[Subscription] (
    [Id]        INT          IDENTITY (1, 1) NOT NULL,
    [Name]      VARCHAR (50) NOT NULL,
    [Price]     MONEY        NOT NULL,
    [BookNumer] INT          NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[User]...';


GO
CREATE TABLE [dbo].[User] (
    [Id]                   INT          IDENTITY (1, 1) NOT NULL,
    [Name]                 VARCHAR (50) NOT NULL,
    [Firstname]            VARCHAR (50) NOT NULL,
    [Birthdate]            DATE         NOT NULL,
    [Email]                VARCHAR (50) NOT NULL,
    [Phone]                VARCHAR (50) NOT NULL,
    [IsActive]             BIT          NULL,
    [FK_User_Address]      INT          NOT NULL,
    [FK_User_Subscription] INT          NULL,
    [FK_User_Profile]      INT          NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[Borrowing]...';


GO
ALTER TABLE [dbo].[Borrowing]
    ADD DEFAULT 0 FOR [Additional];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT 1 FOR [IsActive];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT 1 FOR [FK_User_Subscription];


GO
PRINT N'Création de Contrainte par défaut contrainte sans nom sur [dbo].[User]...';


GO
ALTER TABLE [dbo].[User]
    ADD DEFAULT 1 FOR [FK_User_Profile];


GO
PRINT N'Création de Déclencheur [dbo].[Trigger_Instead_Delete]...';


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
GO
PRINT N'Création de Procédure [dbo].[AddAddress]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[AddAuthor]...';


GO
CREATE PROCEDURE [dbo].[AddAuthor]
	@Name varchar(50),
	@Firstname varchar(50),
	@BirthDate date,
	@IsActive int
AS
	INSERT INTO Author ([Name], Firstname, Birthdate)
	values (@Name, @Firstname, @BirthDate)
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[AddBook]...';


GO
CREATE PROCEDURE [dbo].[AddBook]
	@name varchar(50),
	@date date,
	@languageId int
AS
	insert into Book ([Name],PublicationDate,LanguageId)
	values (@name, @date,@languageId)
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[AddUser]...';


GO
CREATE PROCEDURE [dbo].[AddUser]
	@Name  varchar(50),
	@Firstname varchar(50),
	@BirthDate date,
	@Email varchar(50),
	@Phone varchar(50),
	@FK_User_Address int,
	@FK_User_Subscription int,
	@FK_User_Profile int
	
AS
	INSERT INTO [User] ([Name],Firstname, BirthDate, Email, Phone, FK_User_Address, FK_User_Subscription, FK_User_Profile)
	values (@Name,@Firstname,@BirthDate,@Email,@Phone,@FK_User_Address, @FK_User_Subscription,@FK_User_Profile)
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[SelectAllBookAuthor]...';


GO
CREATE PROCEDURE [dbo].[SelectAllBookAuthor]

AS
	SELECT b.Id as BookId,b.[Name] as BookName,b.PublicationDate,a.Firstname,a.[Name] as AuthorName,a.Birthdate, g.Id as [GenreId], g.[Name] as GenreName, l.[Name] as LanguageName 
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
GO
PRINT N'Création de Procédure [dbo].[SelectAllInfoBorrowingByUserId]...';


GO
CREATE PROCEDURE [dbo].[SelectAllInfoBorrowingByUserId]
	@Id int
AS
	SELECT b.Id as borrowingId, b.DateBack, b.DateBegin, b.Additional, c.Id as CopyId, bo.Id as BookId, bo.[Name] as BookName, bo.PublicationDate
	from Borrowing b
	join [Copy] c
	on b.FK_Borrowing_Copy = c.Id
	join Book bo
	on bo.Id = c.FK_Copy_Book
	join [User] u 
	on u.Id =b.FK_Borrowing_User
	where u.Id = @Id
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[SelectAllUserById]...';


GO
CREATE PROCEDURE [dbo].[SelectAllUserById]
	@Id int 
AS
	SELECT u.Id as UserId, u.[Name] as UserName, u.Firstname, u.Email, u.Birthdate,a.Id as AddressId,a.City,a.PostCode,a.Street,a.Number, a.box, p.Id as ProfileId, P.Name as ProfileName
	from [User] u	
	join [Address] a
	on a.Id = u.FK_User_Address
	join [Profile] p
	on p.Id = u.FK_User_Profile
	join subscription s
	on u.FK_User_Subscription = u.FK_User_Subscription
	where u.Id = @Id
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[SelectBookAuthorById]...';


GO
CREATE PROCEDURE [dbo].[SelectBookAuthorById]
	@Id int
AS
	SELECT b.Id as BookId,b.[Name] as BookName,b.PublicationDate,a.Id as [AuthorId],a.Firstname,a.[Name] as AuthorName,a.Birthdate, g.Id as [GenreId], g.[Name] as GenreName, l.[Name] as LanguageName 
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
	where b.Id=@Id	 
RETURN 0
GO
/*
Modèle de script de post-déploiement							
--------------------------------------------------------------------------------------
 Ce fichier contient des instructions SQL qui seront ajoutées au script de compilation.		
 Utilisez la syntaxe SQLCMD pour inclure un fichier dans le script de post-déploiement.			
 Exemple :      :r .\monfichier.sql								
 Utilisez la syntaxe SQLCMD pour référencer une variable dans le script de post-déploiement.		
 Exemple :      :setvar TableName MyTable							
               SELECT * FROM [$(TableName)]					
--------------------------------------------------------------------------------------
*/

use LibraryInAdo
Set Identity_insert Genre on;
INSERT INTO Genre values (1,'Langue')
INSERT INTO Genre values (2,'Biographie')
INSERT INTO Genre values (3,'Historique')
INSERT INTO Genre values (4,'Aventure')
INSERT INTO Genre values (5,'Esotérisme')
INSERT INTO Genre values (6,'Science Sociale')

GO

Set Identity_insert [Language] on;
INSERT INTO [Language] values (1, 'Français')
INSERT INTO [Language] values (2, 'Anglais')
INSERT INTO [Language] values (3, 'Néerlandais')

GO

Set Identity_insert [Book] on;
insert into Book values (1, 'Je voulais juste vivre', '1964-02-04', 1, 1)
insert into Book values (2, 'Savage Swan', '1964-02-04', 1, 2)
insert into Book values (3, 'Marie-Antoinette', '1978-06-07', 1, 1)
insert into Book values (4, 'La bibliothécaire d''Auschwitz', '1964-02-04', 1, 1)
insert into Book values (5, 'Sa majesté des mouches','1950-09-01',1,1)
insert into Book values (6, 'Geisha','1928-03-02',1,1)

GO

Set Identity_insert [GenreBook] on;
insert into GenreBook values (2,1)
insert into GenreBook values (2,2)
insert into GenreBook values (2,3)
insert into GenreBook values (3,4)
insert into GenreBook values (4,5)
insert into GenreBook values (3,6)

GO
Set Identity_insert [Author] on;
insert into Author values (1,'Park','Yeonmi','1990-11-11',1)
insert into Author values (2,'Chang','Jun','1926-04-02',1)
insert into Author values (3,'Zweig','Stefan','1943-10-07',1)
insert into Author values (4,'Itubre','Antonio','1950-09-12',1)
insert into Author values (5,'Golding','William','1917-10-12',1)
insert into Author values (6,'Golden','Arthur','1903-10-12',1)

GO
Set Identity_insert [BookAuthor] on;
insert into BookAuthor values (1,1)
insert into BookAuthor values (2,2)
insert into BookAuthor values (3,3)
insert into BookAuthor values (4,4)
insert into BookAuthor values (5,5)
insert into BookAuthor values (6,6)

GO

Set Identity_insert [Library] on;
insert into [Library] values (1,'Centre','centre@woluwe.be','010254565','Rue de centre, 24')
insert into [Library] values (2,'Chant d''oiseau','chant@woluwe.be','010383865','Avenue du chant d''oiseau, 100')
insert into [Library] values (3,'Joli-Bois','jolibois@woluwe.be','010254565','Avenue des Shetlands, 17')

Set Identity_insert [Profile] on;
insert into [Profile] values (1,'User')
insert into [Profile] values (2,'Manager')
insert into [Profile] values (3,'Admin')

GO

Set Identity_insert [Subscription] on;
insert into [Subscription] values (1,'Basic', 5,1)
insert into [Subscription] values (2,'Medium', 7,5)
insert into [Subscription] values (3,'Basic', 10,20)

GO

Set Identity_insert [Address] on;
insert into [Address] values (1,'Bierges', '1320','rue d''angoussart','20', '')
insert into [Address] values (2,'Bruxelles', '1150','Drève de nivelles','166', '19')
insert into [Address] values (3,'Bruxelles', '1250','rue Volta','30', '1')
insert into [Address] values (4,'Gistoux', '1220','rue de Chaumont','14', '')
GO

Set Identity_insert [User] on;
insert into [User] values (1,'Verhaegen','Sebastien','2006-10-08', 'Seb@yopmail.com','0475640208',1,1,1)
insert into [User] values (2,'Verhaegen','Tanguy','1989-11-13', 'Tang@yopmail.com','0493810833',1,2,1)
insert into [User] values (3,'Neve','Alexis','1990-11-04', 'Alex@yopmail.com','0493878825',1,3,1)
insert into [User] values (4,'Dengis','Anne-Sophie','1999-06-04', 'as@yopmail.com','0493878811',1,4,1)
GO

Set Identity_insert [Copy] on;
insert into [Copy] values (1,1,1)
insert into [Copy] values (2,2,1)
insert into [Copy] values (3,3,1)
insert into [Copy] values (4,4,2)
insert into [Copy] values (5,5,2)
insert into [Copy] values (6,6,2)
GO

Set Identity_insert [Borrowing] on;
insert into [Borrowing] values (1,'2022-1-1','2022-1-14',0,1,1)
insert into [Borrowing] values (2,'2021-10-1','2021-10-14',0,2,1)
insert into [Borrowing] values (3,'2021-5-1','2021-5-14',0,3,1)
insert into [Borrowing] values (3,'2020-7-1','2021-7-12',0,4,1)
GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Mise à jour terminée.';


GO
