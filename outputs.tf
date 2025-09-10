output "grafana_release" {
  value = helm_release.grafana.name
}

output "grafana_namespace" {
  value = kubernetes_namespace.monitoring.metadata[0].name
}