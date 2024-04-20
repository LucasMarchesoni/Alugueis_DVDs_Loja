-- Quais filmes estão a mais tempo no estoque?

SELECT
	f.title,
	r.return_date
FROM
	film f 
	JOIN inventory i ON f.film_id = i.film_id
	JOIN rental r ON i.inventory_id = r.inventory_id
ORDER BY
	r.return_date ASC