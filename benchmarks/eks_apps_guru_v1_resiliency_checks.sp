locals {
  resiliency_checks_common_tags = merge(local.nsa_cisa_v1_common_tags, {
  })
}

benchmark "eks_apps_guru_v1_resiliency_checks" {
  title = "4. AWS Guru Kubernetes Resiliency Best Practices"
  children = [
    benchmark.pod_resiliency,
    benchmark.cluster_resiliency
  ]
  type = "table"
  tags = merge(local.resiliency_checks_common_tags, {
    type = "Benchmark"
  })
}

benchmark "pod_resiliency" {
  title       = "4.1 Kubernetes Pod Resiliency Best Practices"
  description = "Kubernetes Pod Resiliency Best Practices Checks"
  children = [
    control.deployment_replicas_count,
    control.eks_cluster_auto_scaling_group_attached
  ]
  type = "table"
  tags = merge(local.resiliency_checks_common_tags, {
    type = "Benchmark"
  })
}

benchmark "cluster_resiliency" {
  title       = "4.2 Kubernetes Node Group Resiliency Best Practices"
  description = "Kubernetes Node Group Resiliency Best Practices Checks"
  children = [
    control.eks_cluster_auto_scaling_group_attached
  ]
  type = "table"
  tags = merge(local.resiliency_checks_common_tags, {
    type = "Benchmark"
  })
}

