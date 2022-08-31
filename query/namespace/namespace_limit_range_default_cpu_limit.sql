with default_limit_range as (
  select
    namespace,
    l -> 'default' -> 'cpu' as cpu_default_limit
    from
    kubernetes_limit_range,
    jsonb_array_elements(spec_limits) as l
    where l -> 'default' -> 'cpu' is not null
)
select
  -- Required Columns
  n.uid as resource,
  case
    when cpu_default_limit is null then 'alarm'
    else 'ok'
  end as status,
  case
    when cpu_default_limit is null then n.name || ' do not have LimitRange default CPU limit.'
    else n.name || ' has LimitRange default CPU limit.'
  end as reason,
  -- Additional Dimensions
  n.context_name
from
  kubernetes_namespace n
  left join default_limit_range r
  on n.name = r.namespace;