/*
 * The film 'BUCKET BROTHERHOOD' is your favorite movie, but you're tired of watching it.
 * You want to find something new to watch that is still similar to 'BUCKET BROTHERHOOD'.
 * To find a similar movie, you decide to search the history of movies that other people have rented. * Your idea is that if a lot of people have rented both 'BUCKET BROTHERHOOD' and movie X,
 * then movie X must be similar and something you'd like to watch too.
 * Your goal is to create a SQL query that finds movie X.
 * Specifically, write a SQL query that returns all films that have been rented by at least 3 customers who have also rented 'BUCKET BROTHERHOOD'.
 *
 * HINT:
 * This query is very similar to the query from problem 06,
 * but you will have to use joins to connect the rental table to the film table.
 *
 * HINT:
 * If your query is *almost* getting the same results as mine, but off by 1-2 entries, ensure that:
 * 1. You are not including 'BUCKET BROTHERHOOD' in the output.
 * 2. Some customers have rented movies multiple times.
 *    Ensure that you are not counting a customer that has rented a movie twice as 2 separate customers renting the movie.
 *    I did this by using the SELECT DISTINCT clause.
 */

WITH bb_id AS
(
    SELECT film_id
    FROM film
    WHERE title = 'BUCKET BROTHERHOOD'
)


SELECT title
FROM
(
    SELECT rec_id, COUNT(*) AS "rec_count"
    FROM
    (   
        SELECT DISTINCT inventory.film_id AS "rec_id", r1.customer_id, r2.film_id
        FROM inventory
        JOIN rental r1 USING (inventory_id)
        JOIN 
        (   
            SELECT customer_id, film_id
            FROM inventory
            JOIN rental USING (inventory_id)
        ) r2 ON 
        (       
            r1.customer_id = r2.customer_id
            AND r2.film_id IN (SELECT * FROM bb_id)
        )       
    ) t1        
    GROUP BY rec_id
) t2    
JOIN film ON (t2.rec_id = film.film_id)
WHERE t2.rec_count >= 3
AND film_id NOT IN (SELECT * FROM bb_id)
ORDER BY title

