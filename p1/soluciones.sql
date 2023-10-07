-- Ejercicio 1

ALTER TABLE person 
ADD total_medals INT UNSIGNED DEFAULT 0;


-- Ejercicio 2

CREATE VIEW medalists AS
SELECT p.full_name, p.id , COUNT(m.id) AS total
FROM person p, medal m, competitor_event ce , games_competitor gc
WHERE p.id = gc.person_id
AND gc.id = ce.competitor_id
AND ce.medal_id = m.id
AND m.id != 4
GROUP BY p.id;

UPDATE person p
SET
p.total_medals = (SELECT me.total
FROM medalists me
WHERE p.id = me.id
AND me.total > 0);


-- Ejercicio 3
CREATE VIEW bronze_medalists AS
SELECT p.id , p.full_name, "Bronze" AS grade, COUNT(m.id) AS total
FROM person p, medal m, competitor_event ce , games_competitor gc
WHERE p.id = gc.person_id
AND gc.id = ce.competitor_id
AND ce.medal_id = m.id
AND m.id = 3
GROUP BY p.id;

CREATE VIEW silver_medalists AS
SELECT p.id , p.full_name, "Silver" AS grade, COUNT(m.id) AS total
FROM person p, medal m, competitor_event ce , games_competitor gc
WHERE p.id = gc.person_id
AND gc.id = ce.competitor_id
AND ce.medal_id = m.id
AND m.id = 2
GROUP BY p.id;

CREATE VIEW gold_medalists AS
SELECT p.id , p.full_name, "Gold" AS grade, COUNT(m.id) AS total
FROM person p, medal m, competitor_event ce , games_competitor gc
WHERE p.id = gc.person_id
AND gc.id = ce.competitor_id
AND ce.medal_id = m.id
AND m.id = 1
GROUP BY p.id;

CREATE VIEW nacionalidad AS 
SELECT p.id AS person_id, nr.noc AS national_code, nr.region_name AS country
FROM person p, person_region pr, noc_region nr
WHERE p.id = pr.person_id
AND pr.region_id = nr.id;


-- query --

(
	(SELECT b.full_name, b.grade, b.total
FROM bronze_medalists b
INNER JOIN nacionalidad n ON
	n.person_id = b.id
WHERE n.national_code LIKE "ARG")
UNION 
	(SELECT s.full_name, s.grade, s.total
FROM silver_medalists s
INNER JOIN nacionalidad n ON
	n.person_id = s.id
WHERE n.national_code LIKE "ARG")
)
UNION 
( SELECT g.full_name, g.grade, g.total
FROM gold_medalists g
INNER JOIN nacionalidad n ON
	n.person_id = g.id
WHERE n.national_code LIKE "ARG"
);

-- Ejercicio 4
SELECT s.sport_name , count(m.id)
FROM nacionalidad n, games_competitor gc, competitor_event ce, event e, sport s, medal m
WHERE m.id != 4
AND s.id = e.sport_id
AND ce.medal_id = m.id
AND e.id = ce.event_id
AND gc.id = ce.competitor_id
AND n.person_id = gc.person_id
AND n.national_code = "ARG"
GROUP BY s.sport_name;

-- Ejercicio 5

SELECT n.country, sum(m.total) AS medals
FROM nacionalidad n
LEFT JOIN medalists m
ON
n.person_id = m.id
GROUP BY n.country;

-- Ejercicio 6

CREATE VIEW country_by_medals AS 
SELECT n.country, sum(m.total) AS medals
FROM nacionalidad n
LEFT JOIN medalists m
ON
n.person_id = m.id
GROUP BY n.country 

-- query --

(SELECT *
FROM country_by_medals
ORDER BY medals DESC
LIMIT 1)
UNION 
(SELECT *
FROM country_by_medals
ORDER BY medals ASC
LIMIT 1);

-- Ejercicio 7
delimiter //
CREATE TRIGGER IF NOT EXISTS increase_number_of_medals BEFORE INSERT ON
competitor_event
FOR EACH ROW
BEGIN 
    UPDATE person p
SET
p.total_medals = p.total_medals + 1
WHERE p.id = NEW.person_id;

END //
delimiter ;


delimiter //
CREATE TRIGGER IF NOT EXISTS decrease_number_of_medals BEFORE DELETE ON
competitor_event
FOR EACH ROW
BEGIN 
    UPDATE person p
SET
p.total_medals = p.total_medals -1
WHERE p.id = OLD.person_id;
END //
delimiter ;


-- Ejercicio 8


delimiter //
CREATE PROCEDURE IF NOT EXISTS add_new_medalists (IN event_id int, IN g_id int, IN s_id int, IN  b_id int)
BEGIN 
	INSERT INTO competitor_event(event_id, competitor_id , medal_id) 
	VALUES (event_id,g_id,1),
	(event_id,s_id,2),
	(event_id,b_id,3);
END//
delimiter ;


-- Ejercicio 9

CREATE ROLE organizer;
GRANT DELETE ,UPDATE (games_name) ON games TO organizer;
