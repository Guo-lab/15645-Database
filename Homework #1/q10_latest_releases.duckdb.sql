-- .output 'output_file.csv'
-- EXPLAIN
SELECT ANY_VALUE(artist.name) AS artist_name,
    ANY_VALUE(release.name) AS release_name,
    release_info.date_year AS release_year,
    -- release_info.date_month AS release_month,
    -- release_info.date_day AS release_day

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

GROUP BY release_info.date_year, release_info.date_month, release_info.date_day, 
    artist.id

ORDER BY artist_name ASC, 
    release_info.date_year DESC, 
    release_info.date_month DESC,
    release_info.date_day DESC;







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




-- ┌─────────────────────────────┐
-- │┌───────────────────────────┐│
-- ││       Physical Plan       ││
-- │└───────────────────────────┘│
-- └─────────────────────────────┘
-- ┌───────────────────────────┐                                                                                                                                                 
-- │         PROJECTION        │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │             #0            │                                                                                                                                                 
-- │             #1            │                                                                                                                                                 
-- │__internal_decompress_integ│                                                                                                                                                 
-- │     ral_bigint(#2, 1)     │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │          ORDER_BY         │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │          ORDERS:          │                                                                                                                                                 
-- │  any_value(artist."name") │                                                                                                                                                 
-- │             ASC           │                                                                                                                                                 
-- │release_info.date_year DESC│                                                                                                                                                 
-- │          #3 DESC          │                                                                                                                                                 
-- │          #4 DESC          │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │         PROJECTION        │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │             #0            │                                                                                                                                                 
-- │             #1            │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_usmallint(#2, 1)    │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_utinyint(#3, 1)     │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_utinyint(#4, 1)     │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │         PROJECTION        │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │        artist_name        │                                                                                                                                                 
-- │        release_name       │                                                                                                                                                 
-- │        release_year       │                                                                                                                                                 
-- │         date_month        │                                                                                                                                                 
-- │          date_day         │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │         PROJECTION        │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │__internal_decompress_integ│                                                                                                                                                 
-- │     ral_bigint(#0, 1)     │                                                                                                                                                 
-- │__internal_decompress_integ│                                                                                                                                                 
-- │     ral_bigint(#1, 1)     │                                                                                                                                                 
-- │__internal_decompress_integ│                                                                                                                                                 
-- │     ral_bigint(#2, 1)     │                                                                                                                                                 
-- │__internal_decompress_integ│                                                                                                                                                 
-- │     ral_bigint(#3, 1)     │                                                                                                                                                 
-- │             #4            │                                                                                                                                                 
-- │             #5            │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │       HASH_GROUP_BY       │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │             #0            │                                                                                                                                                 
-- │             #1            │                                                                                                                                                 
-- │             #2            │                                                                                                                                                 
-- │             #3            │                                                                                                                                                 
-- │       any_value(#4)       │                                                                                                                                                 
-- │       any_value(#5)       │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │         PROJECTION        │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │         date_year         │                                                                                                                                                 
-- │         date_month        │                                                                                                                                                 
-- │          date_day         │                                                                                                                                                 
-- │             id            │                                                                                                                                                 
-- │            name           │                                                                                                                                                 
-- │            name           │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │         PROJECTION        │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_uinteger(#0, 1)     │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_usmallint(#1, 1)    │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_utinyint(#2, 1)     │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_utinyint(#3, 1)     │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_uinteger(#4, 1)     │                                                                                                                                                 
-- │             #5            │                                                                                                                                                 
-- │__internal_compress_integra│                                                                                                                                                 
-- │     l_uinteger(#6, 1)     │                                                                                                                                                 
-- │             #7            │                                                                                                                                                 
-- └─────────────┬─────────────┘                                                                                                                                                                              
-- ┌─────────────┴─────────────┐                                                                                                                                                 
-- │         HASH_JOIN         │                                                                                                                                                 
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                                                 
-- │           INNER           │                                                                                                                                                 
-- │        release = id       ├──────────────┐                                                                                                                                  
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │                                                                                                                                  
-- │           EC: 25          │              │                                                                                                                                  
-- └─────────────┬─────────────┘              │                                                                                                                                                               
-- ┌─────────────┴─────────────┐┌─────────────┴─────────────┐                                                                                                                    
-- │           FILTER          ││         HASH_JOIN         │                                                                                                                    
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                                                    
-- │  (date_year IS NOT NULL)  ││           INNER           │                                                                                                                    
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││     artist_credit = id    ├──────────────┐                                                                                                     
-- │         EC: 743276        ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │                                                                                                     
-- │                           ││           EC: 86          │              │                                                                                                     
-- └─────────────┬─────────────┘└─────────────┬─────────────┘              │                                                                                                                                  
-- ┌─────────────┴─────────────┐┌─────────────┴─────────────┐┌─────────────┴─────────────┐                                                                                       
-- │         SEQ_SCAN          ││         SEQ_SCAN          ││         PROJECTION        │                                                                                       
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
-- │        release_info       ││          release          ││             #0            │                                                                                       
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││             #1            │                                                                                       
-- │          release          ││       artist_credit       ││             #3            │                                                                                       
-- │         date_year         ││             id            ││                           │                                                                                       
-- │         date_month        ││            name           ││                           │                                                                                       
-- │          date_day         ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │                                                                                       
-- │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││        EC: 2591062        ││                           │                                                                                       
-- │         EC: 743276        ││                           ││                           │                                                                                       
-- └───────────────────────────┘└───────────────────────────┘└─────────────┬─────────────┘                                                                                                                    
--                                                           ┌─────────────┴─────────────┐                                                                                       
--                                                           │           FILTER          │                                                                                       
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
--                                                           │      (id <= 2773778)      │                                                                                       
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
--                                                           │           EC: 59          │                                                                                       
--                                                           └─────────────┬─────────────┘                                                                                                                    
--                                                           ┌─────────────┴─────────────┐                                                                                       
--                                                           │         HASH_JOIN         │                                                                                       
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                                                       
--                                                           │           INNER           │                                                                                       
--                                                           │     id = artist_credit    ├──────────────┐                                                                        
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │              │                                                                        
--                                                           │           EC: 59          │              │                                                                        
--                                                           └─────────────┬─────────────┘              │                                                                                                     
--                                                           ┌─────────────┴─────────────┐┌─────────────┴─────────────┐                                                          
--                                                           │         SEQ_SCAN          ││         HASH_JOIN         │                                                          
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
--                                                           │       artist_credit       ││           INNER           │                                                          
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││        artist = id        │                                                          
--                                                           │             id            ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                                                          
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││          EC: 1856         ├──────────────┐                                           
--                                                           │Filters: artist_count=4 AND││                           │              │                                           
--                                                           │  artist_count IS NOT NULL ││                           │              │                                           
--                                                           │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │              │                                           
--                                                           │         EC: 56555         ││                           │              │                                           
--                                                           └───────────────────────────┘└─────────────┬─────────────┘              │                                                                        
--                                                                                        ┌─────────────┴─────────────┐┌─────────────┴─────────────┐                             
--                                                                                        │         SEQ_SCAN          ││         HASH_JOIN         │                             
--                                                                                        │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
--                                                                                        │     artist_credit_name    ││           INNER           │                             
--                                                                                        │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││        gender = id        │                             
--                                                                                        │           artist          ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ├──────────────┐              
--                                                                                        │       artist_credit       ││          EC: 3667         │              │              
--                                                                                        │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││                           │              │              
--                                                                                        │        EC: 3245936        ││                           │              │              
--                                                                                        └───────────────────────────┘└─────────────┬─────────────┘              │                                           
--                                                                                                                     ┌─────────────┴─────────────┐┌─────────────┴─────────────┐
--                                                                                                                     │           FILTER          ││         SEQ_SCAN          │
--                                                                                                                     │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
--                                                                                                                     │      (id <= 2019098)      ││           gender          │
--                                                                                                                     │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
--                                                                                                                     │          EC: 3667         ││             id            │
--                                                                                                                     │                           ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
--                                                                                                                     │                           ││Filters: name=Male AND name│
--                                                                                                                     │                           ││         IS NOT NULL       │
--                                                                                                                     │                           ││   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │
--                                                                                                                     │                           ││           EC: 1           │
--                                                                                                                     └─────────────┬─────────────┘└───────────────────────────┘                             
--                                                                                                                     ┌─────────────┴─────────────┐                             
--                                                                                                                     │         SEQ_SCAN          │                             
--                                                                                                                     │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
--                                                                                                                     │           artist          │                             
--                                                                                                                     │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
--                                                                                                                     │           gender          │                             
--                                                                                                                     │             id            │                             
--                                                                                                                     │            name           │                             
--                                                                                                                     │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
--                                                                                                                     │  Filters: begin_date_year │                             
--                                                                                                                     │=1991 AND begin_date_y...  │                             
--                                                                                                                     │          NOT NULL         │                             
--                                                                                                                     │   ─ ─ ─ ─ ─ ─ ─ ─ ─ ─ ─   │                             
--                                                                                                                     │          EC: 3667         │                             
--                                                                                                                     └───────────────────────────┘      