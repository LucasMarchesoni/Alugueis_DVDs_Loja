-- Quais cidades tem mais residentes dos nossos clientes?

SELECT
	a.district,
	COUNT(a.city_id) AS total_city
FROM
	address a
GROUP BY
	a.district
ORDER BY
	total_city DESC;