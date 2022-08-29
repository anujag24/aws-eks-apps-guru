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

control "eks_cluster_restrict_public_access" {
  title       = "EKS Cluster endpoint restricting public access"
  description = "Ensure whether Amazon Elastic Kubernetes Service (Amazon EKS) endpoint is not publicly accessible. The rule is complaint if the endpoint is publicly accessible."
  sql         = query.eks_cluster_endpoint_restrict_public_access.sql

  tags = merge(local.cluster_common_tags, {
    nsa_cisa_v1 = "true"
  })
}

control "eks_cluster_enable_audit_logging" {
  title       = "EKS Cluster Enable Audit Logging"
  description = "Amazon EKS clusters should have control plane audit logging enabled. These logs make it easy to secure and run clusters."
  sql         = query.eks_cluster_control_plane_audit_logging_enabled.sql

  tags = merge(local.cluster_common_tags, {
    nsa_cisa_v1 = "true"
  })
}
