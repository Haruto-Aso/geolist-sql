SELECT T1.post_title, count(*) POST_COUNT
FROM
(SELECT '' post_id,
		u.company post_title,
		1 post_auth,
		CONCAT('<p>', u.description, '</p>',
				'<ul><li>', u.bullet1, '</li>',
				 '<li>', u.bullet2, '</li>',
				 '<li>', u.bullet3, '</li>',
				 '<li>', u.bullet4, '</li>',
				 '<li>', u.bullet5, '</li></ul>') post_content,
		GROUP_CONCAT(gs.title) post_category,
		'' post_tags,
		'gd_place' post_type,
		'publish' post_status,
		'' is_featured,
		'' geodir_video,
		CONCAT(u.address1, '', u.address2, '', u.address3) post_address,
		u.town post_city,
		(SELECT region_name FROM regions WHERE regions.id = u.region_id)  post_region,
		'United Kingdom' post_country, /*REPLACE(u.country, 'UK', 'United Kingdom') post_country,*/
		u.postcode post_zip,
		u.lat post_latitude,
		u.lon post_longitude,
		'' post_neighbourhood,
		'' neighbourhood_latitude,
		'' neighbourhood_longitude,
		'' geodir_timing,
		u.telephone geodir_contact,
		u.email geodir_email,
		u.website geodir_website,
		'' geodir_twitter,
		'' geodir_facebook,
		IF(u.company_logo = '' OR u.company_logo IS NULL, NULL, CONCAT('/wp-content/uploads/2017/07/', SUBSTR(u.company_logo, 9))) AS IMAGE
FROM 	users_working u,
		group_services gs,
		(SELECT gsi.user_id, gsi.group_service_id, COUNT(*)
		FROM group_services_installers gsi
		GROUP BY gsi.user_id, gsi.group_service_id) gsi
WHERE u.id = gsi.user_id
AND	gsi.group_service_id = gs.id
AND	u.company IS NOT NULL
GROUP BY u.id, u.company
ORDER BY u.id, u.company, gs.title) T1
GROUP BY T1.post_title
ORDER BY POST_COUNT DESC;
