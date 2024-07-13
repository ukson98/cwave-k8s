# get credential of EKS
aws eks update-kubeconfig --region <region-code> --name <my-cluster>

# test aws cli
aws s3 ls
aws sts get-caller-identity

# aws default profile
aws configure --profile cwave
export AWS_PROFILE=cwave