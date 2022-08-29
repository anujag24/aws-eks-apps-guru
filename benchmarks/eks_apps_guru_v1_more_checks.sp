locals {
  more_checks_common_tags = merge(local.nsa_cisa_v1_common_tags, {
  })
}

benchmark "eks_apps_guru_v1_more_checks" {
  title = "AWS Guru Kubernetes Additional Best Practices"
  children = [
    benchmark.eks_latest_version
  ]

  tags = merge(local.more_checks_common_tags, {
    type = "Benchmark"
  })
}

benchmark "eks_latest_version" {
  title       = "EKS Clusters Running latest version"
  description = "EKS Clusters running latest version."
  children = [
    control.eks_cluster_version
  ]

  tags = merge(local.more_checks_common_tags, {
    type = "Benchmark"
  })
}

