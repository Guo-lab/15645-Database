-- SELECT artist.name AS artist_name,
--     release.name AS release_name,
--     release_info.date_year AS release_year

-- FROM artist
-- JOIN gender ON artist.gender = gender.id
-- JOIN artist_credit_name ON artist.id = artist_credit_name.artist
-- JOIN artist_credit ON artist_credit_name.artist_credit = artist_credit.id
-- JOIN release ON artist_credit.id = release.artist_credit
-- JOIN release_info ON release.id = release_info.release

-- WHERE artist.begin_date_year = 1991 AND
--     gender.name = 'Male' AND
--     release_info.date_year IS NOT NULL

-- ORDER BY artist_name ASC, 
--     release_info.date_year DESC, 
--     release_info.date_month DESC,
--     release_info.date_day DESC;


SELECT artist.name AS artist_name,
    release.name AS release_name,
    release_info.date_year AS release_year

FROM artist
JOIN gender ON artist.gender = gender.id
JOIN artist_credit_name ON artist.id = artist_credit_name.artist
JOIN artist_credit ON artist_credit_name.artist_credit = artist_credit.id
JOIN release ON artist_credit.id = release.artist_credit
JOIN release_info ON release.id = release_info.release

WHERE artist.begin_date_year = 1991 AND
    gender.name = 'Male' AND
    release_info.date_year IS NOT NULL AND
    artist_credit.artist_count = 4

GROUP BY release_info.date_year, release_info.date_month, release_info.date_day

ORDER BY artist_name ASC, 
    release_info.date_year DESC, 
    release_info.date_month DESC,
    release_info.date_day DESC;
