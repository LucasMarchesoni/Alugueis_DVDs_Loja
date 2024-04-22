-- Quais atores estavam mais presentes nos filmes?

SELECT
	a.first_name || ' ' || a.last_name AS full_name,
	COUNT(a.actor_id) as total_actor_appereances
FROM 
	film f JOIN
	film_actor fa ON f.film_id = fa.film_id JOIN
	actor a ON fa.actor_id = a.actor_id
GROUP BY
	full_name
ORDER BY
	total_actor_appereances
DESC;