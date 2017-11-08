SELECT u.id,
		u.company,
		GROUP_CONCAT(gs.title) post_category,
		COUNT(gs.id)
FROM 	users_working u,
		group_services gs,
		(SELECT gsi.user_id, gsi.group_service_id, COUNT(*)
		FROM group_services_installers gsi
		GROUP BY gsi.user_id, gsi.group_service_id) gsi
WHERE u.id = gsi.user_id
AND	gsi.group_service_id = gs.id
AND	u.company IS NOT NULL
GROUP BY u.id, u.company
ORDER BY u.id, u.company, gs.title;
