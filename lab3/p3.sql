USE world;
-- PARTE 1

-- listar nombre, pais, region, gov form de las 10 ciudades mas pobladas

SELECT city.Name, country.Name, country.Region, country.GovernamentForm 
FROM city 
INNER JOIN country ON country.Code = city.CountryCode
ORDER BY city.Population DESC LIMIT 10;

-- Listar los 10 países con menor población del mundo, junto a sus ciudades capitales 
SELECT country.Name, city.Name 
FROM country 
INNER JOIN city ON country.Capital = city.ID  
ORDER BY country.Population ASC LIMIT 10;

-- Listar el nombre, continente y todos los lenguajes oficiales de cada país. 
	-- (Hint: habrá más de una fila por país si tiene varios idiomas oficiales).

SELECT country.Name, country.Continent, countrylanguage.`Language` 
FROM country 
INNER JOIN countrylanguage 
ON country.Code = countrylanguage.CountryCode 
AND countrylanguage.IsOfficial = "T";

-- Listar el nombre del país y nombre de capital, de los 20 países con mayor superficie del mundo.

SELECT country.Name, city.Name 
FROM country 
INNER JOIN city 
ON country.Capital = city.ID 
ORDER BY country.SurfaceArea DESC 
LIMIT 20;

-- Listar las ciudades junto a sus idiomas oficiales (ordenado por la población de la ciudad) y 
   -- el porcentaje de hablantes del idioma.
SELECT  city.Name, countrylanguage.`Language`, countrylanguage.Percentage 
FROM country 
INNER JOIN city 
ON country.Code = city.CountryCode
INNER JOIN countrylanguage 
ON country.Code = countrylanguage.CountryCode 
ORDER BY city.Population DESC ;

-- Listar los 10 países con mayor población y los 10 países con menor población 
	-- (que tengan al menos 100 habitantes) en la misma consulta.
(
SELECT country.Name
FROM country
ORDER BY country.Population desc
LIMIT 10
)
UNION
(
SELECT country.Name 
FROM country 
WHERE country.Population > 100
ORDER BY country.Population ASC  LIMIT 10
)


-- Listar aquellos países cuyos lenguajes oficiales son el Inglés y el Francés (hint: no debería haber filas duplicadas).
(
SELECT country.Name
FROM country 
INNER JOIN countrylanguage 
ON countrylanguage.CountryCode = country.Code 
AND countrylanguage.IsOfficial = "T"
AND countrylanguage.`Language` = "French"
)
UNION
(
SELECT country.Name 
FROM country 
INNER JOIN countrylanguage 
ON countrylanguage.CountryCode = country.Code 
AND countrylanguage.`Language` = "English" 
AND countrylanguage.IsOfficial = "T"
)

-- Listar aquellos países que tengan hablantes del Inglés pero no del Español en su población.

(
SELECT country.Name, countrylanguage.`Language` 
FROM country 
INNER JOIN countrylanguage 
ON countrylanguage.CountryCode = country.Code 
AND countrylanguage.`Language` = "English"
)
INTERSECT 
(
SELECT country.Name, countrylanguage.`Language`  
FROM country 
INNER JOIN countrylanguage 
ON countrylanguage.CountryCode = country.Code 
AND countrylanguage.`Language` != "Spanish"
)

-- PARTE 2

-- 1. ¿Devuelven los mismos valores las siguientes consultas? ¿Por qué? 

SELECT city.Name, country.Name
FROM city
INNER JOIN country ON city.CountryCode = country.Code AND country.Name = 'Argentina';

SELECT city.Name, country.Name
FROM city
INNER JOIN country ON city.CountryCode = country.Code
WHERE country.Name = 'Argentina';

-- Si, tanto WHERE como AND agregan condiciones flitro. Usar AND, permite generar una aritmetica 
	-- logica usando "(", ")", "AND", "OR", "NOT".

-- 2. ¿Y si en vez de INNER JOIN fuera un LEFT JOIN?

-- Seria lo mismo, pues las condiciones son las mismas. 

