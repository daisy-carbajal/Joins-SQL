--Mostrar la lista de juegos con el genero

SELECT game.game_name, genre.genre_name
FROM dbo.game
JOIN dbo.genre ON game.genre_id = genre.id;

--Mostrar la lista de juegos que tiene cada Plataforma
SELECT game.game_name, platform.platform_name
FROM dbo.game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.id = game_platform.game_publisher_id
JOIN dbo.platform ON game_platform.platform_id = platform.id;

--Mostrar los juegos lanzados antes del año 2000
SELECT game.game_name, game_platform.release_year
FROM dbo.game
JOIN dbo.game_publisher ON game.id = game_publisher.game_id
JOIN dbo.game_platform ON game_publisher.publisher_id = game_platform.game_publisher_id
WHERE game_platform.release_year < 2000;

--Mostrar los juegos mas vendidos en Europa
--Mostrar los juegos con ventas menores al 0.5 de la plataforma Wii durante la decada del 2000
--Mostrar la lista de juegos de PlayStation
--Cuales son los 5 generos de juego que mas se venden en Europa
--Que editores tienen mejor presencia en el mercado de ventas de Norte America
--Que editor genera mas juegos de accion
--Cantidad de juegos de estrategia desarrollados por Microsof