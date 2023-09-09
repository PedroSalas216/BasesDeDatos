USE world;


CREATE TABLE continent (
    Name VARCHAR(80),
    Area INT,
    TotalMassPercent FLOAT,
    MostPopulatedCity VARCHAR(255),
    PRIMARY KEY (Name)
);

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


INSERT INTO continent VALUES ('Africa', 30370000, 20.4, 'Cairo');


INSERT INTO continent (Name, Area, TotalMassPercent, MostPopulatedCity)
VALUES ('Antartica', 14000000, 9.2, 'McMurdo Station');

INSERT INTO continent VALUES ('Asia', 44579000, 29.5, 'Mumbai');
INSERT INTO continent VALUES ('Europe', 10180000, 6.8, 'Istanbul');
INSERT INTO continent VALUES ('North America', 24709000, 16.5, 'Ciudad de México');
INSERT INTO continent VALUES ('Oceania', 8600000, 5.9, 'Sydney');
INSERT INTO continent VALUES ('South America', 17840000, 12.0, 'São Paulo');


ALTER TABLE city ADD CONSTRAINT city_f_key FOREIGN KEY (CountryCode) REFERENCES country(Code);

ALTER TABLE countrylanguage 
    ADD CONSTRAINT countrylan_f_key FOREIGN KEY (CountryCode) REFERENCES country(Code);


--------------------------------------PARTE 1

ALTER TABLE country ADD CONSTRAINT continent_f_key FOREIGN KEY (Continent) REFERENCES continent(Name);


--------------------------------------PARTE 2 

SELECT Name, Region FROM country ORDER BY Name LIMIT 10;

SELECT Name, Population  FROM country ORDER BY Population DESC LIMIT 10;

SELECT Name, Region, SurfaceArea, GovernamentForm  FROM country ORDER BY SurfaceArea LIMIT 10;

SELECT * FROM country WHERE country.IndepYear < 0;

SELECT `Language` , Percentage FROM countrylanguage WHERE countrylanguage.IsOfficial = "T";

