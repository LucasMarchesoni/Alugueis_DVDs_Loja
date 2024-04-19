-- Qual a média de dias que um filme permanece alugado?

SELECT 
	ROUND(AVG(EXTRACT(DAY FROM r.return_date - r.rental_date)), 2) AS mean_day_rental
FROM
	rental r 
	JOIN inventory i ON r.inventory_id = i.inventory_id
	JOIN film f ON f.film_id = i.film_id
ORDER BY
	mean_day_rental DESC;