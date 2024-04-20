-- Quais funcionários fizeram mais vendas por cada loja?

WITH funcionarios_por_loja
AS
(
	SELECT
		s.staff_id,
		s.first_name || ' ' || s.last_name AS full_name,
		st.store_id
	FROM
		staff s JOIN store st ON s.store_id = st.store_id 
)

SELECT 
	fl.store_id,
	fl.full_name,
	COUNT(r.rental_id) AS total_rental
FROM
	funcionarios_por_loja fl
	JOIN rental r ON fl.staff_id = r.staff_id
GROUP BY
	(fl.store_id, fl.full_name)
ORDER BY
	total_rental
DESC;
	