WITH NUM_COUNT_1 AS (
    SELECT COUNT(*) AS total_num_releases_in_1950s
    FROM release_info
    WHERE release_info.date_year BETWEEN 1950 AND 1959
    ),
    NUM_COUNT_2 AS (
    SELECT COUNT(*) AS total_num_releases_in_2010s
    FROM release_info
    WHERE release_info.date_year BETWEEN 2010 AND 2019
    ),

    INCR_COUNT_1 AS (
        SELECT language.name AS language,
            COUNT(*) AS num_releases_in_1950s
        FROM language
        JOIN release ON language.id = release.language
        JOIN release_info ON release.id = release_info.release
        WHERE release_info.date_year BETWEEN 1950 AND 1959
        GROUP BY language.name
    ),
    INCR_COUNT_2 AS (
        SELECT language.name AS language,
            COUNT(*) AS num_releases_in_2010s
        FROM language
        JOIN release ON language.id = release.language
        JOIN release_info ON release.id = release_info.release
        WHERE release_info.date_year BETWEEN 2010 AND 2019
        GROUP BY language.name
    )

SELECT language.name AS language,
    num_releases_in_1950s,
    num_releases_in_2010s,
    ROUND(num_releases_in_2010s*1.0/total_num_releases_in_2010s - num_releases_in_1950s*1.0/total_num_releases_in_1950s, 3) AS increase

FROM release
JOIN language ON language.id = release.language
JOIN release_info ON release.id = release_info.release
JOIN NUM_COUNT_1 ON 1 = 1
JOIN NUM_COUNT_2 ON 1 = 1
JOIN INCR_COUNT_1 ON language.name = INCR_COUNT_1.language 
JOIN INCR_COUNT_2 ON language.name = INCR_COUNT_2.language

WHERE increase > 0
GROUP BY language.name
ORDER BY increase DESC
LIMIT 1;


-- Run Time: real 8.362 user 5.635574 sys 2.641830

-- <1> SUM would pause;
-- <2> How to deal with the language emergering in 2010s but not in 1950s?
-- <3> I have included the null language from 1950s, to 2010s.

