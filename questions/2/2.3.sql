-- Quais são os principais tipos de filmes alugados por diferentes grupos demográficos?

WITH ranked_categories AS (
    SELECT
        a.district,
        ca.name AS category_name,
        COUNT(*) AS category_count,
        ROW_NUMBER() OVER (PARTITION BY a.district ORDER BY COUNT(*) DESC) AS category_rank
    FROM
        address a
        JOIN customer c ON a.address_id = c.address_id
        JOIN rental r ON c.customer_id = r.customer_id
        JOIN inventory i ON r.inventory_id = i.inventory_id
        JOIN film f ON i.film_id = f.film_id
        JOIN film_category fc ON f.film_id = fc.film_id
        JOIN category ca ON fc.category_id = ca.category_id
    GROUP BY
        a.district,
        ca.name
)
SELECT
    district,
    category_name,
    category_count
FROM
    ranked_categories
WHERE
    category_rank = 1 AND district != ''
ORDER BY
	category_count DESC;
