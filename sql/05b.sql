/*
 * Write a SQL query that lists the title of all movies where at least 2 actors were also in 'AMERICAN CIRCUS'.
 */

SELECT title
FROM film
WHERE film_id IN (
    SELECT film_id
    FROM film_actor
    WHERE actor_id IN (
        SELECT actor_id
        FROM film_actor
        JOIN film USING (film_id)
        WHERE title = 'AMERICAN CIRCUS'
    )
    GROUP BY film_id
    HAVING count(*) >= 2
)
ORDER BY title;
