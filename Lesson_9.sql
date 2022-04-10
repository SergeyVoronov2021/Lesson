/* Lesson 9
Voronov Sergey */

-- Транзакции, переменные, представления
-- 1
START TRANSACTION;
INSERT INTO sample.users_tbl (name)
SELECT name
FROM shop.users
WHERE id = 1;
DELETE FROM shop.users WHERE id = 1;
COMMIT;

USE sample;
SELECT * FROM users_tbl;

USE shop;
SELECT * FROM users;


-- 2
USE shop;
CREATE VIEW name_and_type AS
SELECT p.name, c.name AS `type`
FROM products p
JOIN catalogs c 
WHERE p.catalog_id = c.id; 

SELECT * FROM name_and_type;


-- Хранимые процедуры и функции, триггеры
-- 1
DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //
delimiter ;

CALL hello();


-- 2
USE shop;
DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

-- checking
INSERT INTO products (name, desription, price, catalog_id)
VALUES (NULL, NULL, 4000, 2); 

INSERT INTO products (name, desription, price, catalog_id)
VALUES ("GeForce GTX 1080", NULL, 20000, 12); 

SELECT * FROM products;