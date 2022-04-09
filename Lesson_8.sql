/* Урок 8. Сложные запросы/
 Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”
Voronov Sergey */


-- 1 Пусть задан некоторый пользователь. Из всех пользователей соц. сети найдите человека, который больше всех общался с выбранным пользователем (написал ему сообщений).
SELECT u.first_name, u.last_name 
FROM users u
JOIN messages m
WHERE m.from_user_id = u.id AND m.to_user_id = 5
GROUP BY u.first_name, u.last_name
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;


-- 2 Подсчитать общее количество лайков, которые получили пользователи младше 10 лет.
SELECT COUNT(*) 'Количество лайков'
FROM posts_likes l 
JOIN profiles p 
WHERE p.user_id = l.user_id AND TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10;


-- 3 Определить кто больше поставил лайков (всего): мужчины или женщины.
SELECT CASE (gender)
        WHEN 'm' THEN 'мужчины'
        WHEN 'f' THEN 'женщины'
    	END AS 'пол', COUNT(*) as 'лайки'
FROM profiles p 
JOIN posts_likes l 
WHERE l.user_id = p.user_id
GROUP BY gender;