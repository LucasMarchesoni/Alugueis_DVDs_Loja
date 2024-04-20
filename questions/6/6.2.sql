-- Qual o total de dinheiro cada funcionário vendeu por cada loja?

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
	COUNT(p.amount) AS total_amount
FROM
	funcionarios_por_loja fl
	JOIN payment p ON fl.staff_id = p.staff_id
GROUP BY
	(fl.store_id, fl.full_name)
ORDER BY
	total_amount
DESC;
	