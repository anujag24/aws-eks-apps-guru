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
