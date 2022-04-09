/* ���� 8. ������� �������/
 ������������ ������� �� ���� ����������, ����������, ���������� � �����������. ��������� �������
Voronov Sergey */


-- 1 ����� ����� ��������� ������������. �� ���� ������������� ���. ���� ������� ��������, ������� ������ ���� ������� � ��������� ������������� (������� ��� ���������).
SELECT u.first_name, u.last_name 
FROM users u
JOIN messages m
WHERE m.from_user_id = u.id AND m.to_user_id = 5
GROUP BY u.first_name, u.last_name
ORDER BY COUNT(from_user_id) DESC
LIMIT 1;


-- 2 ���������� ����� ���������� ������, ������� �������� ������������ ������ 10 ���.
SELECT COUNT(*) '���������� ������'
FROM posts_likes l 
JOIN profiles p 
WHERE p.user_id = l.user_id AND TIMESTAMPDIFF(YEAR, p.birthday, NOW()) < 10;


-- 3 ���������� ��� ������ �������� ������ (�����): ������� ��� �������.
SELECT CASE (gender)
        WHEN 'm' THEN '�������'
        WHEN 'f' THEN '�������'
    	END AS '���', COUNT(*) as '�����'
FROM profiles p 
JOIN posts_likes l 
WHERE l.user_id = p.user_id
GROUP BY gender;