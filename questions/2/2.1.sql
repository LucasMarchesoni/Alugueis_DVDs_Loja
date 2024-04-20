-- Quais são os clientes mais frequentes?

SELECT
	c.first_name || ' ' || c.last_name AS full_name,
	COUNT(r.customer_id) AS total_rental
FROM
	rental r JOIN customer c ON c.customer_id = r.customer_id
GROUP BY
	full_name
ORDER BY
	total_rental DESC;