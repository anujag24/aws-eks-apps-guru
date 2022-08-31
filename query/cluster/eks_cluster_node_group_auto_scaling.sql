select
  -- Required Columns
  arn as resource,
  case
    when scaling_config is null then 'alarm'
	    else 'ok'
		  end as status,
		  case
			    when scaling_config is null then cluster_name || ' does not have auto scaling group attached for node group'
				    else cluster_name || ' has auto scaling group attached'
					  end as reason,
					  -- Additional Dimensions
  cluster_name,
  scaling_config
from
  aws_eks_node_group;
