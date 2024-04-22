-- Qual é a média de receita por aluguel?

SELECT
	ROUND(AVG(amount), 2) mean_payment
FROM
	payment
ORDER BY
	mean_payment
DESC;