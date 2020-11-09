SELECT *
FROM countries;

SELECT *
FROM people;

SELECT * 
FROM people
INNER JOIN countries on c_id=country_id;

SELECT *
FROM people
LEFT JOIN countries on c_id=country_id
ORDER BY user_id;

SELECT * 
FROM people
RIGHT JOIN countries ON c_id=country_id
ORDER BY user_id; #we should be able to sort by the "order" column, but it is a keyword!