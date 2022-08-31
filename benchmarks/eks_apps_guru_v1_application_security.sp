locals {
  nsa_cisa_v1_pod_security_common_tags = merge(local.nsa_cisa_v1_common_tags, {
  })
}

benchmark "eks_apps_guru_v1_pod_security" {
  title = "1. AWS Guru Kubernetes Application Security"
  children = [
    benchmark.nsa_cisa_v1_pod_security_container_privilege_disabled,
    benchmark.nsa_cisa_v1_pod_security_container_security_service_hardening,
    benchmark.nsa_cisa_v1_pod_security_host_network_access_disabled,
    benchmark.nsa_cisa_v1_pod_security_hostpid_hostipc_sharing_disabled,
    benchmark.nsa_cisa_v1_pod_security_non_root_container,
    benchmark.nsa_cisa_v1_pod_security_service_account_token_disabled
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}


benchmark "nsa_cisa_v1_pod_security_container_privilege_disabled" {
  title       = "1.1 Containers should not have privileged access"
  description = "Containers should not have privileged access. To prevent security issues, it is recommended that you do not run privileged containers in your environment. Instead, provide granular permissions and capabilities to the container environment. Giving containers full access to the host can create security flaws in your production environment."
  children = [
    control.daemonset_container_privilege_disabled,
    control.deployment_container_privilege_disabled,
    control.pod_container_privilege_disabled,
    control.pod_security_policy_container_privilege_disabled,
    control.replication_controller_container_privilege_disabled
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}


benchmark "nsa_cisa_v1_pod_security_container_security_service_hardening" {
  title       = "1.2 Containerized applications should use security services"
  description = "Linux provides several out-of-the-box security modules. Some of the popular ones are SELinux, AppArmor and Seccomp. Containerized applications should use these security services."
  children = [
    control.pod_security_policy_security_services_hardening,
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_pod_security_host_network_access_disabled" {
  title       = "1.3 Containers should not run with host network access"
  description = "Pod host network controls whether the Pod may use the node network namespace. Doing so gives the Pod access to the loopback device, services listening on localhost, and could be used to snoop on network activity of other Pods on the same node."
  children = [
    control.daemonset_host_network_access_disabled,
    control.deployment_host_network_access_disabled,
    control.pod_host_network_access_disabled,
    control.pod_security_policy_host_network_access_disabled,
    control.replicaset_host_network_access_disabled
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_pod_security_hostpid_hostipc_sharing_disabled" {
  title       = "1.4 Containers should not share the host process namespace"
  description = "Containers should not share the host process PID or IPC namespace. Sharing the host’s process namespace allows the container to see all of the processes on the host system. This reduces the benefit of process level isolation between the host and the containers. Under these circumstances a malicious user who has access to a container could get access to processes on the host itself, manipulate them, and even be able to kill them."
  children = [
    control.daemonset_hostpid_hostipc_sharing_disabled,
    control.deployment_hostpid_hostipc_sharing_disabled,
    control.pod_hostpid_hostipc_sharing_disabled,
    control.pod_security_policy_hostpid_hostipc_sharing_disabled,
    control.replicaset_hostpid_hostipc_sharing_disabled
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}


benchmark "nsa_cisa_v1_pod_security_non_root_container" {
  title       = "1.5 Containers should not run with root privileges"
  description = "Containers should not be deployed with root privileges. By default, many container services run as the privileged root user, and applications execute inside the container as root despite not requiring privileged execution. Preventing root execution by using non-root containers or a rootless container engine limits the impact of a container compromise."
  children = [
    control.pod_security_policy_non_root_container
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}

benchmark "nsa_cisa_v1_pod_security_service_account_token_disabled" {
  title       = "1.6 Automatic mounting of the service account tokens should be disabled"
  description = local.service_account_token_disabled_desc
  children = [
    control.pod_service_account_token_disabled,
    control.service_account_token_disabled
  ]

  tags = merge(local.nsa_cisa_v1_pod_security_common_tags, {
    type = "Benchmark"
  })
}
