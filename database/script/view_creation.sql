CREATE VIEW vw_get_more_rental_films_on_february AS
(
	-- Qual é o filme mais alugado do último mês? (Último mês para base é Fevereiro de 2006)

	SELECT 
		f.title,
		COUNT(r.rental_id) AS num_rentals
	FROM
		rental r 
		JOIN inventory i ON r.inventory_id = i.inventory_id
		JOIN film f ON f.film_id = i.film_id
	WHERE
		r.rental_date BETWEEN '2006-02-01' AND '2006-02-28'
	GROUP BY
		f.title
	ORDER BY
		num_rentals DESC
);

CREATE VIEW vw_get_less_films_rentals_on_the_current_year AS
(
	-- Quais são os cinco filmes menos alugados deste ano? (Ano 2006)

	SELECT 
		f.title,
		COUNT(r.rental_id) AS num_rentals
	FROM
		rental r 
		JOIN inventory i ON r.inventory_id = i.inventory_id
		JOIN film f ON f.film_id = i.film_id
	WHERE
		r.rental_date BETWEEN '2006-01-01' AND '2006-02-28'
	GROUP BY
		f.title
	ORDER BY
		num_rentals ASC
);

CREATE VIEW vw_get_avg_rental_time AS
(
	-- Qual a média de dias que um filme permanece alugado?

	SELECT 
		ROUND(AVG(EXTRACT(DAY FROM r.return_date - r.rental_date)), 2) AS mean_day_rental
	FROM
		rental r 
		JOIN inventory i ON r.inventory_id = i.inventory_id
		JOIN film f ON f.film_id = i.film_id
	ORDER BY
		mean_day_rental DESC
);

CREATE VIEW vw_get_frequent_customers AS
(
	-- Quais são os clientes mais frequentes?

	SELECT
		c.first_name || ' ' || c.last_name AS full_name,
		COUNT(r.customer_id) AS total_rental
	FROM
		rental r JOIN customer c ON c.customer_id = r.customer_id
	GROUP BY
		full_name
	ORDER BY
		total_rental DESC
);

CREATE VIEW vw_get_higher_city_customers AS
(
	-- Quais cidades tem mais residentes dos nossos clientes?

	SELECT
		a.district,
		COUNT(a.city_id) AS total_city
	FROM
		address a
	GROUP BY
		a.district
	ORDER BY
		total_city DESC
);

CREATE VIEW vw_get_most_rentals_filmes_per_city AS
(
	-- Quais são os principais tipos de filmes alugados por diferentes grupos demográficos?

	WITH ranked_categories AS (
		SELECT
			a.district,
			ca.name AS category_name,
			COUNT(*) AS category_count,
			ROW_NUMBER() OVER (PARTITION BY a.district ORDER BY COUNT(*) DESC) AS category_rank
		FROM
			address a
			JOIN customer c ON a.address_id = c.address_id
			JOIN rental r ON c.customer_id = r.customer_id
			JOIN inventory i ON r.inventory_id = i.inventory_id
			JOIN film f ON i.film_id = f.film_id
			JOIN film_category fc ON f.film_id = fc.film_id
			JOIN category ca ON fc.category_id = ca.category_id
		GROUP BY
			a.district,
			ca.name
	)
	SELECT
		district,
		category_name,
		category_count
	FROM
		ranked_categories
	WHERE
		category_rank = 1 AND district != ''
	ORDER BY
		category_count DESC
);

CREATE VIEW vw_get_time_film_is_on_stock AS
(
	-- Quais filmes estão a mais tempo no estoque?

	SELECT
		f.title,
		r.return_date
	FROM
		film f 
		JOIN inventory i ON f.film_id = i.film_id
		JOIN rental r ON i.inventory_id = r.inventory_id
	ORDER BY
		r.return_date ASC
);

CREATE VIEW vw_get_store_with_more_rentals AS
(
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
	ORDER BY total_rental DESC
);

CREATE VIEW vw_get_stores_cities AS
(
	-- Quais cidades possuem loja?

	SELECT
		s.store_id,
		c.city
	FROM 
		store s
		JOIN address a ON s.address_id = a.address_id
		JOIN city c ON a.city_id = c.city_id
);

CREATE VIEW vw_get_store_amount_and_city AS
(
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
	ORDER BY total_amount DESC
);

CREATE VIEW vw_get_city_with_more_clients AS
(
	-- Qual cidade possui mais clientes?

	SELECT
		c.city,
		COUNT(cs.customer_id) AS total_customers
	FROM
		customer cs
		JOIN address a ON cs.address_id = a.address_id
		JOIN city c ON a.city_id = c.city_id
	GROUP BY
		c.city
	ORDER BY
		total_customers
	DESC
);

CREATE VIEW vw_get_country_with_more_clients AS
(
	-- Qual país possui mais clientes?

	SELECT
		co.country,
		COUNT(cs.customer_id) AS total_customers
	FROM
		customer cs
		JOIN address a ON cs.address_id = a.address_id
		JOIN city c ON a.city_id = c.city_id
		JOIN country co ON c.country_id = co.country_id
	GROUP BY
		co.country
	ORDER BY
		total_customers
	DESC
);

CREATE VIEW vw_get_amount_per_city AS
(
	-- Qual o faturamento por cidade?

	SELECT
		c.city,
		SUM(p.amount) as total_amount
	FROM
		customer cs
		JOIN address a ON cs.address_id = a.address_id
		JOIN city c ON a.city_id = c.city_id
		JOIN payment p ON cs.customer_id = p.customer_id
	GROUP BY
		c.city
	ORDER BY
		total_amount
	DESC
);

CREATE VIEW vw_get_amount_per_country AS
(
	-- Qual o faturamento por país?

	SELECT
		co.country,
		SUM(p.amount) as total_amount
	FROM
		customer cs
		JOIN address a ON cs.address_id = a.address_id
		JOIN city c ON a.city_id = c.city_id
		JOIN country co ON c.country_id = co.country_id
		JOIN payment p ON cs.customer_id = p.customer_id
	GROUP BY
		co.country
	ORDER BY
		total_amount
	DESC
);

CREATE VIEW vw_get_rental_per_store_and_staff AS
(
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
	DESC
);

CREATE VIEW vw_get_amount_per_store_and_staff AS
(
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
	DESC
);

CREATE VIEW vw_get_popular_genders_per_countries AS
(
	-- Quais são os gêneros mais populares em diferentes países?

	WITH film_by_categories AS (
		SELECT
			f.film_id,
			f.title,
			c.category_id,
			c.name
		FROM
			film f
			JOIN film_category fc ON f.film_id = fc.film_id
			JOIN category c ON fc.category_id = c.category_id
	), customer_country_with_rental AS (
		SELECT 
			f.film_id,
			r.rental_id,
			c.customer_id,
			co.country_id,
			co.country
		FROM
			film f
			JOIN inventory i ON f.film_id = i.film_id
			JOIN rental r ON i.inventory_id = r.inventory_id
			JOIN customer c ON r.customer_id = c.customer_id
			JOIN address a ON c.address_id = a.address_id
			JOIN city ci ON a.city_id = ci.city_id
			JOIN country co ON ci.country_id = co.country_id
	), ranked_genres_by_country AS (
		SELECT
			ccwr.country,
			fbc.name AS genre,
			ROW_NUMBER() OVER (PARTITION BY country ORDER BY COUNT(*) DESC) AS genre_rank
		FROM
			film_by_categories fbc
			JOIN customer_country_with_rental ccwr ON fbc.film_id = ccwr.film_id
		GROUP BY
			country, name
	)
	SELECT
		country,
		genre
	FROM
		ranked_genres_by_country
	WHERE
		genre_rank = 1
);

CREATE VIEW vw_get_frequent_actors AS
(
	-- Quais atores estavam mais presentes nos filmes?

	SELECT
		a.first_name || ' ' || a.last_name AS full_name,
		COUNT(a.actor_id) as total_actor_appereances
	FROM 
		film f JOIN
		film_actor fa ON f.film_id = fa.film_id JOIN
		actor a ON fa.actor_id = a.actor_id
	GROUP BY
		full_name
	ORDER BY
		total_actor_appereances
	DESC
);

CREATE VIEW vw_get_higher_rating_film AS
(
	-- Qual o filme mais bem avaliado?

	SELECT
		title,
		rating
	FROM
		film
	ORDER BY
		rating
	DESC
);

CREATE VIEW vw_get_higher_duration_filme AS
(
	-- Qual o filme mais longo?

	SELECT
		title,
		length
	FROM
		film
	ORDER BY
		length
	DESC
);

CREATE VIEW vw_get_profitable_film AS
(
	-- Qual é o filme mais lucrativo?

	SELECT
		f.title,
		SUM(p.amount) total_amount
	FROM
		film f JOIN
		inventory i ON f.film_id = i.film_id JOIN
		rental r ON i.inventory_id = r.inventory_id JOIN
		payment p ON r.rental_id = p.rental_id
	GROUP BY
		f.title
	ORDER BY
		total_amount
	DESC
);

CREATE VIEW vw_get_avg_rental_amount AS
(
	-- Qual é a média de receita por aluguel?

	SELECT
		ROUND(AVG(amount), 2) mean_payment
	FROM
		payment
	ORDER BY
		mean_payment
	DESC
);

CREATE VIEW vw_get_higher_client_amount_and_total_rentals AS
(
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
);