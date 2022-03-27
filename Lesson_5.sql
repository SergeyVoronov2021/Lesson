/* Lesson 5.
Voronov Sergey*/

-- Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение"
-- 1
USE vk;
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
USE shop;

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

-- Практическое задание теме “Агрегация данных”
-- 1
/* Дни рождения находятся в таблице profiles*/

USE vk;
ALTER TABLE profiles
ADD age INT NOT NULL;

UPDATE profiles
SET age = TIMESTAMPDIFF(YEAR, birthday, NOW());

SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday, NOW())), 0)
AS AVG_Age FROM profiles;


-- 2
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday), DAY(birthday))), '%W') AS day,
COUNT(*) AS total
FROM profiles
GROUP BY day
ORDER BY total;

