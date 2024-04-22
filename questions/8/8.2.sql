-- Qual o filme mais bem avaliado?

SELECT
	title,
	rating
FROM
	film
ORDER BY
	rating
DESC;