resource "kubernetes_namespace" "monitoring" {
  provider = kubernetes
  metadata {
    name = var.namespace
  }
}

resource "kubernetes_service_account" "grafana_sa" {
  provider = kubernetes
  metadata {
    name      = "grafana-sa"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
}

resource "kubernetes_role" "grafana_role" {
  provider = kubernetes
  metadata {
    name      = "grafana-role"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  rule {
    api_groups = [""]
    resources  = ["secrets"]
    verbs      = ["get", "list"]
  }
}

resource "kubernetes_role_binding" "grafana_role_binding" {
  provider = kubernetes
  metadata {
    name      = "grafana-rolebinding"
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  subject {
    kind      = "ServiceAccount"
    name      = kubernetes_service_account.grafana_sa.metadata[0].name
    namespace = kubernetes_namespace.monitoring.metadata[0].name
  }
  role_ref {
    kind     = "Role"
    name     = kubernetes_role.grafana_role.metadata[0].name
    api_group = "rbac.authorization.k8s.io"
  }
}

resource "helm_release" "grafana" {
  provider   = helm
  name       = var.grafana_release_name
  namespace  = kubernetes_namespace.monitoring.metadata[0].name
  repository = "https://grafana.github.io/helm-charts"
  chart      = "grafana"
  version    = var.grafana_chart_version
  values     = [file("${path.module}/grafana-values.yaml")]
  timeout    = 600
}