-- Quais clientes fizeram mais compras e qual foi o valor gasto?

SELECT
	c.first_name || ' ' || c.last_name AS full_name,
	COUNT(r.rental_id) AS total_rentals,
	SUM(p.amount) AS total_amount
FROM
	customer c JOIN
	rental r ON c.customer_id = r.customer_id JOIN
	payment p ON r.rental_id = p.rental_id
GROUP BY
	full_name
ORDER BY
	total_rentals
DESC
	