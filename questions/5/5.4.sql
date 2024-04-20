-- Qual o faturamento por país?

SELECT
	co.country,
	SUM(p.amount) as total_amount
FROM
	customer cs
	JOIN address a ON cs.address_id = a.address_id
	JOIN city c ON a.city_id = c.city_id
	JOIN country co ON c.country_id = co.country_id
	JOIN payment p ON cs.customer_id = p.customer_id
GROUP BY
	co.country
ORDER BY
	total_amount
DESC;