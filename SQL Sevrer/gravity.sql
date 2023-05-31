--Mostrar una lista de los libros con el autor e idiomas del libro
SELECT b.title AS book_title, a.author_name, bl.language_name
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id
JOIN book_language bl ON b.language_id = bl.language_id;

--Obtener la cantidad de compras que ha realizado un cliente
SELECT c.customer_id, c.first_name, c.last_name, COUNT(ol.book_id) AS cantidad
FROM customer c
JOIN cust_order o ON c.customer_id = o.customer_id
JOIN order_line ol ON o.order_id = ol.order_id
WHERE c.customer_id = 1
GROUP BY c.customer_id, c.first_name, c.last_name;

--Listar los 5 libros mas vendidos
SELECT TOP (5) b.book_id, b.title, COUNT(ol.book_id) AS sales_quantity
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
GROUP BY b.book_id, b.title
ORDER BY sales_quantity DESC

--Mostrar los paises donde se ha utilizado el tipo de envio Express
SELECT DISTINCT country.country_name
FROM cust_order
JOIN shipping_method ON cust_order.shipping_method_id = shipping_method.method_id
JOIN address ON cust_order.dest_address_id = address.address_id
JOIN country ON address.country_id = country.country_id
WHERE shipping_method.method_name = 'Express';

--Mostrar los libros que sus ordenes se han cancelado
SELECT b.book_id, b.title
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
JOIN cust_order o ON ol.order_id = o.order_id
JOIN order_history oo ON o.order_id = oo.order_id
JOIN order_status os ON oo.status_id = os.status_id
WHERE os.status_value = 'Cancelled';

--Mostrar el pais donde tiene mas influencia cada autor de libro
SELECT a.author_id, a.author_name, c.country_name, COUNT(DISTINCT o.order_id) AS order_count
FROM author a
JOIN book_author ba ON a.author_id = ba.author_id
JOIN book b ON ba.book_id = b.book_id
JOIN order_line ol ON b.book_id = ol.book_id
JOIN cust_order o ON ol.order_id = o.order_id
JOIN address ad ON o.dest_address_id = ad.address_id
JOIN country c ON ad.country_id = c.country_id
GROUP BY a.author_id, a.author_name, c.country_name
HAVING COUNT(DISTINCT o.order_id) = (
    SELECT MAX(order_count)
    FROM (
        SELECT a.author_id, COUNT(DISTINCT o.order_id) AS order_count
        FROM author a
        JOIN book_author ba ON a.author_id = ba.author_id
        JOIN book b ON ba.book_id = b.book_id
        JOIN order_line ol ON b.book_id = ol.book_id
        JOIN cust_order o ON ol.order_id = o.order_id
        GROUP BY a.author_id
    ) AS author_orders
    WHERE author_orders.author_id = a.author_id
)
ORDER BY a.author_id;

--Mostrar los clientes que han retornado o devuelto libros
SELECT b.book_id, b.title, c.customer_id, c.first_name, c.last_name
FROM book b
JOIN order_line ol ON b.book_id = ol.book_id
JOIN cust_order o ON ol.order_id = o.order_id
JOIN order_history oo ON o.order_id = oo.order_id
JOIN order_status os ON oo.status_id = os.status_id
JOIN customer c ON o.customer_id = c.customer_id
WHERE os.status_value = 'Returned';

--Mostrar la cantidad de libros y el titulo del libro que se han entregado satisfactoriamente


--Mostrar la lista de los clientes mas frecuentes


--Mostrar el mes en el que mas pedidos de libros se realizan