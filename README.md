# terraform-azure-demo

This repo contains code that demonstrates how to use Terraform to manage Azure resources and shows the differences between Terraform OSS and Enterprise.

## Terraform OSS workflow

Make sure you have Terraform version 0.12.16 or later installed and your environment with valid Azure credentials.
Change your working directory the `oss` folder and the initialize the Terraform working directory to download the required modules and providers.

```bash
cd oss
terraform init
```

After the working directory is initalized some variables have to be set using the `terraform.tfvars` file. Customize the environment and owner name to your liking. An example file called `terraform.tvfars.example`is provided as reference.

Make sure you are authenticated using the [Azure CLI][1]. Apply the Terraform configuration, show plan and apply the configuration.

```bash
terraform apply
```

Login to the Azure portal show all resources that are created.

After everything is up and running add some changes, for that remove the comments from the `lb.tf` and `vm.tf`file. Then apply the new configuration. Make sure you show the plan / changes before applying the new configuration.


# Terraform Enterprise Workflow

Make sure workspace `azure-demo-app` is destroy, if not queue a destroy plan and destroy an preexisting environment.

[1]: https://www.terraform.io/docs/providers/azurerm/guides/azure_cli.html