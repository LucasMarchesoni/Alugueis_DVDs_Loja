-- Quais são os cinco filmes menos alugados deste ano? (Ano 2006)

SELECT 
	f.title,
	COUNT(r.rental_id) AS num_rentals
FROM
	rental r 
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film f ON f.film_id = i.film_id
WHERE
	r.rental_date BETWEEN '2006-01-01' AND '2006-02-28'
GROUP BY
	f.title
ORDER BY
	num_rentals ASC;