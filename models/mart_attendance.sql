with attended as (
    select s.session_id, r.learner_id, sum(s.duration_seconds) as duration_seconds
    from {{ ref('stg_zoom_attendance') }} s
    join {{ ref('learner_roster') }} r on s.display_alias = lower(trim(r.display_alias))
    group by s.session_id, r.learner_id
)

select
    r.learner_id || ':' || s.session_id as attendance_key,
    r.learner_id,
    s.session_id,
    case when a.learner_id is null then 'Absent' else 'Attended' end as attendance_status,
    coalesce(a.duration_seconds, 0) as duration_seconds
from {{ ref('learner_roster') }} r
cross join {{ ref('meeting_sessions') }} s
left join attended a on a.learner_id = r.learner_id and a.session_id = s.session_id
