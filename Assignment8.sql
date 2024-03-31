--   QUESTION 1
   
   ALTER TABLE rental
	ADD COLUMN status VARCHAR(255);


	UPDATE rental
	SET status = (
	  SELECT CASE
	    WHEN r.return_date < (r.rental_date + INTERVAL '1 day' * f.rental_duration) THEN 'Early'
	    WHEN r.return_date = (r.rental_date + INTERVAL '1 day' * f.rental_duration) THEN 'On Time'
	    ELSE 'Late'
	  END
	  FROM rental r
	  JOIN inventory i ON r.inventory_id = i.inventory_id
	  JOIN film f ON i.film_id = f.film_id
	  WHERE r.rental_id = rental.rental_id
	);
	
-- QUESTION 2

	SELECT 
	    c.city, 
	    SUM(p.amount) AS total_payments
	FROM 
	    payment p
	JOIN 
	    customer cu ON p.customer_id = cu.customer_id
	JOIN 
	    address a ON cu.address_id = a.address_id
	JOIN 
	    city c ON a.city_id = c.city_id
	WHERE 
	    c.city IN ('Kansas City', 'Saint Louis')
	GROUP BY 
	    c.city;

-- QUESTION 3
    SELECT 
    c.name AS category_name, 
    COUNT(f.film_id) AS no_of_films
        FROM 
            category c
        JOIN 
            film_category fc ON c.category_id = fc.category_id
        JOIN 
            film f ON fc.film_id = f.film_id
        GROUP BY 
            c.name
        ORDER BY 
            no_of_films DESC;
            
 -- QUESTION 5
     SELECT 
        f.film_id, 
        f.title, 
        f.length
    FROM 
        film f
    JOIN 
        inventory i ON f.film_id = i.film_id
    JOIN 
        rental r ON i.inventory_id = r.inventory_id
    WHERE 
        r.return_date BETWEEN '2005-05-15' AND '2005-05-31'
    GROUP BY 
        f.film_id;
        
-- QUESTION 6
   SELECT 
    DISTINCT f.film_id, 
        f.title, 
        f.rental_rate
        FROM 
            film f
        JOIN 
            inventory i ON f.film_id = i.film_id
        JOIN 
            rental r ON i.inventory_id = r.inventory_id
        WHERE 
            f.rental_rate < (SELECT AVG(rental_rate) FROM film)
        ORDER BY 
            f.rental_rate;
-- QUESTION 7
SELECT 
    CASE 
        WHEN r.return_date < r.rental_date + INTERVAL '1 day' * f.rental_duration THEN 'Early'
        WHEN r.return_date = r.rental_date + INTERVAL '1 day' * f.rental_duration THEN 'On Time'
        ELSE 'Late'
    END AS return_status,
    COUNT(*) AS total_returns
    FROM 
        rental r
    JOIN 
        inventory i ON r.inventory_id = i.inventory_id
    JOIN 
        film f ON i.film_id = f.film_id
    GROUP BY 
        return_status;
        
-- QUESTION 8
    SELECT 
        title,
        length AS duration,
        PERCENT_RANK() OVER (ORDER BY length) AS duration_percentile_rank
    FROM 
        film;


-- QUESTION 9
JOIN QUERY:
		SELECT 
    c.city, 
    SUM(p.amount) AS total_payments
FROM 
    payment p
JOIN 
    customer cu ON p.customer_id = cu.customer_id
JOIN 
    address a ON cu.address_id = a.address_id
JOIN 
    city c ON a.city_id = c.city_id
WHERE 
    c.city IN ('Kansas City', 'Saint Louis')
GROUP BY 
    	c.city;	

WINDOW QUERY:	
SELECT 
 title,
 length AS duration,
 PERCENT_RANK() OVER (ORDER BY length) AS 	duration_percentile_rank
FROM 
film;
-- DIFFERENCES:
1.	The join query will be slow in terms of performance  especially if the tables involved are large. compared to using window queries
2.	In the join query, use of indexes can be used to speed up the join query performance. 
While the window function query's efficiency depends on the ability to sort.
	
●	Find the relationship that is wrong in the data model. Explain why it’s wrong.
	- The relationship between rental and staff table 
ALTER TABLE ONLY public.rental
    ADD CONSTRAINT rental_staff_id_key FOREIGN KEY (staff_id) REFERENCES public.staff(staff_id);
–	Constraint Naming Issue - The naming convention rental_staff_id_key 		
suggests it might be intended as a unique key or a primary key 			
constraint rather than a foreign key constraint.The name 				
rental_staff_id_key could lead to confusion regarding its purpose


●	-- In under 100 words, explain what the difference is between set-based and procedural programming. 
-- Be sure to specify which sql and python are.
 
-- Set-based programming operates on entire sets of data at once, allowing for operations like retrieval, updating,
or aggregation to be performed on all applicable data points, suitable for database queries and manipulations. 
While  in  procedural programming like python, executes instructions step by step, manipulating data 
through sequential manner, making it suitable for a wide range of tasks , including algorithms and user 
interface design. SQL is set-based, focusing on data sets, while python is procedural (and also object-oriented), 
focusing on step-by-step instruction execution






