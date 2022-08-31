with default_limit_range as (
  select
    namespace,
    l -> 'default' -> 'cpu' as cpu_default_limit
    from
    kubernetes_limit_range,
    jsonb_array_elements(spec_limits) as l
    where 
    l -> 'default' -> 'cpu' is not null
)
select
  -- Required Columns
  n.uid as resource,
  case
    when cpu_default_limit is null then 'alarm'
    else 'ok'
  end as status,
  case
    when cpu_default_limit is null then n.name || 'namespace does not have default CPU LimitRange applied.'
    else n.name || 'namespace has default CPU LimitRange applied.'
  end as reason,
  -- Additional Dimensions
  n.context_name
from
  kubernetes_namespace n
  left join default_limit_range r
  on n.name = r.namespace;