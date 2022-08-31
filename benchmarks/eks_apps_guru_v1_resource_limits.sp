benchmark "eks_apps_guru_v1_resource_limits" {
  title = "5. AWS Guru Kubernetes Pod Resources Best Practices"
  children = [
    benchmark.nsa_cisa_v1_network_hardening_cpu_limit,
    benchmark.nsa_cisa_v1_network_hardening_memory_limit
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_network_hardening_cpu_limit" {
  title       = "5.1 Containers should have a CPU limit to prevent resource conflicts"
  description = "Containers should have CPU limit which restricts the container to use no more than a given amount of CPU."
  children = [
    control.deployment_cpu_limit,
    control.namespace_limit_range_default_cpu_limit
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}


benchmark "nsa_cisa_v1_network_hardening_memory_limit" {
  title       = "5.2 Containers should have a memory limit"
  description = "Containers should have a memory limit which restricts the container to use no more than a given amount of user or system memory."
  children = [
    control.deployment_memory_limit,
    control.namespace_limit_range_default_memory_limit
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}
