/* lesson 3*/

/* Написать крипт, добавляющий в БД vk, которую создали на занятии, 3 новые таблицы */

SHOW DATABASES;

USE vk;

-- создаем категории обьявлений
CREATE TABLE ads_categories(
category_id SERIAL PRIMARY KEY,
category_name VARCHAR(255) UNIQUE,
created_ad DATETIME DEFAULT NOW()
);
  
  INSERT INTO ads_categories VALUES (DEFAULT, 'foods', DEFAULT);
  INSERT INTO ads_categories VALUES (DEFAULT, 'electronics', DEFAULT);
  
  SELECT * FROM ads_categories;
  
  -- создаем форму обьявлений 
  CREATE TABLE ads(
id SERIAL PRIMARY KEY,
user_id BIGINT UNSIGNED NOT NULL,
name VARCHAR(255),
description TEXT,
created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
FOREIGN KEY(user_id) REFERENCES users(id)
);

INSERT INTO ads VALUES (DEFAULT, 1, 'Sale of an amplifier', 'tube amplifier 2X20W', DEFAULT);
INSERT INTO ads VALUES (DEFAULT, 2, 'I''ll buy', 'I''ll buy stew, buckwheat and cartridges', DEFAULT);

SELECT * FROM ads;

-- статус автора обьявления
CREATE TABLE author_status(
author_id SERIAL PRIMARY KEY NOT NULL,
author_status ENUM ('online', 'offline'),
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
FOREIGN KEY (author_id) REFERENCES users(id)
);

INSERT INTO author_status VALUES (DEFAULT,'online', DEFAULT, DEFAULT);
INSERT INTO author_status VALUES (DEFAULT,'offline', DEFAULT, DEFAULT);

SELECT * FROM author_status;
