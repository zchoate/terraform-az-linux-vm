# Template for Terraform on Azure
This is a template to implement a simple resource group into an Azure subscription. Use this as the starting point for deploying additional resources into Azure with Terraform. After creating a new repository with this template:
- update `provider.tf` with the required backend information
- update `default.auto.tfvars` with the appropriate variable values
- add an Azure AD Application Registration that has the appropriate access to the target subscription
- configure the Application Registration to use Federated Credentials pointing at the repository you've created. This should apply only to PRs.