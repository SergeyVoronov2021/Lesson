/* Lesson 10
 Курсовая работа
 DDL-команды;
 Дамп БД
*/
 
DROP DATABASE IF EXISTS Wildberries;

CREATE DATABASE Wildberries;

SHOW DATABASES;

USE Wildberries;

/* Описание БД. Wildberries - модель хранения данных о продукции и производителях с возможностью сделать онлайн-заказ, оставить отзыв и оценку. */

/*
 Создаем таблицы:
 
  1.products
 - id product
 - product
 - vendor
 - types_of_products
 - price
 - evaluations
 - description
 - seller
 - reviews
 
 2.catalogs
 - id
 - name categories

 3.vendor
 - id 
 - name
 - name types_of_products
 - collections
 
 4.collections
 - id collections
 - name 
 - description
 - product

 5.seller
 - id seller
 - name
 - product
 - types_of_products
 - vendor
 - price
 - evaluations
 
 6.buyer
 - id buyer
 - firstname
 - lastname
 - phone
 - email
 - gender
 
 7.orders
 - id orders
 - id buyer
 - created

 8.reviews
 - id
 - buyer
 - text of review
 - photo
 - date
 
 9. projects
 - id
 - name
 - article
 
 10.accounts
 - id
 - discount
 - orders
 */


-- создаю таблицу продукта
DROP TABLE IF EXISTS products;

CREATE TABLE products (
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	product VARCHAR(255) NOT NULL,
	manufacturers VARCHAR(100) NOT NULL,
 	types_of_products VARCHAR(255) NOT NULL,
 	price BIGINT UNSIGNED NOT NULL,
 	evaluations CHAR(1),
	description TEXT,
	seller VARCHAR(100) NOT NULL,
	reviews VARCHAR(255),
	INDEX (product) 
);

INSERT INTO products(product, manufacturers, types_of_products, price, description, seller)
VALUES 
	('MS-130 Трансляционный громкоговоритель', 'ProAudio', 'Аудиотехника', 7886,'Трансляционный громкоговоритель 15 Вт, 80-20000 Гц, чувствительность 90 дБ, 2-полосный',
	'Музмарт'),
	('Ноутбук MacBook Pro 16 i9-9880H', 'Apple', 'Ноутбуки', 319990,'MacBook Pro - мощный ноутбук, созданный для тех, кто меняет мир и раздвигает границы.',
	'ООО ВАЙЛДБЕРРИЗ'),
	('Монитор игровой ACER Predator XB273Pbmiprzx 27" черный', 'ACER', 'Мониторы', 89860,
	'Монитор Acer Predator XB273Pbmiprzx с диагональю экрана 27", разрешением 1920x1080 (Full HD) и типом матрицы IPS.','ИП Лобас С.Ю.'),
	('Велосипед двухколесный ', 'Look', 'Велосипеды', 431376,'875 MADISON RS Proteam Black Glossy',
	'ИП Самсонова И.С.'),
	('Мокасины мужские', 'BastoM', 'Мокасины и топсайдеры', 4290,'натуральная кожа 100%',
	'BASTOM GROUP'),
	('Кизлярский охотничий военный тактический раскладной нож', 'Кизляр', 'Снаряжение', 1148,'японская сталь AUS-8',
	'Гипермаркет матрасов'),
	('Арбалет для отдыха', 'MAXHUNTER', 'Снаряжение', 7000,'Лёгкий, надёжный арбалет-пистолет предназначен для отдыха и развлечений',
	'HantsMan')
;

ALTER TABLE products RENAME COLUMN manufacturers TO vendor;


-- продукты надо упаковать в каталоги
DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (
	product_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL, 
	FOREIGN KEY(product_id) REFERENCES products(id)
);
	
	INSERT INTO catalogs VALUES (1, 'Электроника'),
	(2, 'Дом'),
	(3, 'Мужчинам'),
	(4, 'Женщинам'),
	(5, 'Обувь'),
	(6, 'Красота'),
	(7, 'Спорт'),
	(8, 'Детям')
;


-- создаю таблицу вендоров, брендов
DROP TABLE IF EXISTS vendors;

CREATE TABLE vendors(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE, 
	types_of_products VARCHAR(255) NOT NULL,
	collections VARCHAR(100)
);

INSERT INTO vendors VALUES (DEFAULT,'ProAudio', 'Аудиотехника', NULL),
	(DEFAULT,'Primary', 'Аудиотехника', NULL),
	(DEFAULT,'Acer', 'Ноутбуки', NULL),
	(DEFAULT,'Apple', 'Ноутбуки', NULL),
	(DEFAULT,'Dell', 'Мониторы', NULL),
	(DEFAULT,'BenQ', 'Мониторы', NULL),
	(DEFAULT,'MAXHUNTER', 'Снаряжение', NULL),
	(DEFAULT,'Кизляр', 'Снаряжение', NULL)
;

ALTER TABLE vendors MODIFY COLUMN types_of_products VARCHAR(100);
ALTER TABLE vendors ADD COLUMN product VARCHAR(255);


-- создаю коллекции
DROP TABLE IF EXISTS collections;

CREATE TABLE collections(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL, 
	description TEXT,
	product VARCHAR(255)
);

INSERT INTO collections  VALUES (DEFAULT,'Весна 2022', 'Обувь для детей Весна-Лето 2022', 'Кроссовки SUPERFIT JUPITER'),
	(DEFAULT,'2022', 'Обувь для детей Весна-Лето 2022', 'Кроссовки JUMPER'),
	(DEFAULT,'Sokolov', 'Новинки этой весны', 'Ювелирные серьги SVOBODA'),
	(DEFAULT,'Sokolov', 'Новинки этой весны', 'Кольцо SVOBODA'),
	(DEFAULT,'Philips', 'Техника для здоровья и красоты', NULL)
;

SELECT * FROM collections;


-- создаю таблицу продавцов
DROP TABLE IF EXISTS sellers;

CREATE TABLE sellers(
	 id SERIAL PRIMARY KEY,
	 name VARCHAR(100) NOT NULL, 
	 product VARCHAR(255),
	 vendor VARCHAR(100) NOT NULL,
	 types_of_products VARCHAR(255) NOT NULL,
	 price BIGINT UNSIGNED NOT NULL,
	 evaluations CHAR(1)
 );
 
INSERT INTO sellers VALUES (DEFAULT, 'ООО ВАЙЛДБЕРРИЗ', 'Ноутбук MacBook Pro 16 i9-9880H', 'Apple', 'Ноутбуки', 319990, 5),
	(DEFAULT, 'ИП Лобас С.Ю.', 'Монитор игровой ACER Predator XB273Pbmiprzx 27" черный', 'Acer', 'Мониторы', 89860, 5),
	(DEFAULT, 'Музторг', 'MS-130 Трансляционный громкоговоритель', 'ProAudio', 'Аудиотехника', 7886, 4),
	(DEFAULT, 'Музторг', 'MS-110 Трансляционный громкоговоритель', 'ProAudio', 'Аудиотехника', 7250, 3)
;


-- создаю таблицу покупателей
DROP TABLE IF EXISTS buyers;

CREATE TABLE buyers(
	id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	first_name VARCHAR(145) NOT NULL,
	last_name VARCHAR(145) NOT NULL,
	email VARCHAR(145) NOT NULL UNIQUE,
	phone CHAR(11) NOT NULL,
	gender ENUM('f', 'm')
);
 
INSERT INTO buyers VALUES(DEFAULT, 'Ivan', 'Ivanov', 'ivanov@bk.ru', 8911150474, 'm'),
	(DEFAULT, 'Ilon', 'Mask', 'Ilon@mask.com', 8911150478, 'm'),
	(DEFAULT, 'Maria', 'Ivanova', 'ivanova@bk.ru', 8911150487, 'f'),
	(DEFAULT, 'Vladimir', 'Putin', 'putin@cremlin.ru', 8911150444, 'm'),
	(DEFAULT, 'Valentina', 'Matvienko', 'matvienkov@cremlin.ru', 8911150514, 'f')
;


-- создаю таблицу заказов
DROP TABLE IF EXISTS orders;

CREATE TABLE orders(
	orders_id BIGINT UNSIGNED NOT NULL,
	buyer_id BIGINT UNSIGNED NOT NULL,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(orders_id, buyer_id),
	KEY (orders_id),
	KEY (buyer_id),
	FOREIGN KEY (orders_id) REFERENCES products (id),
	FOREIGN KEY (buyer_id) REFERENCES buyers(id)
);

INSERT INTO orders VALUES(1, 1, DEFAULT),
	(2, 1, DEFAULT),
	(3, 2, DEFAULT),
	(4, 3, DEFAULT),
	(5, 5, DEFAULT),
	(6, 5, DEFAULT)
;

ALTER TABLE orders ADD COLUMN delivery DATETIME;


-- создаю таблицу отзывов
DROP TABLE IF EXISTS reviews;

CREATE TABLE reviews(
	review_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	review TEXT,
	evaluations CHAR(1),
	photo_id INT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (review_id) REFERENCES buyers(id)
);

INSERT INTO reviews VALUES(1, 'Super!', 5, 21, DEFAULT),
	(2, 'Terrable', 2, 22, DEFAULT),
	(3, 'Not bad', 4, 25, DEFAULT),
	(4, 'Ни рыба не мясо', 3, 26, DEFAULT),
	(5, 'Заебитлз', 5, 55, DEFAULT)
;


-- создаю перечень проектов
DROP TABLE IF EXISTS projects;
 
CREATE TABLE projects(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	name_article VARCHAR(150),
	article TEXT
);

INSERT INTO projects VALUES(DEFAULT,'ЗОЖ и спорт', 'Почему у зебры не бывает стресса',
	'Известный культово модный Роберт Сапольски утверждает, что у зебры не бывает стрессов'),
	(DEFAULT,'ЗОЖ и спорт', 'Как сделать из белой глины полезный напиток',
	'Сегодня мы расскажем, как правильно употреблять белую каолиновую глину'),
	(DEFAULT,'Цифровые товары', 'Видеокурс Стрейч Йога. 8 тренировок на 1 месяц',
	'Курс для тех, кто хочет стать гибче, стройнее и сесть на шпагат'
);


-- создаю личный кабинет
DROP TABLE IF EXISTS accounts;
 
CREATE TABLE accounts(
	account_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	discount INT UNSIGNED,
	orders INT UNSIGNED,
	created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (account_id) REFERENCES buyers(id)
);

INSERT INTO accounts VALUES 
	(1, 15, 1, DEFAULT),
	(2, 20, 2, DEFAULT),
	(3, 20, 2, DEFAULT),
	(4, 10, 3, DEFAULT),
	(5, 10, 3, DEFAULT)
;

ALTER TABLE accounts ADD COLUMN delivery DATETIME;

SELECT * FROM accounts;
