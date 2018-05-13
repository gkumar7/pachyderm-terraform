resource "kubernetes_deployment" "etcd" {
  metadata {
    name = "etcd"
    labels {
      app = "etcd"
      suite = "pachyderm"
    }
  }

  spec {
    replicas = "${var.etcd_replicas}"
    selector {
      app = "etcd"
      suite = "pachyderm"
    }
    template {
      metadata {
        labels {
          app = "etcd"
          suite = "pachyderm"
        }
      }
      spec {
        container {
          name = "etcd"
          image = "${var.etcd_image_repo}:${var.etcd_image_tag}"
          image_pull_policy = "${var.etcd_image_pull_policy}"
          port = [
            {
              name = "client-port"
              container_port = 2379
            },
            {
              name = "peer-port"
              container_port = 2380
            }
          ]
          resources {
            limits {
              cpu = "${var.etcd_cpu_max}"
              memory = "${var.etcd_memory_max}"
            }
            requests {
              cpu = "${var.etcd_cpu}"
              memory = "${var.etcd_memory}"
            }
          }
          command = [
            "/usr/local/bin/etcd",
            "--listen-client-urls=http://0.0.0.0:2379",
            "--advertise-client-urls=http://0.0.0.0:2379",
            "--data-dir=/var/data/etcd",
            "--auto-compaction-retention=1"
          ]

          volume_mount {
            name = "etcd-storage"
            mount_path = "/var/data/etcd"
          }
        }
        volume {
          name = "etcd-storage"
          host_path {
            path = "/var/pachyderm/etcd"
          }
        }
      }
    }
  }
}