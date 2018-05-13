resource "kubernetes_service" "etcd" {
  metadata {
    name = "etcd"
    labels {
      app = "etcd"
      suite = "pachyderm"
    }
  }
  spec {
    port = [
      {
        name = "client-port"
        port = 2379
      }
    ]
    selector {
      app = "etcd"
    }
    type = "NodePort"
  }
}