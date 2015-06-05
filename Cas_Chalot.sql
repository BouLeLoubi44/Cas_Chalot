----------------------------------------------------------------------------------------------------------------------------------------------
--CREATION DE LA BASE-------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
USE master
GO
----------------------------------------------------------------------------------------------------------------------------------------------
IF EXISTS (SELECT * FROM master.sys.databases WHERE name = 'casChalotMTLF')
	BEGIN
		DROP DATABASE casChalotMTLF
	END
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE DATABASE casChalotMTLF
GO
----------------------------------------------------------------------------------------------------------------------------------------------
--CREATION DES TABLES-------------------------------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------------------------------------------------
USE casChalotMTLF
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE discipline(
	code INT NOT NULL IDENTITY,
	libelle VARCHAR(50),
	CONSTRAINT pk_discipline PRIMARY KEY (code)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE club(
	code INT NOT NULL IDENTITY,
	libelle VARCHAR(50),
	CONSTRAINT pk_club PRIMARY KEY (code)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE categorie(
	code INT NOT NULL IDENTITY,
	libelle VARCHAR(50),
	CONSTRAINT pk_categorie PRIMARY KEY (code)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE personne(
	id INT NOT NULL IDENTITY,
	nom VARCHAR(50),
	prenom VARCHAR(50),
	dateNaiss DATETIME,
	CONSTRAINT pk_personne PRIMARY KEY (id)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE equipe(
	code INT NOT NULL IDENTITY,
	libelle VARCHAR(50),
	codeCategorie INT NOT NULL,
	idPersonne INT NOT NULL,
	CONSTRAINT pk_equipe PRIMARY KEY (code),
	CONSTRAINT fk_equipe_categorie FOREIGN KEY (codeCategorie) REFERENCES categorie (code),
	CONSTRAINT fk_equipe_personne FOREIGN KEY (idPersonne) REFERENCES personne (id)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE annee(
	dateAnnee DATETIME,
	CONSTRAINT pk_annee PRIMARY KEY (dateAnnee)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE presenter(
	codeClub INT NOT NULL,
	codeDiscipline INT NOT NULL,
	CONSTRAINT pk_presenter PRIMARY KEY (codeClub,codeDiscipline),
	CONSTRAINT fk_presenter_club FOREIGN KEY (codeClub) REFERENCES club (code),
	CONSTRAINT fk_presenter_discipline FOREIGN KEY (codeDiscipline) REFERENCES discipline (code)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE tuteler(
	idPersonneResponsable INT NOT NULL ,
	idPersonneResponsabilisee INT NOT NULL,
	CONSTRAINT pk_tuteler PRIMARY KEY (idPersonneResponsable,idPersonneResponsabilisee),
	CONSTRAINT fk_tuteler_personne FOREIGN KEY (idPersonneResponsable,idPersonneResponsabilisee) REFERENCES personne (id)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
CREATE TABLE cotiser(
	dateAnnee DATETIME,
	codeClub  INT NOT NULL,
	idPersonneCotisante INT NOT NULL,
	idPersonneLicenciee INT NOT NULL,
	CONSTRAINT pk_cotiser PRIMARY KEY (dateAnnee,codeClub,idPersonneCotisante,idPersonneLicenciee),
	CONSTRAINT fk_cotiser_annee FOREIGN KEY (dateAnnee) REFERENCES annee (dateAnnee),
	CONSTRAINT fk_cotiser_club FOREIGN KEY (codeClub) REFERENCES club (code),
	CONSTRAINT fk_cotiser_personne FOREIGN KEY (idPersonneCotisante) REFERENCES personne (id),
	CONSTRAINT fk_cotiser_personne FOREIGN KEY (idPersonneLicenciee) REFERENCES personne (id)
)
GO
----------------------------------------------------------------------------------------------------------------------------------------------
