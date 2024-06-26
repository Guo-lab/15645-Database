select release.name as release_name, 
    min(release_info.date_year) as release_year
from release
join release_info on release.id = release_info.release
join medium on release.id = medium.release
join medium_format on medium.format = medium_format.id
join artist_credit on release.artist_credit = artist_credit.id
join artist_credit_name on artist_credit.id = artist_credit_name.artist_credit
join artist on artist_credit_name.artist = artist.id
join area on area.id = artist.area and area.id = release_info.area
where 
    medium_format.name = '12" Vinyl' 
    and area.name = 'United Kingdom'
    and artist_credit_name.name = 'The Beatles'
    and release_info.date_year is not null
        and release_info.date_year < artist.end_date_year 
group by release_name
order by release_year, release_name;


-- SELECT DISTINCT release.name AS release_name, MIN(release_info.date_year) AS release_year
-- FROM release
-- JOIN release_info ON release.id = release_info.release
-- JOIN medium ON release.id = medium.release
-- JOIN medium_format ON medium.format = medium_format.id
-- WHERE medium_format.name = '12" Vinyl' AND release_info.date_year IS NOT NULL
-- GROUP BY release.name
-- HAVING release_year = MIN(release_info.date_year)
-- ORDER BY release_year, release_name
-- LIMIT 10;