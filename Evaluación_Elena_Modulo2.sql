-- 1.Selecciona todos los nombres de las películas sin que aparezcan duplicados
SELECT  DISTINCT title AS Peliculas
FROM film;

-- 2.Muestra los nombres de todas las películas que tengan una clasificación de "PG-13"
SELECT title AS Peliculas
FROM film
WHERE rating = 'PG-13';

-- 3.Encuentra el título y la descripción de todas las películas que contengan la palabra "amazing" en su
-- descripción.
SELECT title AS Peliculas, description AS Descripcion
FROM film
WHERE description LIKE '%_amazing_%';

-- 4.Encuentra el título de todas las películas que tengan una duración mayor a 120 minutos.

SELECT title AS Peliculas
FROM film
WHERE length >120;

-- 5.Recupera los nombres de todos los actores

SELECT DISTINCT first_name AS Nombre ,last_name AS Apellido -- Distinct para posibles repetidos
FROM actor
ORDER BY first_name ASC;

-- 6. Encuentra el nombre y apellido de los actores que tengan "Gibson" en su apellido.
SELECT first_name AS Nombre, last_name AS Apellido
FROM actor
WHERE last_name LIKE '%Gibson%';

-- 7.Encuentra los nombres de los actores que tengan un actor_id entre 10 y 20.
SELECT first_name AS Nombre, last_name AS Apellido
FROM actor
WHERE actor_id BETWEEN 10 AND 20 ;

-- 8.Encuentra el título de las películas en la tabla film que no sean ni "R" ni "PG-13" en cuanto a su
-- clasificación.

SELECT title AS Pelicula
FROM film
WHERE rating NOT IN ('R','PG-13');

-- 9.Encuentra la cantidad total de películas en cada clasificación de la tabla film y muestra la
-- clasificación junto con el recuento.

SELECT rating AS clasificacion,COUNT(film_id) AS Cantidad_peliculas
FROM film
GROUP BY rating;

-- 10.Encuentra la cantidad total de películas alquiladas por cada cliente y muestra el ID del cliente, su
-- nombre y apellido junto con la cantidad de películas alquiladas

SELECT c.customer_id AS id_clientes, c.first_name AS Nombre, c.last_name AS Apellidos, COUNT(r.rental_id) AS Peliculas_alquiladas
FROM customer c
INNER JOIN rental r ON r.customer_id = c.customer_id
GROUP BY  c.customer_id, c.first_name, c.last_name;
-- Si utilizo un left join salen los mismos resultados por que no hay ningun cliente que haya alquilado 0 peliculas.

-- 11.Encuentra la cantidad total de películas alquiladas por categoría y muestra el nombre de la categoría
-- junto con el recuento de alquileres

SELECT c.name AS Nombre_categoria, COUNT(r.rental_id) AS Cantidad_peliculas_alquiladas
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN inventory i ON fc.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id 
GROUP BY c.name ;

-- 12.Encuentra el promedio de duración de las películas para cada clasificación de la tabla film y
-- muestra la clasificación junto con el promedio de duración.

SELECT rating AS clasificacion, AVG(length) AS Promedio_duraccion
FROM film
GROUP BY rating;

-- 13.Encuentra el nombre y apellido de los actores que aparecen en la película con title "Indian Love".
SELECT  a.first_name AS Nombre ,a.last_name AS Apellido 
FROM actor a 
INNER JOIN film_actor fa ON a.actor_id =fa.actor_id
INNER JOIN film f ON f.film_id = fa.film_id
WHERE f.title = 'Indian Love'
ORDER BY a.first_name ASC;

-- 14.Muestra el título de todas las películas que contengan la palabra "dog" o "cat" en su descripción.

SELECT DISTINCT title AS Titulo, description AS Descripcion
FROM film
WHERE description LIKE '%dog%' OR description LIKE '%cat%';
-- Muestro descrpcion para asegurar que aparece perro o gato en ella

-- 15.. Hay algún actor o actriz que no aparezca en ninguna película en la tabla film_actor
SELECT a.first_name AS Nombre, a.last_name AS Apellido
FROM actor a
LEFT JOIN film_actor fa ON a.actor_id = fa.actor_id
WHERE fa.film_id IS NULL;

-- 16.Encuentra el título de todas las películas que fueron lanzadas entre el año 2005 y 2010.
SELECT title AS Peliculas
FROM film
WHERE release_year BETWEEN 2005 AND 2010
ORDER BY title ASC;

-- 17.Encuentra el título de todas las películas que son de la misma categoría que "Family"

SELECT f.title AS Peliculas
FROM film f
INNER JOIN film_category fc  ON f.film_id= fc.film_id 
INNER JOIN category c ON c.category_id =  fc. category_id
WHERE c.name = 'Family' ; 

-- 18.Muestra el nombre y apellido de los actores que aparecen en más de 10 películas
SELECT a.first_name AS Nombre , a.last_name AS Apellido
FROM actor a
WHERE EXISTS (
SELECT a.first_name , a.last_name , COUNT(fa.film_id)
FROM actor a
INNER JOIN film_actor fa ON a.actor_id= fa.actor_id
GROUP BY a.first_name , a.last_name
HAVING COUNT(*)>10
) 
ORDER BY a.first_name ASC;

-- 19.Encuentra el título de todas las películas que son "R" y tienen una duración mayor a 2 horas en la
-- tabla film.
SELECT title AS Pelicula
FROM film
WHERE rating='R' AND length>120
ORDER BY title ASC;

-- 20.Encuentra las categorías de películas que tienen un promedio de duración superior a 120 minutos y
-- muestra el nombre de la categoría junto con el promedio de duración

SELECT c.name As Nombre, AVG(f.length) as Promedio_duracion
FROM category c
INNER JOIN film_category fc ON c.category_id = fc.category_id
INNER JOIN film f ON f. film_id = fc. film_id
GROUP BY  c.name 
HAVING AVG(f.length) > 120;

-- 21 Encuentra los actores que han actuado en al menos 5 películas y muestra el nombre del actor junto
-- con la cantidad de películas en las que han actuado.

SELECT a.first_name AS Nombre , a.last_name AS apellido, COUNT(fa.film_id) AS Cantidad_peliculas
FROM actor a
INNER JOIN film_actor fa ON a.actor_id= fa.actor_id
GROUP BY a.first_name, a.last_name 
HAVING COUNT(fa.film_id)>=5
ORDER BY COUNT(fa.film_id) ASC;

-- 22.Encuentra el título de todas las películas que fueron alquiladas por más de 5 días. Utiliza una
-- subconsulta para encontrar los rental_ids con una duración superior a 5 días y luego selecciona las
-- películas correspondientes.

SELECT DISTINCT f.title as Peliculas
FROM film f
INNER JOIN inventory i ON f.film_id = i.film_id
INNER JOIN rental r ON i.inventory_id = r.inventory_id
WHERE r.rental_id IN (
    SELECT rental_id
    FROM rental r
    WHERE DATEDIFF(return_date, rental_date) > 5
);
-- DATEDIFF funcion para calcular en dias la diferencia entre una fecha y otra.


-- 23.Encuentra el nombre y apellido de los actores que no han actuado en ninguna película de la categoría
-- "Horror". Utiliza una subconsulta para encontrar los actores que han actuado en películas de la
-- categoría "Horror" y luego exclúyelos de la lista de actores.

SELECT a.first_name AS Nombre , a.last_name AS Apellido
FROM actor a
WHERE a.actor_id NOT IN (
    SELECT DISTINCT fa.actor_id
    FROM film_actor fa
    INNER JOIN film_category fc  ON fa.film_id = fc.film_id
    INNER JOIN category c ON c.category_id = fc.category_id
    WHERE c.name = 'Horror'
    )
    ORDER BY a.first_name ASC


-- 24.Encuentra el título de las películas que son comedias y tienen una duración mayor a 180 minutos en
-- la tabla film.
SELECT f.title AS Pelicula
FROM film f
INNER JOIN film_category fc ON f.film_id = fc.film_id
INNER JOIN category c ON c.category_id = fc.category_id
WHERE name = 'Comedy'
AND length > 180;



 



