resource "aws_eks_node_group" "main" {
  cluster_name    = aws_eks_cluster.main.name
  node_group_name = aws_eks_cluster.main.name
  node_role_arn   = aws_iam_role.eks_nodes_role.arn

  instance_types = var.nodes_instance_sizes

  subnet_ids = data.aws_ssm_parameter.pod_subnets[*].value

  scaling_config {
    desired_size = lookup(var.auto_scale_options, "desired_size")
    max_size     = lookup(var.auto_scale_options, "max_size")
    min_size     = lookup(var.auto_scale_options, "min_size")
  }

  labels = {
    "ingress/ready" = "true"
  }

  tags = {
    "ku/kubernetes.io/cluster/${var.project_name}" = "shared"
  }

  depends_on = [
    # kubernetes_config_map.aws-auth
    aws_eks_access_entry.nodes
  ]

  lifecycle {
    ignore_changes = [
      scaling_config[0].desired_size
    ]
  }

  timeouts {
    create = "1h"
    delete = "2h"
    update = "2h"
  }
}