
# Ejercicio de Evaluación: Consultas SQL en la Base de Datos Sakila

## Descripción del Proyecto

Este ejercicio de evaluación consiste en realizar una serie de consultas SQL para resolver problemas relacionados con la base de datos **Sakila** 

## Estructura de la Base de Datos

**Sakila**
Sumérgete en el mundo del cine con Sakila, con la base de datos de un videoclub. 

¿Qué encontrarás aquí?

La base de datos **Sakila** contiene información sobre películas, actores, clientes, alquileres, pagos, y más. Algunas de las tablas principales incluyen:

- **customers**: Información sobre los clientes del videoclub
- **actor**: Información sobre los actores.
- **category**: Categorías de películas.
- **film**: Detalles de las películas.
- **film_category**: Información sobre las categorias de las películas
- **inventory**: Inventario de películas disponibles para alquiler.
- **rental**: Registros de alquileres realizados por los clientes.

## Objetivo

El objetivo principal de este ejercicio es poner en práctica las habilidades en SQL a través de una serie de consultas complejas sobre la base de datos **Sakila**. Al resolver estas consultas, podrás demostrar tu capacidad para:

Manipular datos: Extraer, filtrar y ordenar información relevante.
Unir tablas: Relacionar diferentes entidades para obtener resultados más completos.
Agrupar datos: Calcular estadísticas.


## Consultas Realizadas

Ejemplos de algunas consultas SQL realizadas :

1. **Peliculas con una duración mayor a 120 minutos:**
   - Se obtiene una lista con todas las películas que tengan una duración de más de dos horas, Mostrando el título de las películas 

   ```sql
   SELECT title AS Peliculas
   FROM film
   WHERE length >120;
   ```

2. **Nombres de todos los actores:**
   - Se identifican todos los actores de las películas.Se muestran los Nombres y Apellidos.

   ```sql
  SELECT DISTINCT first_name AS Nombre ,last_name AS Apellido 
  FROM actor;
  ```

3. **Actores que aparecen en la película 'Indian Love':**
   - Se identifican todos los actores que aparecen en la película 'Indian Love',se muestran los Nombres y Apellidos

   ```sql
  SELECT  a.first_name AS Nombre ,a.last_name AS Apellido 
  FROM actor a 
  INNER JOIN film_actor fa ON a.actor_id =fa.actor_id
  INNER JOIN film f ON f.film_id = fa.film_id
  WHERE f.title = 'Indian Love';
  ``` 

## Requisitos

Para ejecutar este ejercicio, es necesario tener MySQL instalado en tu sistema y acceder a la base de datos **Sakila**. 


## Instrucciones

1. Abre tu terminal MySQL 
2. Conéctate a la base de datos **Sakila**.
3. Ejecuta las consultas 

## Conclusiones

Este ejercicio permite consolidar los conocimientos adquiridos en la creación y ejecución de consultas SQL en bases de datos. 


## Repositorio y ejercicio realizado por Elena Alique Baumann
## Enero 2025

