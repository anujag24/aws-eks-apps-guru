locals {
  nsa_cisa_v1_network_hardening_common_tags = merge(local.nsa_cisa_v1_common_tags, {
  })
}


benchmark "eks_apps_guru_v1_network_hardening" {
  title = "2. AWS Guru Network Security Best Practices"
  children = [
    benchmark.nsa_cisa_v1_network_hardening_api_serve_on_secure_port_endpoint,
    benchmark.nsa_cisa_v1_network_hardening_default_deny_network_policy
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}


benchmark "eks_apps_guru_v1_resource_limits" {
  title = "5. AWS Guru Kubernetes Pod Security Best Practices"
  children = [
    benchmark.nsa_cisa_v1_network_hardening_cpu_limit,
    benchmark.nsa_cisa_v1_network_hardening_cpu_request,
    benchmark.nsa_cisa_v1_network_hardening_memory_limit,
    benchmark.nsa_cisa_v1_network_hardening_memory_request
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

benchmark "nsa_cisa_v1_network_hardening_cpu_request" {
  title       = "5.2 Containers should have a CPU request"
  description = "Containers should have CPU request. If required Kubernetes will make sure your containers get the CPU they requested."
  children = [
    control.deployment_cpu_request,
    control.namespace_limit_range_default_cpu_request,
    control.namespace_resource_quota_cpu_request
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_network_hardening_api_serve_on_secure_port_endpoint" {
  title       = "2.1 Kubernetes API should serve on secure port"
  description = "Kubernetes API should serve on port 443 or port 6443, protected by TLS. Once TLS is established, the HTTP request moves to the authentication step. If the request cannot be authenticated, it is rejected with HTTP status code 401."
  children = [
    control.endpoint_api_serve_on_secure_port,
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_network_hardening_memory_limit" {
  title       = "5.3 Containers should have a memory limit"
  description = "Containers should have a memory limit which restricts the container to use no more than a given amount of user or system memory."
  children = [
    control.deployment_memory_limit,
    control.namespace_limit_range_default_memory_limit
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_network_hardening_memory_request" {
  title       = "5.4 Containers should have a memory request"
  description = "Containers should have memory request. If required Kubernetes will make sure your containers get the memory they requested."
  children = [
    control.deployment_memory_request,
    control.namespace_limit_range_default_memory_request
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_network_hardening_default_deny_network_policy" {
  title       = "2.2 Network policy should have a default policy to deny all ingress and egress traffic"
  description = "Administrators should use a default policy selecting all Pods to deny all ingress and egress traffic and ensure any unselected Pods are isolated. Additional policies could then relax these restrictions for permissible connections."
  children = [
    control.network_policy_default_deny_egress,
    control.network_policy_default_deny_ingress,
    control.network_policy_default_dont_allow_egress,
    control.network_policy_default_dont_allow_ingress
  ]

  tags = merge(local.nsa_cisa_v1_network_hardening_common_tags, {
    type = "Benchmark"
  })
}
