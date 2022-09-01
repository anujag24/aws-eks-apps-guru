select
  -- Required Columns
  uid as resource,
  case
    when automount_service_account_token then 'alarm'
    else 'ok'
  end as status,
  case
    when automount_service_account_token then 'Pod service account token on '|| name ||' will be automatically mounted.'
    else 'Pod service account token '|| name ||' will not be automatically mounted.'
  end as reason,
  -- Additional Dimensions
  name || ' (pod name) on ' || context_name || ' (cluster name)'
from
  kubernetes_pod;