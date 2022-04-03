
/* lesson 7
Тема “Сложные запросы”
Voronov Sergey */

-- 1
INSERT INTO orders(user_id) 
SELECT id FROM users WHERE name = 'Александр';

INSERT INTO orders(user_id) 
SELECT id FROM users WHERE name = 'Сергей';

INSERT INTO orders(user_id) 
SELECT id FROM users WHERE name = 'Мария';

SELECT u.name
FROM users AS u
JOIN orders AS o 
ON (o.user_id = u.id)
GROUP BY u.name
;

-- 2
INSERT INTO products VALUES
	(DEFAULT, 'AMD Ryzen', 'OEM с Али-экспресса', 8000, 1, DEFAULT, DEFAULT),
  	(DEFAULT, 'ST2000', 'Видеокарта китайского старпапа', 16000, 3, DEFAULT, DEFAULT),
  	(DEFAULT, 'Kingston', 'SSD 512GB', 4000, 4, DEFAULT, DEFAULT)
;

SELECT * FROM products; 

SELECT p.name, c.name
FROM products AS p
JOIN catalogs AS c 
ON (p.catalog_id = c.id)
GROUP BY p.id
;


