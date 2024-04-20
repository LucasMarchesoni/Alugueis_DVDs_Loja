-- Quais são os gêneros mais populares em diferentes países?

WITH film_by_categories AS (
    SELECT
        f.film_id,
        f.title,
        c.category_id,
        c.name
    FROM
        film f
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category c ON fc.category_id = c.category_id
), customer_country_with_rental AS (
    SELECT 
        f.film_id,
        r.rental_id,
        c.customer_id,
        co.country_id,
        co.country
    FROM
        film f
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
        JOIN customer c ON r.customer_id = c.customer_id
        JOIN address a ON c.address_id = a.address_id
        JOIN city ci ON a.city_id = ci.city_id
        JOIN country co ON ci.country_id = co.country_id
), ranked_genres_by_country AS (
    SELECT
        ccwr.country,
        fbc.name AS genre,
        ROW_NUMBER() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS genre_rank
    FROM
        film_by_categories fbc
        JOIN customer_country_with_rental ccwr ON fbc.film_id = ccwr.film_id
    GROUP BY
        country, name
)
SELECT
    country,
    genre
FROM
    ranked_genres_by_country
WHERE
    genre_rank = 1;
