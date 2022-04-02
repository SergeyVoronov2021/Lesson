/* 
Lesson 6
������������ ������� �� ���� ����������, ����������, ���������� � �����������. ��������� �������.
Voronov Sergey
*/

 -- 1
SELECT from_user_id, COUNT(*) AS send 
FROM messages 
WHERE to_user_id=3
GROUP BY from_user_id
ORDER BY send DESC;

-- 2
SELECT COUNT(*) AS '����� ���-��'
FROM posts_likes
WHERE user_id IN (
	SELECT user_id 
	FROM profiles
	WHERE TIMESTAMPDIFF(YEAR, birthday, NOW()) < 10);

-- 3
SELECT 
    CASE(gender)
        WHEN 'm' THEN '�������'
        WHEN 'f' THEN '�������'
        ELSE '�.�.'
    END AS gender, COUNT(*) AS '���-��:' 
   FROM profiles 
  GROUP BY gender;

