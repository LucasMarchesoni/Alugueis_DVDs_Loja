-- Qual loja com mais vendas?

SELECT
	s.store_id,
	COUNT(r.rental_id) as total_rental
FROM 
	store s
	JOIN staff st ON s.store_id = st.store_id
	JOIN rental r ON st.staff_id = r.staff_id
GROUP BY
	s.store_id
ORDER BY total_rental DESC;