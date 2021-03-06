/*
Script de déploiement pour ProjectLibrary

Ce code a été généré par un outil.
La modification de ce fichier peut provoquer un comportement incorrect et sera perdue si
le code est régénéré.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "ProjectLibrary"
:setvar DefaultFilePrefix "ProjectLibrary"
:setvar DefaultDataPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019DEV\MSSQL\DATA\"
:setvar DefaultLogPath "C:\Program Files\Microsoft SQL Server\MSSQL15.SQL2019DEV\MSSQL\DATA\"

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
    [Id]              INT           IDENTITY (1, 1) NOT NULL,
    [Title]           VARCHAR (50)  NOT NULL,
    [Resume]          VARCHAR (500) NOT NULL,
    [PublicationDate] DATE          NOT NULL,
    [LanguageId]      INT           NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


GO
PRINT N'Création de Table [dbo].[BookAuthor]...';


GO
CREATE TABLE [dbo].[BookAuthor] (
    [Id]       INT IDENTITY (1, 1) NOT NULL,
    [BookId]   INT NOT NULL,
    [AuthorId] INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
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
    [Id]      INT IDENTITY (1, 1) NOT NULL,
    [GenreId] INT NOT NULL,
    [BookId]  INT NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
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
    [Password]             VARCHAR (50) NOT NULL,
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
	@title varchar(50),
	@Resume varchar(500),
	@date date,
	@languageId int
AS
	insert into Book (Title,[Resume],PublicationDate,LanguageId)
	values (@title,@Resume, @date,@languageId)
RETURN 0
GO
PRINT N'Création de Procédure [dbo].[AddUser]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[SelectAllBookAuthor]...';


GO
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
GO
PRINT N'Création de Procédure [dbo].[SelectAllInfoBorrowingByUserId]...';


GO
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
	SELECT b.Id as BookId,b.Title,b.[Resume],b.PublicationDate,a.Id as [AuthorId],a.Firstname,a.[Name] as AuthorName,a.Birthdate, g.Id as [GenreId], g.[Name] as GenreName, l.[Name] as LanguageName 
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
--pour SQLServer version developpeur
--Set Identity_insert Genre on;

INSERT INTO Genre values ('Langue')
INSERT INTO Genre values ('Biographie')
INSERT INTO Genre values ('Historique')
INSERT INTO Genre values ('Aventure')
INSERT INTO Genre values ('Esotérisme')
INSERT INTO Genre values ('Science Sociale')

--Set Identity_insert Genre off;
GO

--Set Identity_insert [Language] on;
INSERT INTO [Language] values ('Français')
INSERT INTO [Language] values ('Anglais')
INSERT INTO [Language] values ('Néerlandais')

GO

insert into Book values ('Je voulais juste vivre','Yeonmi a 13 ans, sa courte vie est déjà marquée par le désespoir. Elle n''a qu''une solution : fuir son pays, la Corée du Nord.', '1964-02-04', 1)
insert into Book values ('Savage Swan',' les mémoires d''une famille chinoise, de l''Empire céleste à Tiananmen (titre original Wild Swans: Three Daughters of China) est le récit d’une saga familiale au XXe siècle en Chine à travers la biographie de la grand-mère et de la mère de Jung Chang', '1964-02-04', 2)
insert into Book values ('Marie-Antoinette','Épouse de Louis XVI, Marie-Antoinette reste l’une des plus célèbres reines de France. Née le 2 novembre 1755 à Vienne (Autriche), elle est décédée guillotinée le 16 octobre 1793 à Paris, après sa condamnation à mort pour trahison par le Tribunal révolutionnaire', '1978-06-07',1)
insert into Book values ('La bibliothécaire d''Auschwitz', 'Même lorsque l''horreur atteint son paroxysme, l''humain peut trouver la force de ressentir de la compassion et d''agir pour son prochain : c''est le message que Dita Kraus, la « bibliothécaire d''Auschwitz »','1964-02-04',1)
insert into Book values ('Sa majesté des mouches','L''histoire se déroule durant la Seconde Guerre mondiale. Prenant le prétexte de l''arrivée accidentelle d''un groupe d''enfants sur une île déserte du Pacifique, il traite avec pessimisme de l''organisation sociale, du pouvoir et de la loi. Son titre est une traduction littérale du nom de Belzébuth (en hébreu, בעל זבוב), divinité païenne considérée dans la tradition chrétienne comme chef des démons.','1950-09-01',1)
insert into Book values ('Geisha','L''histoire commence en 1929 au Japon, dans un petit village de pêcheurs. Chiyo et sa sœur Satsu sont vendues par leur père et envoyées à Kyoto, dans le quartier de Gion','1928-03-02',1)

GO


insert into GenreBook values (2,1)
insert into GenreBook values (2,2)
insert into GenreBook values (2,3)
insert into GenreBook values (3,4)
insert into GenreBook values (4,5)
insert into GenreBook values (3,6)

GO

insert into Author values ('Park','Yeonmi','1990-11-11')
insert into Author values ('Chang','Jun','1926-04-02')
insert into Author values ('Zweig','Stefan','1943-10-07')
insert into Author values ('Itubre','Antonio','1950-09-12')
insert into Author values ('Golding','William','1917-10-12')
insert into Author values ('Golden','Arthur','1903-10-12')

GO

insert into BookAuthor values (1,1)
insert into BookAuthor values (2,2)
insert into BookAuthor values (3,3)
insert into BookAuthor values (4,4)
insert into BookAuthor values (5,5)
insert into BookAuthor values (6,6)

GO

insert into [Library] values ('Centre','centre@woluwe.be','010254565','Rue de centre, 24')
insert into [Library] values ('Chant d''oiseau','chant@woluwe.be','010383865','Avenue du chant d''oiseau, 100')
insert into [Library] values ('Joli-Bois','jolibois@woluwe.be','010254565','Avenue des Shetlands, 17')
GO


insert into [Profile] values ('User')
insert into [Profile] values ('Manager')
insert into [Profile] values ('Admin')

GO


insert into [Subscription] values ('Basic', 5,1)
insert into [Subscription] values ('Medium', 7,5)
insert into [Subscription] values ('Basic', 10,20)
GO


insert into [Address] values ('Bierges', '1320','rue d''angoussart','20', '')
insert into [Address] values ('Bruxelles', '1150','Drève de nivelles','166', '19')
insert into [Address] values ('Bruxelles', '1250','rue Volta','30', '1')
insert into [Address] values ('Gistoux', '1220','rue de Chaumont','14', '')
GO


insert into [User] values ('Verhaegen','Sebastien','2006-10-08', 'Seb@yopmail.com','mdp','0475640208',1,1,1,1)
insert into [User] values ('Verhaegen','Tanguy','1989-11-13', 'Tang@yopmail.com','mdp','0493810833',1,2,1,1)
insert into [User] values ('Neve','Alexis','1990-11-04', 'Alex@yopmail.com','mdp','0493878825',1,3,1,1)
insert into [User] values ('Dengis','Anne-Sophie','1999-06-04', 'as@yopmail.com','mdp','0493878811',1,4,1,1)
GO


insert into [Copy] values (1,1)
insert into [Copy] values (2,1)
insert into [Copy] values (3,1)
insert into [Copy] values (4,2)
insert into [Copy] values (5,2)
insert into [Copy] values (6,2)
GO


insert into [Borrowing] values ('2022-1-1','2022-1-14',0,1,1)
insert into [Borrowing] values ('2021-10-1','2021-10-14',0,2,1)
insert into [Borrowing] values ('2021-5-1','2021-5-14',0,3,1)
insert into [Borrowing] values ('2020-7-1','2021-7-12',0,4,1)
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
