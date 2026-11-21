with ranked as (
    select
        session_id,
        lower(trim(display_name)) as display_alias,
        duration_seconds,
        row_number() over (
            partition by session_id, lower(trim(display_name)), joined_at
            order by load_order desc
        ) as row_num
    from {{ ref('zoom_export') }}
)

select session_id, display_alias, duration_seconds
from ranked
where row_num = 1
