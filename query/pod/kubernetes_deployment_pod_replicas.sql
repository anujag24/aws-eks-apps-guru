select
  -- Required Columns
  uid as resource,
  case 
    when replicas > '3' then 'ok' 
    else 'alarm' 
  end as status,
  case
    when replicas > '3' then  name || ' has more than 3 replicas. Add atleast 3 replicas for high availability <a href="google.com">google</a>'
    else name || ' has less than 3 replicas'
  end as reason,
  -- Additional Dimensionss
  namespace || ' (namespace)'
from
  kubernetes_deployment;
