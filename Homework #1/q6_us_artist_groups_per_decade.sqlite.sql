SELECT CAST(artist.begin_date_year / 10 * 10 AS TEXT) || 's' AS decade,
    COUNT(artist.id) AS num_artist_group

FROM artist
JOIN artist_type ON artist.type = artist_type.id
JOIN area ON artist.area = area.id

WHERE artist_type.name = 'Group' AND
    artist.begin_date_year IS NOT NULL AND
    artist.begin_date_year >= 1900 AND
    artist.begin_date_year < 2030 AND
    area.name = 'United States'

GROUP BY decade
ORDER BY decade;