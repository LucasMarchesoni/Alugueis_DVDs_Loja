-- Qual país possui mais clientes?

SELECT
	co.country,
	COUNT(cs.customer_id) AS total_customers
FROM
	customer cs
	JOIN address a ON cs.address_id = a.address_id
	JOIN city c ON a.city_id = c.city_id
	JOIN country co ON c.country_id = co.country_id
GROUP BY
	co.country
ORDER BY
	total_customers
DESC;