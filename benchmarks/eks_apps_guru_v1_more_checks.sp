locals {
  more_checks_common_tags = merge(local.nsa_cisa_v1_common_tags, {
  })
}

benchmark "eks_apps_guru_v1_more_checks" {
  title = "AWS Guru Kubernetes Additional Best Practices"
  children = [
    benchmark.eks_checks
  ]

  tags = merge(local.more_checks_common_tags, {
    type = "Benchmark"
  })
}

benchmark "eks_checks" {
  title       = "EKS Clusters Additional Checks"
  description = "EKS Clusters Additional Checks."
  children = [
    control.eks_cluster_version,
    control.eks_cluster_restrict_public_access,
    control.eks_cluster_enable_audit_logging
  ]

  tags = merge(local.more_checks_common_tags, {
    type = "Benchmark"
  })
}

