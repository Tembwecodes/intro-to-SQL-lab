-- Clue #1: We recently got word that someone fitting Carmen Sandiego's description has been 
-- traveling through Southern Europe. She's most likely traveling someplace where she won't 
-- be noticed, so find the least populated country in Southern Europe.
-- Write SQL query here
SELECT name, population 
FROM countries 
WHERE region = 'Southern Europe' 
ORDER BY population ASC 
LIMIT 1;

-- Clue #2: Now that we're here, we have insight that Carmen was seen attending language classes 
-- in this country's officially recognized language. Check our databases and find out what 
-- language is spoken in this country, so we can call in a translator to work with you.
-- Write SQL query here
SELECT DISTINCT cl.language
FROM countrylanguages cl
JOIN countries c ON cl.country_code = c.code
WHERE c.name = 'Holy See (Vatican City State)';

-- Clue #3: We have new news on the classes Carmen attended – our gumshoes tell us she's moved on 
-- to a different country, a country where people speak only the language she was learning. 
-- Find out which nearby country speaks nothing but that language.
-- Write SQL query here
SELECT c.name
FROM countries c
JOIN countrylanguages cl ON c.code = cl.countrycode
GROUP BY c.name
HAVING COUNT(*) = 1 
AND MAX(cl.language) = 'Italian';

-- Clue #4: We're booking the first flight out – maybe we've actually got a chance to catch her this time. 
-- There are only two cities she could be flying to in the country. One is named the same as the country 
-- – that would be too obvious. We're following our gut on this one; find out what other city in that 
-- country she might be flying to.
-- Write SQL query here
SELECT ci.name
FROM cities ci
JOIN countries co ON ci.countrycode = co.code
WHERE co.name = 'San Marino'
AND ci.name != 'San Marino';

-- Clue #5: Oh no, she pulled a switch – there are two cities with very similar names, but in totally 
-- different parts of the globe! She's headed to South America as we speak; go find a city whose name is 
-- like the one we were headed to, but doesn't end the same. Find out the city, and do another search 
-- for what country it's in. Hurry!
-- Write SQL query here
SELECT ci.name, co.name as country
FROM cities ci
JOIN countries co ON ci.countrycode = co.code
WHERE co.continent = 'South America'
AND ci.name LIKE 'Serra%';

-- Clue #6: We're close! Our South American agent says she just got a taxi at the airport, and is headed 
-- towards the capital! Look up the country's capital, and get there pronto! Send us the name of where 
-- you're headed and we'll follow right behind you!
-- Write SQL query hereSELECT ci.name 
SELECT ci.name
FROM cities ci
JOIN countries co ON ci.countrycode = co.code
WHERE co.name = 'Brazil'
AND ci.id = co.capital;


-- Clue #7: She knows we're on to her – her taxi dropped her off at the international airport, and she 
-- beat us to the boarding gates. We have one chance to catch her, we just have to know where she's 
-- heading and beat her to the landing dock.
-- Write SQL query here
SELECT ci.name, co.name as country, ci.population
FROM cities ci
JOIN countries co ON ci.countrycode = co.code
WHERE ci.population BETWEEN 91000 AND 91100
ORDER BY ci.population;
