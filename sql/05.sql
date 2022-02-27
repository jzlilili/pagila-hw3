/*
 * You love the acting in the movie 'AMERICAN CIRCUS' and want to watch other movies with the same actors.
 *
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 *
 * HINT:
 * This can be solved with a self join on the film_actor table.
 */

SELECT DISTINCT title
FROM film
JOIN film_actor t1 USING (film_id)
JOIN film_actor t2 ON (t1.actor_id != t2.actor_id AND t1.film_id = t2.film_id)
WHERE t1.actor_id IN  
(
    SELECT actor_id
    FROM film_actor
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)
AND t2.actor_id IN
(
    SELECT actor_id
    FROM film_actor
    JOIN film USING (film_id)
    WHERE title = 'AMERICAN CIRCUS'
)
ORDER BY title

