/* Lesson 5.
Voronov Sergey*/

-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение"
-- 1
USE shop;
ALTER TABLE users ADD COLUMN updated_at VARCHAR(10);

UPDATE users
SET created_at = NOW() AND updated_at = NOW();


-- 2
UPDATE users 
SET 
created_at = STR_TO_DATE(created_at, "%d.%m.%Y %k:%i"),
updated_at = STR_TO_DATE(updated_at, "%d.%m.%Y %k:%i");
    
ALTER TABLE users
	MODIFY COLUMN created_at DATETIME,
	MODIFY COLUMN updated_at DATETIME;

-- 3
DROP TABLE IF EXISTS storehouses_products;
CREATE TABLE storehouses_products (
id SERIAL PRIMARY KEY,
storehouse_id INT UNSIGNED,
product_id INT UNSIGNED,
value INT UNSIGNED,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP);

INSERT INTO
storehouses_products(storehouse_id, product_id, value)
VALUES
(1, 10, 10),
(2, 11, 15),
(3, 12, 2000),
(4, 13, 400),
(5, 14, 0),
(6, 15, 10);

SELECT * FROM storehouses_products
ORDER BY
value = 0,
value;

-- 4
SELECT id, name, birthday_at 
FROM users 
WHERE (birthday_at LIKE '%may%' OR birthday_at LIKE '%august%');

-- 5
SELECT * FROM catalogs
WHERE id IN (5, 1, 2)
ORDER BY FIND_IN_SET(id,'5,1,2');


-- Практическое задание теме “Агрегация данных”
-- 1
ALTER TABLE users
ADD age INT NOT NULL;

UPDATE users
SET age = TIMESTAMPDIFF(YEAR, birthday_at, NOW());

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0)
AS AVG_Age FROM users;


-- 2
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
COUNT(*) AS total
FROM users
GROUP BY day
ORDER BY total;

-- 3
SELECT ROUND(EXP(SUM(LOG(id))), 10)
FROM users;