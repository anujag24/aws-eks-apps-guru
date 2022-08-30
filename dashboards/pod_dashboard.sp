dashboard "kubernetes_dashboard" {

  title         = "Kubernetes Dashboard"
  #documentation = file("./dashboards/pod/docs/pod_dashboard.md")

  tags = merge(local.pod_common_tags, {
    type = "Dashboard"
  })

container {

table {
  query = query.kubernetes_cluster
  width = 10
}

}

  container {
  
  title = "Applications" 
  
   table {
    query = query.kubernetes_list_pods
    width = 6
   
   }
   
   chart {
      title = "Replicas High Availability Status"
      query = query.kubernetes_deployment_container_replica_status
      type  = "donut"
      width = 4

      series "count" {
        point "HA" {
          color = "ok"
        }
        point "non-HA" {
          color = "alert"
        }
      }
    }
   
  table {
  query = query.kubernetes_deployment_info
  width = 9
}

  }
  

  container {

    title = "Assessments"
    
  


    chart {
      title = "Default Namespace Status"
      query = query.kubernetes_pod_default_namespace_status
      type  = "donut"
      width = 3

      series "count" {
        point "used" {
          color = "alert"
        }
        point "unused" {
          color = "ok"
        }
      }
    }

    chart {
      title = "Host Network Access Status"
      query = query.kubernetes_pod_container_host_network_status
      type  = "donut"
      width = 3

      series "count" {
        point "enabled" {
          color = "alert"
        }
        point "disabled" {
          color = "ok"
        }
      }
    }

    chart {
      title = "Host PID Sharing Status"
      query = query.kubernetes_pod_container_host_pid_status
      type  = "donut"
      width = 3

      series "count" {
        point "enabled" {
          color = "alert"
        }
        point "disabled" {
          color = "ok"
        }
      }
    }

    chart {
      title = "Host IPC Sharing Status"
      query = query.kubernetes_pod_container_host_ipc_status
      type  = "donut"
      width = 3

      series "count" {
        point "enabled" {
          color = "alert"
        }
        point "disabled" {
          color = "ok"
        }
      }
    }

  }
  

}


# Card Queries

query "kubernetes_service_by_context_name" {
  sql = <<-EOQ
    select
      context_name,
      count(name) as "services"
    from
      kubernetes_service
    group by
      context_name
    order by
      context_name;
  EOQ
}

query "kubernetes_deployment_container_replica_status" {
  sql = <<-EOQ
    select
      case when replicas < '3' then 'non-HA' else 'HA' end as status,
      count(name)
    from
      kubernetes_deployment
    group by
      status;
  EOQ
}

query "kubernetes_deployment_info" {
sql = <<-EOQ
select name as "Replica Name", replicas as "Total Replicas" , strategy as "Deployment Strategy" from kubernetes_deployment;
EOQ
}
query "kubernetes_list_pods" {
sql = <<-EOQ
select name as "Application Pod Names", namespace as "Namespace" from kubernetes_pod where namespace != 'kube-system';
  EOQ
}

query "kubernetes_cluster" {
sql = <<-EOQ
select account_id as "AWS Account",name as "Cluster Name",status as "Current Status",version as "Cluster Version",region as "AWS Region" from aws_eks_cluster;;
  EOQ
}


query "kubernetes_pod_container_liveness_probe" {
sql = <<-EOQ
select
  count(c ->> 'name') as "Pods with Liveness_Probe_Enabled"
from
  kubernetes_pod,
  jsonb_array_elements(containers) as c
where
  c -> 'livenessProbe' is not null;
  EOQ
}


query "kubernetes_pod_count" {
  sql = <<-EOQ
    select
      count(*) as "Pods"
    from
      kubernetes_pod;
  EOQ
}

query "kubernetes_pod_container_count" {
  sql = <<-EOQ
    select
      count(c) as value,
      'Containers' as label
    from
      kubernetes_pod,
      jsonb_array_elements(containers) as c;
  EOQ
}

query "kubernetes_pod_default_namespace_count" {
  sql = <<-EOQ
    select
      count(name) as value,
      'Default Namespace Used' as label,
      case count(name) when 0 then 'ok' else 'alert' end as type
    from
      kubernetes_pod
    where
      namespace = 'default';
  EOQ
}

query "kubernetes_pod_container_host_network_count" {
  sql = <<-EOQ
    select
      count(name) as value,
      'Host Network Access Enabled' as label,
      case count(name) when 0 then 'ok' else 'alert' end as type
    from
      kubernetes_pod
    where
      host_network;
  EOQ
}

query "kubernetes_pod_container_host_pid_count" {
  sql = <<-EOQ
    select
      count(name) as value,
      'Host PID Sharing Enabled' as label,
      case count(name) when 0 then 'ok' else 'alert' end as type
    from
      kubernetes_pod
    where
      host_pid;
  EOQ
}

query "kubernetes_pod_container_host_ipc_count" {
  sql = <<-EOQ
    select
      count(name) as value,
      'Host IPC Sharing Enabled' as label,
      case count(name) when 0 then 'ok' else 'alert' end as type
    from
      kubernetes_pod
    where
      host_ipc;
  EOQ
}

# Assessment Queries

query "kubernetes_pod_default_namespace_status" {
  sql = <<-EOQ
    select
      case when namespace = 'default' then 'used' else 'unused' end as status,
      count(name)
    from
      kubernetes_pod
    group by
      status;
  EOQ
}

query "kubernetes_pod_container_host_network_status" {
  sql = <<-EOQ
    select
      case when host_network then 'enabled' else 'disabled' end as status,
      count(*)
    from
      kubernetes_pod
    group by
      status;
  EOQ
}

query "kubernetes_pod_container_host_pid_status" {
  sql = <<-EOQ
    select
      case when host_pid then 'enabled' else 'disabled' end as status,
      count(*)
    from
      kubernetes_pod
    group by
      status;
  EOQ
}

query "kubernetes_pod_container_host_ipc_status" {
  sql = <<-EOQ
    select
      case when host_ipc then 'enabled' else 'disabled' end as status,
      count(*)
    from
      kubernetes_pod
    group by
      status;
  EOQ
}

# Analysis Queries

query "kubernetes_pod_by_namespace" {
  sql = <<-EOQ
    select
      namespace,
      count(name) as "pods"
    from
      kubernetes_pod
    group by
      namespace
    order by
      namespace;
  EOQ
}

query "kubernetes_pod_by_context_name" {
  sql = <<-EOQ
    select
      context_name,
      count(name) as "pods"
    from
      kubernetes_pod
    group by
      context_name
    order by
      context_name;
  EOQ
}

query "kubernetes_pod_by_creation_month" {
  sql = <<-EOQ
    with pods as (
      select
        title,
        creation_timestamp,
        to_char(creation_timestamp,
          'YYYY-MM') as creation_month
      from
        kubernetes_pod
    ),
    months as (
      select
        to_char(d,
          'YYYY-MM') as month
      from
        generate_series(date_trunc('month',
            (
              select
                min(creation_timestamp)
                from pods)),
            date_trunc('month',
              current_date),
            interval '1 month') as d
    ),
    pods_by_month as (
      select
        creation_month,
        count(*)
      from
        pods
      group by
        creation_month
    )
    select
      months.month,
      pods_by_month.count
    from
      months
      left join pods_by_month on months.month = pods_by_month.creation_month
    order by
      months.month;
  EOQ
}

