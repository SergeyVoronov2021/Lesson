/* 
Lesson 6
Практическое задание по теме “Операторы, фильтрация, сортировка и ограничение. Агрегация данных”.
Voronov Sergey
*/

 -- 1
SELECT from_user_id, COUNT(*) AS send 
FROM messages 
WHERE to_user_id=3
GROUP BY from_user_id
ORDER BY send DESC;

-- 2
SELECT COUNT(*) AS 'Лайки кол-во'
FROM posts_likes
WHERE user_id IN (
	SELECT user_id 
	FROM profiles
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

-- 3
SELECT 
    CASE(gender)
        WHEN 'm' THEN 'мужской'
        WHEN 'f' THEN 'женский'
        ELSE 'н.д.'
    END AS gender, COUNT(*) AS 'Кол-во:' 
   FROM profiles 
  GROUP BY gender;

