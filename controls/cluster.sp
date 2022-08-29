locals {
  cluster_common_tags = merge(local.kubernetes_compliance_common_tags, {
    service = "Kubernetes/Cluster"
  })
}

control "eks_cluster_version" {
  title       = "EKS Cluster running latest EKS version"
  description = "This control checks whether an Amazon EKS cluster is running on a supported Kubernetes version. The control fails if the EKS cluster is running on an unsupported version."
  sql         = query.eks_cluster_with_latest_kubernetes_version.sql

  tags = merge(local.cluster_common_tags, {
    nsa_cisa_v1 = "true"
  })
}
