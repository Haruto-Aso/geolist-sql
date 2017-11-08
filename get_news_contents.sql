SELECT nw.id AS post_id, 
		nw.user_id AS post_author,
		nc2.title AS post_title,
		nc2.brief AS post_excerpt,
		nc2.content AS post_content,
		nc2.title AS post_name,
		nw.created AS post_date,
		nc2.modified AS post_modified,
		IF(nc2.image = '' OR nc2.image IS NULL, NULL, CONCAT('/wp-content/uploads/2017/07/', SUBSTR(nc2.image, 9))) AS featured_image,
		nc2.image_caption AS meta_image_caption,
		nc2.version_number AS meta_version_number,
		CONCAT('News', IF(nw.news_type = 'News','',CONCAT(' | ', nw.news_type)) , IF(nw.news_subcategory = '' OR nw.news_subcategory IS NULL, '', CONCAT(' | ', nw.news_subcategory)))  AS post_category,
		CONCAT('News', IF(nw.news_type = 'News','',CONCAT(', ', nw.news_type)) , IF(nw.news_subcategory = '' OR nw.news_subcategory IS NULL, '', CONCAT(', ', nw.news_subcategory)))  AS post_tag,
		nw.private AS meta_private,
		nw.members_news AS meta_member_news
FROM	newsarticles_working nw,
		newsarticle_contents nc2,
		users_working uu,
		(SELECT SUBSTR(t1.maxversion_id, 12) content_id
		FROM	(SELECT nc.news_id, MAX(CONCAT(LPAD(nc.version_number, 10, '0'), '_', nc.id)) maxversion_id
				FROM newsarticle_contents nc
				GROUP BY nc.news_id) t1) t2
WHERE nw.id = nc2.news_id
AND	t2.content_id = nc2.id
AND	nw.news_type <> ''
AND	uu.id = nw.user_id
AND	nc2.title IS NOT NULL
AND 	nc2.content IS NOT NULL
ORDER BY nw.user_id;
