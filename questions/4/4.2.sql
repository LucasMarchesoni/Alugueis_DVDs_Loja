-- Quais cidades possuem loja?

SELECT
	s.store_id,
	c.city
FROM 
	store s
	JOIN address a ON s.address_id = a.address_id
	JOIN city c ON a.city_id = c.city_id;
