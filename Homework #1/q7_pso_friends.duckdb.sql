-- Reference: https://piazza.com/class/ll5n5kglj76qh/post/157

SELECT DISTINCT(artist_2.name) AS artist_name

FROM (
    artist artist_1 JOIN 
        artist_credit_name acn_1 ON acn_1.artist = artist_1.id
)
INNER JOIN (
    artist artist_2 JOIN
        artist_credit_name acn_2 ON acn_2.artist = artist_2.id
) ON acn_1.artist_credit = acn_2.artist_credit AND
        acn_1.position != acn_2.position AND
        artist_1.name = 'Pittsburgh Symphony Orchestra'

ORDER BY artist_name ASC;