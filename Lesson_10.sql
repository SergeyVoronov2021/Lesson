/* Lesson 10
 �������� ������
 DDL-�������;
 ���� ��
*/
 
DROP DATABASE IF EXISTS Wildberries;

CREATE DATABASE Wildberries;

SHOW DATABASES;

USE Wildberries;

/* �������� ��. Wildberries - ������ �������� ������ � ��������� � �������������� � ������������ ������� ������-�����, �������� ����� � ������. */

/*
 ������� �������:
 
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


-- ������ ������� ��������
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
	('MS-130 �������������� ����������������', 'ProAudio', '������������', 7886,'�������������� ���������������� 15 ��, 80-20000 ��, ���������������� 90 ��, 2-��������',
	'�������'),
	('������� MacBook Pro 16 i9-9880H', 'Apple', '��������', 319990,'MacBook Pro - ������ �������, ��������� ��� ���, ��� ������ ��� � ���������� �������.',
	'��� �����������'),
	('������� ������� ACER Predator XB273Pbmiprzx 27" ������', 'ACER', '��������', 89860,
	'������� Acer Predator XB273Pbmiprzx � ���������� ������ 27", ����������� 1920x1080 (Full HD) � ����� ������� IPS.','�� ����� �.�.'),
	('��������� ������������ ', 'Look', '����������', 431376,'875 MADISON RS Proteam Black Glossy',
	'�� ��������� �.�.'),
	('�������� �������', 'BastoM', '�������� � ����������', 4290,'����������� ���� 100%',
	'BASTOM GROUP'),
	('���������� ��������� ������� ����������� ���������� ���', '������', '����������', 1148,'�������� ����� AUS-8',
	'����������� ��������'),
	('������� ��� ������', 'MAXHUNTER', '����������', 7000,'˸����, ������� �������-�������� ������������ ��� ������ � �����������',
	'HantsMan')
;

ALTER TABLE products RENAME COLUMN manufacturers TO vendor;


-- �������� ���� ��������� � ��������
DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (
	product_id BIGINT UNSIGNED NOT NULL PRIMARY KEY,
	name VARCHAR(100) NOT NULL, 
	FOREIGN KEY(product_id) REFERENCES products(id)
);
	
	INSERT INTO catalogs VALUES (1, '�����������'),
	(2, '���'),
	(3, '��������'),
	(4, '��������'),
	(5, '�����'),
	(6, '�������'),
	(7, '�����'),
	(8, '�����')
;


-- ������ ������� ��������, �������
DROP TABLE IF EXISTS vendors;

CREATE TABLE vendors(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL UNIQUE, 
	types_of_products VARCHAR(255) NOT NULL,
	collections VARCHAR(100)
);

INSERT INTO vendors VALUES (DEFAULT,'ProAudio', '������������', NULL),
	(DEFAULT,'Primary', '������������', NULL),
	(DEFAULT,'Acer', '��������', NULL),
	(DEFAULT,'Apple', '��������', NULL),
	(DEFAULT,'Dell', '��������', NULL),
	(DEFAULT,'BenQ', '��������', NULL),
	(DEFAULT,'MAXHUNTER', '����������', NULL),
	(DEFAULT,'������', '����������', NULL)
;

ALTER TABLE vendors MODIFY COLUMN types_of_products VARCHAR(100);
ALTER TABLE vendors ADD COLUMN product VARCHAR(255);


-- ������ ���������
DROP TABLE IF EXISTS collections;

CREATE TABLE collections(
	id SERIAL PRIMARY KEY,
	name VARCHAR(100) NOT NULL, 
	description TEXT,
	product VARCHAR(255)
);

INSERT INTO collections  VALUES (DEFAULT,'����� 2022', '����� ��� ����� �����-���� 2022', '��������� SUPERFIT JUPITER'),
	(DEFAULT,'2022', '����� ��� ����� �����-���� 2022', '��������� JUMPER'),
	(DEFAULT,'Sokolov', '������� ���� �����', '��������� ������ SVOBODA'),
	(DEFAULT,'Sokolov', '������� ���� �����', '������ SVOBODA'),
	(DEFAULT,'Philips', '������� ��� �������� � �������', NULL)
;

SELECT * FROM collections;


-- ������ ������� ���������
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
 
INSERT INTO sellers VALUES (DEFAULT, '��� �����������', '������� MacBook Pro 16 i9-9880H', 'Apple', '��������', 319990, 5),
	(DEFAULT, '�� ����� �.�.', '������� ������� ACER Predator XB273Pbmiprzx 27" ������', 'Acer', '��������', 89860, 5),
	(DEFAULT, '�������', 'MS-130 �������������� ����������������', 'ProAudio', '������������', 7886, 4),
	(DEFAULT, '�������', 'MS-110 �������������� ����������������', 'ProAudio', '������������', 7250, 3)
;


-- ������ ������� �����������
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


-- ������ ������� �������
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


-- ������ ������� �������
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
	(4, '�� ���� �� ����', 3, 26, DEFAULT),
	(5, '��������', 5, 55, DEFAULT)
;


-- ������ �������� ��������
DROP TABLE IF EXISTS projects;
 
CREATE TABLE projects(
	id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(50) NOT NULL,
	name_article VARCHAR(150),
	article TEXT
);

INSERT INTO projects VALUES(DEFAULT,'��� � �����', '������ � ����� �� ������ �������',
	'��������� �������� ������ ������ ��������� ����������, ��� � ����� �� ������ ��������'),
	(DEFAULT,'��� � �����', '��� ������� �� ����� ����� �������� �������',
	'������� �� ���������, ��� ��������� ����������� ����� ���������� �����'),
	(DEFAULT,'�������� ������', '��������� ������ ����. 8 ���������� �� 1 �����',
	'���� ��� ���, ��� ����� ����� �����, �������� � ����� �� ������'
);


-- ������ ������ �������
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
