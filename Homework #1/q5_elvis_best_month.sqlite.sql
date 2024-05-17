WITH MOST_RELEASE AS (
    SELECT artist.name AS artist_name, 
        release_info.date_month AS release_month, 
        COUNT(*) AS num_releases,
        ROW_NUMBER() OVER (PARTITION BY artist.name, release_info.date_month ORDER BY COUNT(*) DESC) AS rank,
        RANK() OVER (PARTITION BY artist.name, release_info.date_month ORDER BY release_info.date_year ASC) AS rank2

    FROM release
    JOIN artist_credit ON release.artist_credit = artist_credit.id
    JOIN artist_credit_name ON artist_credit.id = artist_credit_name.artist_credit
    JOIN artist ON artist_credit_name.artist = artist.id
    JOIN artist_type ON artist.type = artist_type.id
    JOIN (
        SELECT DISTINCT(release) as release, date_month, date_year
        FROM release_info
    ) AS release_info ON release.id = release_info.release

    WHERE artist_name LIKE 'Elvis%' AND
        artist_type.name = 'Person' AND
        release_info.date_month IS NOT NULL

    GROUP BY artist_name, 
        release_info.date_month
)
SELECT artist_name, release_month, MAX(num_releases) AS num_releases
FROM MOST_RELEASE
WHERE rank = 1 AND rank2 = 1
GROUP BY artist_name
ORDER BY num_releases DESC, 
    artist_name,
    release_month ASC;

