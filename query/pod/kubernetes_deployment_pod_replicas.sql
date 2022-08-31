select
  -- Required Columns
  uid as resource,
  case 
    when replicas >= '3' then 'ok' 
    else 'alarm' 
  end as status,
  case
    when replicas >='3' then  name || ' has 3 or more replicas. '
    else name || ' has less than 3 replicas. Add atleast 3 replicas for high availability'
  end as reason,
  -- Additional Dimensionss
  context_name,
  namespace
from
  kubernetes_deployment;
