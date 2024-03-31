-- QUESTION 1
SELECT *
FROM payment
WHERE amount >= 9.99;

-- QUESTION 2
-- Step 1: Find the maximum payment amount
SELECT MAX(amount) AS max_payment_amount
FROM payment;
-- Step 2: Find films rented at the maximum payment amount
SELECT film.*
FROM film
JOIN inventory ON film.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
WHERE payment.amount = (SELECT MAX(amount) FROM payment);

-- QUESTION 3

SELECT
    staff.first_name || ' ' || staff.last_name AS full_name,
    staff.email,
    address.address,
    city.city,
    country.country
FROM
    staff
JOIN
    address ON staff.address_id = address.address_id
JOIN
    city ON address.city_id = city.city_id
JOIN
    country ON city.country_id = country.country_id;

-- QUESTION 4
I would be drawn to companies that foster innovation and strive to make a positive impact, whether through groundbreaking technology, social initiatives, or environmental sustainability efforts. Continuous learning and professional development are essential for me. I would be attracted to companies that invest in employee growth through training programs, mentorship, and opportunities for advancement. I value diversity and inclusion in the workplace, so I would seek out companies that embrace diverse perspectives, promote equality, and create an inclusive environment where everyone feels valued and respected.
I would want to work for companies with strong ethical values and a commitment to integrity in all aspects of their operations, including their treatment of employees, customers, and the community. I'm motivated by work that has purpose and meaning, so I would be interested in industries or companies that align with my personal values and offer opportunities to make a meaningful contribution to society.
-- QUESTION 5
In the context of database design, the Crow's Foot notation is a graphical representation used to depict relationships between tables in an Entity-Relationship Diagram (ERD). It visually illustrates how different tables are connected or related to each other through their attributes or columns.
In the dvdrental database, which is commonly used for educational purposes and learning SQL, you may encounter relationships between various tables such as film, inventory, rental, payment, customer, address, etc.
Let's take an example of the relationship between two tables, say customer
and address.
In the dvdrental database, the relationship between the customer table and the address table is likely to represent that each customer can have one or more addresses associated with them. This relationship is typically represented in the Crow's Foot notation as follows:
•	One customer can have multiple addresses: This is depicted by placing a crow's foot (a symbol resembling a bird's footprints) on the customer side of the relationship line.
•	One address belongs to only one customer: This is represented by not placing any crow's foot on the address side of the relationship line.
Customer 1 -----< Address




