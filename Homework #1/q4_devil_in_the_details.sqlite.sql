with rank_length as (
    select work_type.name as work_type, 
        work.name as work_name, 
        length(work.comment) as comment_length, 
        work.comment as comment,
        rank() over (partition by work.type order by length(work.comment) desc) as rank

    from work
    join work_type on work.type = work_type.id

    where work.comment is not null 
        and length(work.comment) > 0
)
select work_type, work_name, comment_length, comment
from rank_length
where rank = 1
order by work_type asc, work_name;

