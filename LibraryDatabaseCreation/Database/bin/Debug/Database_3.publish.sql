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
USE [$(DatabaseName)];


GO
PRINT N'Création de Table [dbo].[Genre]...';


GO
CREATE TABLE [dbo].[Genre] (
    [Id]   INT          IDENTITY (1, 1) NOT NULL,
    [Name] VARCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([Id] ASC)
);


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
GO

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
PRINT N'Mise à jour terminée.';


GO
