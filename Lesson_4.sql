/* lesson 4
Voronov Sergey */

USE vk;

/* Заполнить все таблицы БД vk данными (не больше 10-20 записей в каждой таблице).
Заполнил. */


/* II. Написать скрипт, возвращающий список имен (только firstname) пользователей без повторений в алфавитном порядке */
SELECT DISTINCT first_name 
FROM users;

/* III. Написать скрипт, отмечающий несовершеннолетних пользователей как неактивных (поле is_active = false).
 Предварительно добавить такое поле в таблицу profiles со значением по умолчанию = true (или 1)*/
 
 ALTER TABLE profiles 
 ADD is_active BOOL DEFAULT true;
 
UPDATE profiles
SET is_active = false
WHERE (YEAR(CURRENT_DATE) - YEAR(birthday)) < 18;


/* IV. Написать скрипт, удаляющий сообщения «из будущего» (дата больше сегодняшней)*/

UPDATE messages
SET created_at='2022-09-25 14:42:53'
WHERE id = 7;

DELETE FROM messages
WHERE created_at > NOW();


