SELECT c.name, f.title, f.rentals AS "total rentals"
FROM category c
JOIN LATERAL (
    SELECT f.title, f.film_id, count(r.rental_id) AS rentals,
           rank() OVER (ORDER BY count(r.rental_id) DESC, f.film_id DESC) AS rank
    FROM film_category fc
    JOIN film f USING (film_id)
    JOIN inventory i USING (film_id)
    JOIN rental r USING (inventory_id)
    WHERE fc.category_id = c.category_id
    GROUP BY f.film_id, f.title
) AS f ON f.rank <= 5
ORDER BY c.name, f.rentals DESC, f.film_id ASC;
