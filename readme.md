# Reference deployment for Linux VM in Azure
This is just a simple reference deployment for a Linux virtual machine in Azure. It isn't necessarily production ready but this should demonstrate the following:

- Standardized naming and tagging of resources along with accomodations for resource types like a storage account that has a max of 24 characters in the name
- Deployment of a Resource Group
- Deployment of a Virtual Network, subnet, and network security group
- Deployment of a Linux virtual machine with some best practices already setup like:
    - SSH key authentication with password authentication disabled
    - Encryption at Host
    - Azure AD SSH Login extension to enable login using AAD credentials and leverage Azure IAM for VM access
- Configuration of a Linux virtual machine with a very simple cloud-init configuration file

Outside of the Terraform code, this repo is configured to run the Terraform plan with GitHub Actions on a pull request and append the pull request with the output of the plan. Upon closing and merging the pull request, Terraform apply is run. All authentication leverages Azure AD Workload Identies with OIDC tokens issued by GitHub Actions.