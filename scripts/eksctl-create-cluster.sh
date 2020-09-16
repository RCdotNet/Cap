eksctl create cluster \
--name capstonecluster \
--version 1.17 \
--region us-east-2b \
--nodegroup-name linux-nodes \
--nodes 2 \
--nodes-min 2 \
--nodes-max 2 \
--node-type t3.medium \--managed 