select work_type.name as work_type, 
    work.name as work_name, 
    max(length(work.comment)) as comment_length, 
    work.comment as comment
from work
join work_type on work.type = work_type.id
where work.comment is not null and length(work.comment) > 0
group by work.type
order by work_type asc, work_name;