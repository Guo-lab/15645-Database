WITH NUM_COUNT AS (
    SELECT
        SUM(CASE WHEN release_info.date_year BETWEEN 1950 AND 1959 THEN 1 ELSE 0 END) AS total_num_releases_in_1950s,
        SUM(CASE WHEN release_info.date_year BETWEEN 2010 AND 2019 THEN 1 ELSE 0 END) AS total_num_releases_in_2010s
    FROM release_info
    WHERE release_info.date_year BETWEEN 1950 AND 2019
    ),

    INCR_COUNT AS (
        SELECT language.name AS language,
            SUM(CASE WHEN release_info.date_year BETWEEN 1950 AND 1959 THEN 1 ELSE 0 END) AS num_releases_in_1950s,
            SUM(CASE WHEN release_info.date_year BETWEEN 2010 AND 2019 THEN 1 ELSE 0 END) AS num_releases_in_2010s
        
        FROM language
        JOIN release ON language.id = release.language
        JOIN release_info ON release.id = release_info.release
        GROUP BY language.name
    )

SELECT language.name AS language,
    INCR_COUNT.num_releases_in_1950s,
    INCR_COUNT.num_releases_in_2010s
    -- ROUND(
    --     (INCR_COUNT.num_releases_in_2010s * 1.0 / NUM_COUNT.total_num_releases_in_2010s) - (INCR_COUNT.num_releases_in_1950s * 1.0 / NUM_COUNT.total_num_releases_in_1950s),
    --     3
    -- ) AS increase

FROM release
JOIN language ON language.id = release.language
JOIN release_info ON release.id = release_info.release
-- JOIN NUM_COUNT
JOIN INCR_COUNT ON language.name = INCR_COUNT.language

-- WHERE increase > 0

GROUP BY language.name;