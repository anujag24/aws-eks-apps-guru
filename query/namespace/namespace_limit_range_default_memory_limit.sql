with default_limit_range as (
  select
    namespace,
    l -> 'default' -> 'memory' as memory_default_limit
    from
    kubernetes_limit_range,
    jsonb_array_elements(spec_limits) as l
    where l -> 'default' -> 'memory' is not null
)
select
  -- Required Columns
  n.uid as resource,
  case
    when memory_default_limit is null then 'alarm'
    else 'ok'
  end as status,
  case
    when memory_default_limit is null then n.name || ' do not have LimitRange default memory limit.'
    else n.name || ' has LimitRange default memory limit.'
  end as reason,
  -- Additional Dimensions
  n.context_name
from
  kubernetes_namespace n
  left join default_limit_range r
  on n.name = r.namespace;