# BasesDeDatos
USE mysql_u60;

CREATE TABLE country (
    Code CHAR(3),
    Name VARCHAR(255),
    Continent VARCHAR(80),
    Region VARCHAR(80),
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
    Code2 CHAR(2),
    PRIMARY KEY (Code)
);

CREATE TABLE city(
    ID INT,
    Name VARCHAR(255),
    CountryCode VARCHAR(255),
    District VARCHAR(255),
    Population INT,
    PRIMARY KEY (ID)
);

CREATE TABLE countrylanguage(
    CountryCode VARCHAR(255),
    Language VARCHAR(255),
    IsOfficial VARCHAR(255),
    Percentage FLOAT,
    PRIMARY KEY (CountryCode, Language)
);


ALTER TABLE city ADD CONSTRAINT countrycode FOREIGN KEY (CountryCode) REFERENCES country(Code);
