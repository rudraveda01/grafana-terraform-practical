variable "kubeconfig_path" {
  type    = string
  default = "~/.kube/config"
  description = "Path to kubeconfig"
}

variable "namespace" {
  type    = string
  default = "monitoring"
}

variable "grafana_chart_version" {
  type    = string
  default = "8.9.0" 
}

variable "grafana_release_name" {
  type    = string
  default = "grafana"
}

variable "grafana_admin_user" {
  type    = string
  default = "grafana-admin"
  description = "Admin username (public part stored in Kubernetes Secret)"
}

variable "grafana_admin_password" {
  type    = string
  description = "Admin password. Prefer to pass through environment or CI secrets."
  default = ""
}

variable "ingress_enabled" {
  type    = bool
  default = false
}

variable "ingress_host" {
  type    = string
  default = ""
}

variable "tls_secret_name" {
  type    = string
  default = ""
}