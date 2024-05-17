SELECT artist.name AS artist_name, 
    release_info.date_month AS release_month, 
    COUNT(*) AS num_releases

FROM release
JOIN artist_credit ON 
    release.artist_credit = artist_credit.id
JOIN artist_credit_name ON 
    artist_credit.id = artist_credit_name.artist_credit
JOIN artist ON 
    artist_credit_name.artist = artist.id
JOIN artist_type ON 
    artist.type = artist_type.id
JOIN release_info ON 
    release.id = release_info.release

WHERE artist_name LIKE 'Elvis%' AND
    artist_type.name = 'Person' AND
    release_info.date_month IS NOT NULL

GROUP BY artist_name, 
    release_info.date_month

ORDER BY num_releases DESC, 
    artist_name;


-- SELECT artist.name AS artist_name, 
--     release_info.date_month AS release_month,
--     release_info.release AS release_id, 
--     release_info.area AS release_area
-- FROM release
-- JOIN artist_credit ON 
--     release.artist_credit = artist_credit.id
-- JOIN artist_credit_name ON 
--     artist_credit.id = artist_credit_name.artist_credit
-- JOIN artist ON 
--     artist_credit_name.artist = artist.id
-- JOIN artist_type ON 
--     artist.type = artist_type.id
-- JOIN release_info ON 
--     release.id = release_info.release

-- WHERE artist_name LIKE 'Elvis%' AND
--     artist_type.name = 'Person' AND
--     release_info.date_month IS NOT NULL

-- ORDER BY artist_name;
