Azure Services as Code<br>(2-day event)
=======================================

 

Looking to deploy complex infrastructure and services in Azure using code which
leads to automation of architecture and solutions in Azure? Whether it’s
PowerShell, ARM Templates, or something else we will dive into learning and
practicing several deployment languages.

In this workshop, participants will gain in-depth knowledge of the deployment
tools for Azure, and understand how to write declarative language to deploy
Azure services.

 

**Workshop topics include:**

-   Azure Deployment Tools (PowerShell, ARM Templates, Terraform, and Azure
    Building Blocks)

    -   Declarative VS. Imperative deployments

    -   Azure Key Vault

    -   Writing ARM Templates in JSON

    -   Understanding Advanced Features of ARM Templates in JSON

    -   Custom Script Extensions for Post Deployment inside OS

**Who should attend:**

-   System & Network Engineers

    -   DevOps Engineers

    -   IT Managers

**Prerequisites:**

-   [AzureRM
    PowerShell](https://docs.microsoft.com/en-us/powershell/azure/install-azurerm-ps)

    -   [Visual Studio Community Edition or/and Visual Studio
        Code](https://www.visualstudio.com/downloads/)

    -   [Terraform](https://www.terraform.io/downloads.html)

    -   [Azure
        CLI](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli?view=azure-cli-latest)
        \| [Node.JS](https://nodejs.org/en/download/) \|
        [azbb](https://github.com/mspnp/template-building-blocks/wiki)

    -   [AzureAD Service Principal - App
        Registrations](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal)
        \\ [Assign as a subscription owner in
        RBAC](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-create-service-principal-portal#assign-application-to-role)

 

**Module 1 - OverView**

 

1.1 Deployment Tools: PS/CLI, ARM Templates, Terraform, AZBB

 

1.2 Writing Tools: Visual Studio Code, Portal Template Editor, Visual Studio

 

[VS Code Extension - IntelliSense  
](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-vscode-extension)

1.3 Reference Tools: [Azure
QuickStarts](https://azure.microsoft.com/en-us/resources/templates/), [Resource
Portal](https://resources.azure.com), [ARM
Reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/storageaccounts),
[World Class
Guide](http://download.microsoft.com/download/8/E/1/8E1DBEFA-CECE-4DC9-A813-93520A5D7CFE/World%20Class%20ARM%20Templates%20-%20Considerations%20and%20Proven%20Practices.pdf),
[Ryan Jones Github](https://github.com/rjmax?tab=repositories)

[Terraform Github ARM
Examples](https://github.com/terraform-providers/terraform-provider-azurerm/tree/master/examples), 
[Terraform Providers](https://www.terraform.io/docs/providers/azurerm/),

[Azure Building Blocks](https://github.com/rjmax?tab=repositories)

**Module 2 - PowerShell**

 

2.1 PowerShell

 

2.2 PowerShell WorkFlow

 

2.3 PowerShell Start-Job

 

**Module 3 - ARM Templates**

 

3.1 Anatomy of an ARM Template (Parameters,Variables,Resources,Ouputs)

 

3.2 Parameters: Type, Default Value, Description, Allowed Values

Use Storage ARM Template as example

 

[EX w/ Functions  
](https://github.com/Azure/azure-docs-json-samples/blob/master/azure-resource-manager/parameterswithfunctions.json)

[EX w/ Objects  
](https://github.com/Azure/azure-docs-json-samples/blob/master/azure-resource-manager/parameterobject.json)

3.3 Variables: Used more than once, reducing complex expressions

 

3.4 Resources: Child Resources VM Extensions, Comments, Tagging -
<https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-manager-templates-resources?toc=%2Fazure%2Ftemplates%2Ftoc.json&bc=%2Fazure%2Ftemplates%2Fbreadcrumb%2Ftoc.json>

 

[EXCSE](https://github.com/swiftsolves-msft/vm-winsrv-language)

[EXMSI](https://github.com/rjmax/IgniteUS2017/blob/master/Chapter06.msiWindowsToKeyvault.json)

 

3.5 Outputs:

<https://github.com/rjmax/IgniteUS2017/blob/master/Chapter06.msiWindowsToKeyvault.json>

[EX PIP  
](https://github.com/Azure/azure-docs-json-samples/blob/master/azure-resource-manager/linkedtemplates/public-ip.json)

 

**Module 4 - ARM Template Functions**

 

4.1 Array and Object Functions

1.  Concat:
    <https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-functions-array#concat>

[EX1](https://github.com/rjmax/ArmExamples/blob/master/concatSample.json)

 

4.2 Numeric Functions

[CopyIndex](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-template-functions-numeric#copyindex)

[EX1](https://github.com/Azure/azure-quickstart-templates/blob/master/201-traffic-manager-webapp/azuredeploy.json)

[EX2](https://github.com/swiftsolves-msft/PaloAltoARMDeployModern/blob/master/azuredeploy.json)

 

 

ListKeys \\ ListValue

 

 

4.3 Resource Functions

Resource Group,resourceID,

 

4.4 String Functions

Concat, splt,

 

**Module 5 - Nesting Templates**

 

[Article](https://docs.microsoft.com/en-us/azure/azure-resource-manager/resource-group-linked-templates)

 

[EX1](https://github.com/johnstel/AzureNetworkLab)

 

[EX2](https://github.com/Azure/azure-docs-json-samples/blob/master/azure-resource-manager/linkedtemplates/static-public-ip-parent.json)

 

**Module 6 - Terraform**

 

6.1 Setup and Authenticate with AAD SPN

 

6.2 Graphviz \| Understand Relationships

 

[Document ](https://www.terraform.io/docs/commands/graph.html)

Terraform graph \| dot  \> graph.dot

 

6.3 Providers, Blocks, and Deploy

EX1

 

**Module 7 - AZBB**

EX1

 

**Module 8 - Build Something**

 

8.1 Building

 

8.2 Show and Tell

 

 
