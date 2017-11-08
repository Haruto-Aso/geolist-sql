INSERT INTO users_working
SELECT *
FROM users u
WHERE (u.deleted = 0 OR u.deleted is null)
AND	u.username <> ''
AND 	u.username IS NOT NULL
AND 	u.login_enabled = 1
AND	u.id NOT IN (SELECT u2.id
						FROM	users u2,
								(SELECT u.username, COUNT(*) c
								FROM users u
								GROUP BY u.username
								HAVING c > 1
								ORDER BY c DESC) t
						WHERE u2.username = t.username
						AND (u2.deleted = 0 OR u2.deleted is null)
						AND	u2.username <> ''
						AND	u2.login_enabled = 1
						AND	u2.id NOT IN (37, 354, 531, 701, 1147, 1196)
						ORDER BY u2.username);
