USE mysql_u39;

CREATE TABLE country(
	Code VARCHAR(255),
	Name VARCHAR(255),
	Continent VARCHAR(255),
	Region VARCHAR(255),
	SurfaceArea FLOAT,
	IndepYear INT,
	Population INT,
	LifeExpectancy FLOAT,
	GNP INT,
	GNPOld INT,
	LocalName VARCHAR(255),
	GovernamentForm VARCHAR(255),
	HeadOfState VARCHAR(255),
	Capital INT,
	Code VARCHAR(255),
	PRIMARY KEY (Code)
);

CREATE TABLE city(
	ID INT,
	Name VARCHAR(255),
	CountryCode VARCHAR(255),
	District VARCHAR(255),
	Population INT,
	PRIMARY KEY ID
);

ALTER TABLE ADD FOREIGN KEY (Capital) REFERENCES city(ID);

CREATE TABLE countrylanguage(
	CountryCode VARCHAR(255),
	Language VARCHAR(255),
	IsOfficial CHAR 1,
	Percentage FLOAT
);
