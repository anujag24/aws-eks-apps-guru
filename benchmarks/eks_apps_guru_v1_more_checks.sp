locals {
  more_checks_common_tags = merge(local.nsa_cisa_v1_common_tags, {
  })
}

benchmark "eks_apps_guru_v1_more_checks" {
  title = "AWS Guru Kubernetes Additional Best Practices"
  children = [
    benchmark.eks_checks,
    benchmark.EKS_Default_Deny
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

benchmark "EKS_Default_Deny" {
  title       = "Deny All Ingress and Egress Network by Default" 
  description = "Checks for default network deny on EKS Clusters"
  children  = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress
    ]
    
    tags = merge(local.more_checks_common_tags, {
      type = "Benchmark"
    })
}

