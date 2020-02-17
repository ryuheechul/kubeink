resource "kubernetes_job" "kubectl_test" {
  metadata {
    name = "kubeink-job"
  }

  spec {
    template {
      metadata {
        name = "kubectl-pod"
      }

      spec {
        service_account_name = kubernetes_service_account.kubeink.metadata[0].name

        automount_service_account_token = true

        security_context {
          run_as_user = 1000
        }

        container {
          name  = "kubectl"
          image = "bitnami/kubectl"
          command = [
            "sh", "-c",
            "/.kube/gen-config/gen-config.sh && kubectl cluster-info"
          ]

          env {
            name  = "KUBERNETES_SA_CA_CERT"
            value = "/var/run/secrets/kubernetes.io/serviceaccount/ca.crt"
          }

          env {
            name  = "KUBERNETES_SA_TOKEN"
            value = "/var/run/secrets/kubernetes.io/serviceaccount/token"
          }

          volume_mount {
            name       = "kube-config"
            mount_path = "/.kube"
          }

          volume_mount {
            name       = "gen-config-sh"
            mount_path = "/.kube/gen-config"
          }
        }

        volume {
          name = "kube-config"
          empty_dir {}
        }

        volume {
          name = "gen-config-sh"
          config_map {
            name         = kubernetes_config_map.gen_config.metadata[0].name
            default_mode = "0777"
          }
        }
      }
    }
  }
}
