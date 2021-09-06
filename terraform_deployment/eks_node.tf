resource "aws_eks_node_group" "voting_app_node" {
  cluster_name    = aws_eks_cluster.voting_app.name
  node_group_name = "voting_app_node"
  node_role_arn   = aws_iam_role.voting_app_node.arn
  subnet_ids      = ["subnet-b02abbfd", "subnet-27f23341"]

  scaling_config {
    desired_size = 1
    max_size     = 1
    min_size     = 1
  }


  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.voting_app_node-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.voting_app_node-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.voting_app_node-AmazonEC2ContainerRegistryReadOnly,
  ]
}