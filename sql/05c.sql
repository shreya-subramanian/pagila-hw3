/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

SELECT title
FROM film
JOIN film_actor fa USING (film_id)
JOIN (
    SELECT actor_id, count(*) AS cnt
    FROM film_actor
    JOIN film USING (film_id)
    WHERE title IN ('AMERICAN CIRCUS', 'ACADEMY DINOSAUR', 'AGENT TRUMAN')
    GROUP BY actor_id
) ref ON fa.actor_id = ref.actor_id
GROUP BY title
HAVING sum(ref.cnt) >= 3
ORDER BY title;
