locals {
  nsa_cisa_v1_common_tags = merge(local.kubernetes_compliance_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

benchmark "eks_apps_guru_v1" {
  title         = "AWS Guru Best Practices for Operating Kubernetes Applications v1.0"
#  documentation = file("./nsa_cisa_v1/docs/nsa_cisa_v1_overview.md")
  children = [
    benchmark.eks_apps_guru_v1_pod_security,
    benchmark.eks_apps_guru_v1_network_hardening,
    benchmark.eks_apps_guru_v1_cluster_checks,
    benchmark.eks_apps_guru_v1_resiliency_checks,
    benchmark.eks_apps_guru_v1_resource_limits
  ]

  tags = merge(local.nsa_cisa_v1_common_tags, {
    type = "table"
  })
}
