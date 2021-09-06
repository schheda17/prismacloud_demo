resource "aws_eks_cluster" "voting_app" {
  name     = "voting_app"
  role_arn = aws_iam_role.voting_app.arn

   vpc_config {
    subnet_ids = ["subnet-b02abbfd", "subnet-27f23341"]
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.voting_app-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.voting_app-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.voting_app.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.voting_app.certificate_authority[0].data
}