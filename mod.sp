// Benchmarks and controls for specific services should override the "service" tag
locals {
  kubernetes_compliance_common_tags = {
    category = "Compliance"
    plugin   = "kubernetes"
    service  = "Kubernetes"
  }
}



mod "awsguru" {
  title = "AWS Kubernetes Apps Best Practices"
  requires {
    steampipe = "0.13.1"
    plugin "kubernetes" {
      version = "0.4.0"
    }
   }
   
}
