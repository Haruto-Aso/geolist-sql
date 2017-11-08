SELECT u.username user_login,
			u.email user_email,
			u.real_name nice_name,
			u.real_name display_name,
			u.website user_url,
			u.user_level_id,
			u.user_group_id,
			u.created_by,
			u.updated_by,
			u.deleted_by,
			u.member_no,
			u.company,
			u.address1,
			u.address2,
			u.address3,
			u.town,
			u.county,
			u.postcode,
			u.country,
			u.no_branches,
			u.head_office,
			u.head_office_id,
			u.telephone,
			u.description,
			u.bullet1,
			u.bullet2,
			u.bullet3,
			u.bullet4,
			u.bullet5,
			u.company_logo,
			u.lat,
			u.lon,
			u.national_company,
			u.national_company_coverage,
			u.trade,
			u.international,
			u.iframe_map,
			u.trustmark,
			u.parent_user,
			u.region_id,
			u.county_id
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
