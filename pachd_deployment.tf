resource "kubernetes_deployment" "pachd" {
  metadata {
    name = "pachd"
    labels {
      app = "pachd"
      suite = "pachyderm"
    }
  }

  spec {
    replicas = "${var.pachd_replicas}"
    selector {
      app = "pachd"
      suite = "pachyderm"
    }
    template {
      metadata {
        labels {
          app = "pachd"
          suite = "pachyderm"
        }
      }
      spec {
        service_account_name = "pachyderm"
        container {
          name = "pachd"
          image = "${var.pachd_image_repo}:${var.pachd_image_tag}"
          image_pull_policy = "${var.pachd_image_pull_policy}"
          port = [
            {
              name = "api-grpc-port"
              container_port = 650
            },
            {
              name = "trace-port"
              container_port = 651
            },
            {
              name = "api-http-port"
              container_port = 652
            },
            {
              name = "api-git-port"
              container_port = 999
            }
          ]
          resources {
            limits {
              cpu = "${var.pachd_cpu_max}"
              memory = "${var.pachd_memory_max}"
            }
            requests {
              cpu = "${var.pachd_cpu}"
              memory = "${var.pachd_memory}"
            }
          }
          readiness_probe {
            exec {
              command = [
                "/pachd",
                "--readiness"
              ]
            }
            period_seconds = 10
            timeout_seconds = 1
          }
          env = [
            {
              name = "PACH_ROOT"
              value = "/pach"
            },
            {
              name = "NUM_SHARDS"
              value = "16"
            },
            {
              name = "ETCD_PORT_2379_TCP_ADDR"
              value = "${kubernetes_service.etcd.spec.0.cluster_ip}"
            },
            {
              name = "STORAGE_BACKEND"
              value = "${var.pachd_storage}"
            },
            {
              name = "STORAGE_HOST_PATH"
              value = "/var/pachyderm/pachd"
            },
            {
              name = "WORKER_IMAGE"
              value = "${var.pachd_worker_image_repo}:${var.pachd_worker_image_tag}"
            },
            {
              name = "WORKER_SIDECAR_IMAGE"
              value = "${var.pachd_image_repo}:${var.pachd_image_tag}"
            },
            {
              name = "WORKER_IMAGE_PULL_POLICY"
              value = "${var.pachd_worker_image_pull_policy}"
            },
            {
              name = "PACHD_VERSION"
              value = "${var.pachd_image_tag}"
            },
            {
              name = "LOG_LEVEL"
              value = "${var.pachd_log_level}"
            },
            {
              name = "METRICS"
              value = "true"
            },
            {
              name = "BLOCK_CACHE_BYTES"
              value = "${var.pachd_pfs_cache}"
            },
            {
              name = "PACHYDERM_AUTHENTICATION_DISABLED_FOR_TESTING"
              value = "false"
            },
            {
              name = "PACHD_POD_NAMESPACE"
              value_from {
                field_ref {
                  api_version = "v1"
                  field_path = "metadata.namespace"
                }
              }
            }]
          volume_mount {
            name = "pach-disk"
            mount_path = "/pach"
          }
        }
        volume {
          name = "pach-disk"
          host_path {
            path = "/var/pachyderm/pachd"
          }
        }
      }
    }
  }
}