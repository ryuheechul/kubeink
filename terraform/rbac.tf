resource "kubernetes_service_account" "kubeink" {
  metadata {
    name = "kubeink"
  }
}

resource "kubernetes_cluster_role_binding" "kubeink" {
  metadata {
    name = "kubeink"
  }

  role_ref {
    api_group = "rbac.authorization.k8s.io"
    kind      = "ClusterRole"
    name      = "view"
  }

  subject {
    kind = "ServiceAccount"
    name = kubernetes_service_account.kubeink.metadata[0].name
  }
}
