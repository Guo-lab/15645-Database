SELECT artist.name AS artist_name,
    COUNT(artist_alias.id) AS num_aliases,
    GROUP_CONCAT(artist_alias.name, ',') AS comma_separated_list_of_aliases

FROM artist 
JOIN artist_alias ON artist.id = artist_alias.artist

WHERE artist.name LIKE '%John' AND
    artist_alias.name is NOT NULL AND
    LOWER(artist_alias.name) NOT LIKE '%john%' AND
    UPPER(artist_alias.name) NOT LIKE '%JOHN%'

GROUP BY artist.name