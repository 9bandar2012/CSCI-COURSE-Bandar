-- QUESTION  1

SELECT *
FROM customer
WHERE last_name LIKE 'T%'
ORDER BY first_name;

-- QUESTION 2
SELECT *
FROM rental
WHERE return_date >= '2005-05-28' AND return_date <= '2005-06-01';
-- QUESTION 3
SELECT film.film_id, film.title, COUNT(rental.rental_id) AS rental_count
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
GROUP BY film.film_id, film.title
ORDER BY rental_count DESC
LIMIT 10;
-- QUESTION  4
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(p.amount), 0) AS total_spent
FROM 
    customer c
LEFT JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent;
-- QUESTION  5
SELECT 
    actor.actor_id,
    actor.first_name || ' ' || actor.last_name AS actor_name,
    COUNT(film.film_id) AS movie_count_2006
FROM 
    actor
JOIN 
    film_actor ON actor.actor_id = film_actor.actor_id
JOIN 
    film ON film_actor.film_id = film.film_id
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
WHERE 
    rental.rental_date >= '2006-01-01' AND rental.rental_date < '2007-01-01'
GROUP BY 
    actor.actor_id, actor_name
ORDER BY 
    movie_count_2006 DESC
LIMIT 1;

-- QUESTION  6
Query 4
EXPLAIN 
SELECT 
    actor.actor_id,
    actor.first_name || ' ' || actor.last_name AS actor_name,
    COUNT(film.film_id) AS movie_count_2006
FROM 
    actor
JOIN 
    film_actor ON actor.actor_id = film_actor.actor_id
JOIN 
    film ON film_actor.film_id = film.film_id
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
WHERE 
    rental.rental_date >= '2006-01-01' AND rental.rental_date < '2007-01-01'
GROUP BY 
    actor.actor_id, actor_name
ORDER BY 
    movie_count_2006 DESC
LIMIT 1;

Explanation:
1.	The query joins multiple tables (actor, film_actor, film, inventory, rental) to gather information about actors, films, inventory, and rentals.
2.	It filters rentals to only include those from the year 2006.
3.	The results are grouped by actor ID and name.
4.	It counts the number of films each actor was in during 2006.
5.	The result set is ordered by the count of movies each actor appeared in during 2006 in descending order.
6.	Finally, it limits the result set to only return the top row, which contains the actor who was in the most movies in 2006.
Query 5:
EXPLAIN 
SELECT 
    c.customer_id,
    c.first_name,
    c.last_name,
    COALESCE(SUM(p.amount), 0) AS total_spent
FROM 
    customer c
LEFT JOIN 
    payment p ON c.customer_id = p.customer_id
GROUP BY 
    c.customer_id, c.first_name, c.last_name
ORDER BY 
    total_spent;

Explanation:
1.	The query retrieves customer information from the customer table.
2.	It performs a left join with the payment table on the customer_id column to include payment information for each customer.
3.	Results are grouped by customer ID, first name, and last name.
4.	It calculates the total amount spent by each customer using SUM(p.amount) and handles potential NULL values with COALESCE.
5.	The result set is ordered by the total amount spent from least to most.
The explain plan generated by PostgreSQL will provide details on the execution steps, such as which indexes are used, how data is retrieved, and any sorting operations performed. You can execute these queries with the EXPLAIN command in PostgreSQL to get the detailed explain plans.
-- QUESTION  8
SELECT 
    category.name AS genre,
    AVG(film.rental_rate) AS average_rental_rate
FROM 
    film
JOIN 
    film_category ON film.film_id = film_category.film_id
JOIN 
    category ON film_category.category_id = category.category_id
GROUP BY 
    category.name;

-- QUESTION 9 
SELECT 
    category.name AS category_name,
    COUNT(rental.rental_id) AS rental_count,
    COALESCE(SUM(payment.amount), 0) AS total_sales
FROM 
    category
JOIN 
    film_category ON category.category_id = film_category.category_id
JOIN 
    film ON film_category.film_id = film.film_id
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
LEFT JOIN 
    payment ON rental.rental_id = payment.rental_id
GROUP BY 
    category.name
ORDER BY 
    rental_count DESC
LIMIT 5;

-- QUESTION 9
SELECT 
    category.name AS category_name,
    EXTRACT(MONTH FROM rental.rental_date) AS rental_month,
    COUNT(DISTINCT film.film_id) AS total_rented_films
FROM 
    category
JOIN 
    film_category ON category.category_id = film_category.category_id
JOIN 
    film ON film_category.film_id = film.film_id
JOIN 
    inventory ON film.film_id = inventory.film_id
JOIN 
    rental ON inventory.inventory_id = rental.inventory_id
GROUP BY 
    category.name, rental_month
ORDER BY 
    category_name, rental_month;


