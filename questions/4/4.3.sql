-- Qual o faturamento de cada loja indicando o valor e a cidade da loja?

SELECT
	s.store_id,
	c.city,
	SUM(p.amount) as total_amount
FROM 
	store s
	JOIN staff st ON s.store_id = st.store_id
	JOIN payment p ON st.staff_id = p.staff_id
	JOIN address a ON s.address_id = a.address_id
	JOIN city c ON a.city_id = c.city_id
GROUP BY
	(s.store_id, c.city)
ORDER BY total_amount DESC;
