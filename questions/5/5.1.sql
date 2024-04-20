-- Qual cidade possui mais clientes?

SELECT
	c.city,
	COUNT(cs.customer_id) AS total_customers
FROM
	customer cs
	JOIN address a ON cs.address_id = a.address_id
	JOIN city c ON a.city_id = c.city_id
GROUP BY
	c.city
ORDER BY
	total_customers
DESC;