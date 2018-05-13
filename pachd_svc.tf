resource "kubernetes_service" "pachd" {
  metadata {
    name = "pachd"
    labels {
      app = "pachd"
      suite = "pachyderm"
    }
  }
  spec {
    port = [
      {
        name = "api-grpc-port"
        port = 650
        node_port = 30650
      },
      {
        name = "trace-port"
        port = 651
        node_port = 30651
      },
      {
        name = "api-http-port"
        port = 652
        node_port = 30652
      },
      {
        name = "api-git-port"
        port = 999
        node_port = 30999
      }
    ]
    selector {
      app = "pachd"
    }
    type = "NodePort"
  }
}