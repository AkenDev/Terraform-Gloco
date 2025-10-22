gke-poc-project/
├── modules/
│   ├── vpc/
│   │   ├── main.tf        # VPC, Subnet resources
│   │   ├── variables.tf   # Inputs (e.g., vpc_name, region)
│   │   └── outputs.tf     # Outputs (network_id, subnetwork_id)
│   └── gke-cluster/
│       ├── main.tf        # GKE Cluster, Node Pool resources
│       ├── variables.tf   # Inputs (e.g., location, vpc_network_id, project_id, SA email)
│       └── outputs.tf     # Outputs (cluster_endpoint, kubeconfig_command)
│
└── poc-deployment/
    ├── main.tf            # **Connects the modules** (VPC output -> GKE input)
    ├── variables.tf       # Root-level inputs (project_id, specific_zone, user roles, etc.)
    ├── outputs.tf         # Exports GKE endpoint and kubeconfig command
    ├── versions.tf        # Defines Terraform version, **GCS Backend**, and Google provider
    ├── iam.tf             # IAM resources (GKE Service Account, User binding)
    └── terraform.tfvars   # Actual values (project ID, user email, size)