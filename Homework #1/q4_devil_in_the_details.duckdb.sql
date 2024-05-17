select work_type.name as work_type, 
    ANY_VALUE(work.name) as work_name, 
    max(len(work.comment)) as comment_length, 
    ANY_VALUE(work.comment) as comment
from work_type
join work on work.type = work_type.id
where len(work.comment) > 0
group by work_type.name
order by work_type asc, work_name;


-- NOTES:
-- Comparison of the SQLite and DuckDB:
-- https://piazza.com/class/ll5n5kglj76qh/post/111
--
-- For Q4: 
-- DuckDB: Run Time (s): real 0.096 user 0.236648 sys 0.077023
-- SQLite: Run Time: real 0.312 user 0.169772 sys 0.066871
--