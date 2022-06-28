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
