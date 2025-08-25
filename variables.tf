variable "project_name" {
  type        = string
  description = "Nome do projeto"
}

variable "region" {
  type        = string
  description = "Região AWS"
}

variable "k8s_version" {
  type        = string
  description = "Versão do Kubernetes"

}

variable "addon_cni_version" {
  type    = string
  default = "v1.19.5-eksbuild.1"
}

variable "addon_coredns_version" {
  type    = string
  default = "v1.12.1-eksbuild.2"
}

variable "addon_kubeproxy_version" {
  type    = string
  default = "v1.33.0-eksbuild.2"
}

variable "ssm_vpc" {
  type = string
}

variable "ssm_public_subnets" {
  type = list(string)
}

variable "ssm_private_subnets" {
  type = list(string)
}

variable "ssm_pod_subnets" {
  type = list(string)
}

variable "auto_scale_options" {
  type = object({
    min_size     = number
    max_size     = number
    desired_size = number
  })
  description = "Configurações de auto scaling para os nós do EKS"
}

variable "nodes_instance_sizes" {
  type        = list(string)
  description = "Tamanho de instância para os nós do EKS"

}