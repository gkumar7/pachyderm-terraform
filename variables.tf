variable "pachd_image_repo" {
  type = "string"
  default = "pachyderm/pachd"
}

variable "pachd_image_tag" {
  type = "string"
  default = "1.7.0"
}

variable "pachd_image_pull_policy" {
  type = "string"
  default = "IfNotPresent"
}

variable "pachd_replicas" {
  type = "string"
  default = "1"
}

variable "pachd_cpu" {
  type = "string"
  default = "250m"
}

variable "pachd_memory" {
  type = "string"
  default = "512M"
}

variable "pachd_cpu_max" {
  type = "string"
  default = "250m"
}

variable "pachd_memory_max" {
  type = "string"
  default = "512M"
}

variable "pachd_log_level" {
  type = "string"
  default = "info"
}

variable "pachd_storage" {
  type = "string"
  default = "LOCAL"
}

variable "pachd_worker_image_repo" {
  type = "string"
  default = "pachyderm/worker"
}

variable "pachd_worker_image_tag" {
  type = "string"
  default = "1.7.0"
}

variable "pachd_worker_image_pull_policy" {
  type = "string"
  default = "IfNotPresent"
}

variable "pachd_pfs_cache" {
  type = "string"
  default = "256M"
}

variable "etcd_image_repo" {
  type = "string"
  default = "pachyderm/etcd"
}

variable "etcd_image_tag" {
  type = "string"
  default = "v3.2.7"
}

variable "etcd_image_pull_policy" {
  type = "string"
  default = "IfNotPresent"
}
variable "etcd_replicas" {
  type = "string"
  default = "1"
}
variable "etcd_cpu" {
  type = "string"
  default = "250m"
}
variable "etcd_memory" {
  type = "string"
  default = "256M"
}
variable "etcd_cpu_max" {
  type = "string"
  default = "250m"
}
variable "etcd_memory_max" {
  type = "string"
  default = "256M"
}