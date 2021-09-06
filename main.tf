resource "null_resource" "kubectl1" {
    depends_on = [aws_eks_node_group.voting_app_node]
  provisioner "local-exec" {
    command = <<-EOT
    aws eks --region us-east-1 update-kubeconfig --name voting_app
    kubectl create -f namespace.yaml
    kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
    kubectl get deployment metrics-server -n kube-system
    kubectl get all -n dev
    kubectl create -f deployment.yaml -n dev
    kubectl create -f hpa.yaml -n dev
    kubectl create -f voting-app-service.yaml -n dev
    kubectl get all -n dev

    EOT
   
  
  }
}
