# get credential of EKS
aws eks update-kubeconfig --region ap-northeast-2 --name cwave

# test aws cli
aws s3 ls
aws sts get-caller-identity

# aws default profile
aws configure --profile cwave
export AWS_PROFILE=cwave

# kubectl rename context-name
kubectl config rename-context old-name new-name
