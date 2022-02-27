/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

WITH bacall_0 AS  
(
    SELECT actor_id
    FROM actor 
    WHERE actor.first_name = 'RUSSELL' 
    AND actor.last_name = 'BACALL'
)

SELECT DISTINCT a1.first_name || ' ' || a1.last_name as "Actor Name"
FROM actor a1
JOIN film_actor fa1 ON (a1.actor_id = fa1.actor_id)
JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id)
JOIN actor a2 ON (fa2.actor_id = a2.actor_id)
WHERE a2.actor_id IN  
(
    SELECT a1.actor_id
    FROM actor a1
    JOIN film_actor fa1 ON (a1.actor_id = fa1.actor_id)
    JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id)
    JOIN actor a2 ON (fa2.actor_id = a2.actor_id)
    WHERE a2.actor_id IN (SELECT * FROM bacall_0)
)
AND a1.actor_id NOT IN  
(
    SELECT a1.actor_id
    FROM actor a1
    JOIN film_actor fa1 ON (a1.actor_id = fa1.actor_id)
    JOIN film_actor fa2 ON (fa1.film_id = fa2.film_id)
    JOIN actor a2 ON (fa2.actor_id = a2.actor_id)
    WHERE a2.actor_id IN (SELECT * FROM bacall_0)
)
ORDER BY "Actor Name"

