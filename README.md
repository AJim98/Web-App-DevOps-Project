# Web-App-DevOps-Project

Welcome to the Web App DevOps Project repo! This application allows you to efficiently manage and track orders for a potential business. It provides an intuitive user interface for viewing existing orders and adding new ones.

## Table of Contents

- [Features](#features)
- [Getting Started](#getting-started)
- [Technology Stack](#technology-stack)
- [Contributors](#contributors)
- [License](#license)

## Features

- **Order List:** View a comprehensive list of orders including details like date UUID, user ID, card number, store code, product code, product quantity, order date, and shipping date.
  
![Screenshot 2023-08-31 at 15 48 48](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/3a3bae88-9224-4755-bf62-567beb7bf692)

- **Pagination:** Easily navigate through multiple pages of orders using the built-in pagination feature.
  
![Screenshot 2023-08-31 at 15 49 08](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/d92a045d-b568-4695-b2b9-986874b4ed5a)

- **Add New Order:** Fill out a user-friendly form to add new orders to the system with necessary information.
  
![Screenshot 2023-08-31 at 15 49 26](https://github.com/maya-a-iuga/Web-App-DevOps-Project/assets/104773240/83236d79-6212-4fc3-afa3-3cee88354b1a)

- **Data Validation:** Ensure data accuracy and completeness with required fields, date restrictions, and card number validation.

## Getting Started

### Prerequisites

For the application to succesfully run, you need to install the following packages:

- flask (version 2.2.2)
- pyodbc (version 4.0.39)
- SQLAlchemy (version 2.0.21)
- werkzeug (version 2.2.3)

### Usage

To run the application, you simply need to run the `app.py` script in this repository. Once the application starts you should be able to access it locally at `http://127.0.0.1:5000`. Here you will be meet with the following two pages:

1. **Order List Page:** Navigate to the "Order List" page to view all existing orders. Use the pagination controls to navigate between pages.

2. **Add New Order Page:** Click on the "Add New Order" tab to access the order form. Complete all required fields and ensure that your entries meet the specified criteria.

## Technology Stack

- **Backend:** Flask is used to build the backend of the application, handling routing, data processing, and interactions with the database.

- **Frontend:** The user interface is designed using HTML, CSS, and JavaScript to ensure a smooth and intuitive user experience.

- **Database:** The application employs an Azure SQL Database as its database system to store order-related data.

## Contributors 

- [Maya Iuga]([https://github.com/yourusername](https://github.com/maya-a-iuga))

## License

This project is licensed under the MIT License. For more details, refer to the [LICENSE](LICENSE) file.


## Delivery Date:

Initially a column for the delivery date was added, via changing the app.py and orders.html (inside the templates folder) files. However it was deemed as unnecessary and a revert was requested, therefore a new branch was created, where git log was used to find the last commit hash made the original Author, which was then used in conjunction with git revert <commit-hash>. Once the remote repository was reverted, the changes were commited and then pushed to the remote repository, which was then merged into the main folder.


## Dockerfile:

A dockerfile was created for the app.py, following instructions in the milestones.

Commands used:

- docker login --  Connects to dockerhub account and allows CLI to interact with it.
- docker build -t project . -- Builds docker images called project in the current directory.
- docker run -p 5000:5000 project -- Runs dockerfile, executing internal code. Go to: http://127.0.0.1:5000 to view content.
- docker tag project username/project -- Tagging the docker image with both username and image name, for easy identification on  dockerhub. This step also prepares the docker image to be pushed to dockerhub.
- docker push username/project -- Pushes docker image to dockerhub.


## Terraform: Networking Module:


In order to deploy the containerized app, onto a kubernetes cluster, the code must be inplemented via infrastructure as code (IaC) and Terraform was the selected method. In order to accomodate this, a directory was created for this procedure, with sub-directories with in it for provisioning both the neccessary azure networking services and kubernetes cluster, each containing variables.tf, main.tf and output.tf files.

The variables.tf file was first created, defining input variables which can be used for configuring and customizing network services based on the application's requirements. The main.tf file was then created, which serves as the main file that is read by terraform during the initialisation process. Here, provider blocks are used to configure azure resources, specifying the provider and includes informaation about features and versions, if needed. Finally, the output.tf file was configured last, which allows for the output data/information to be structured in a way that will allow it to be further used in other parts of the app.

In the output file for the networking module, the following variables were requested as outputs: 
- vnet_id: This stores the ID of the vnet and will be used by the cluster to connect to a later defined Vnet
- control_plane_subnet_id: This stores the ID of the control plane subnet, which will be used to specify the subnet where nodes will be deployed to.
- worker_node_subnet_id: This stored the ID of the worker node subnet, which will specify the subnet where worker nodes, of AKS cluster, will be deployed to.
- aks_nsg_id: This stores the ID of the network security group, which can be used in the AKS cluster for security.

## Terraform: Main Configuration:

During the main configuration for the application, a main.tf file must be created, where code, variables and outputs from other modules will be refferenced. The first to be dedined is an azure provider block, which enables authenticationto azure using service principal credentials, which are found prior to starting the configuration. The service principal app created was then accessed via azure commands to find the following:

- appId --- Service principal's application ID, which is called the client_id in the root's main.tf file.
- password --- Service principal's application password, which is called client_secret in the root's main.tf file.
- subscription_id --- Azure subscription ID, which is used to link the terraform files to the specified azure account.
- tenant --- Azure tenant ID, which represents the microsoft entra directory that manages all related Azure resources, which is called tenant_id in the root's main.tf file.

Having found the above information, the /.zshrc file was accessed and the information was entered as export variables, due to their sensitive nature. Once entered, the command: "source ~/.zshrc" was ran, which refreshes the file and ensures that it is up-to-date and able to read the relevant data. 

Once all files were created the following commands were run:

- terraform init --- This initialises the working directory and installs all required plugins that were specified in the main.tf file.
- terraform plan --- This creates an execution plan, which shows all changes that will be made to the infrastucture.
- terraform apply --- This executes the plan suggested in the previous command creating, updatign or deleting the resources as needed.

After the main configuration file has been provisioned, the kubeconfig file must be accessed, which allows for secure connection to the AKS cluster. This is done using the following command:

- az aks get-credentials --resource-group <your-resource-group> --name <your-aks-cluster-name>

Once retrieved, kubectl can be used to interact with the AKS cluster.


## Kubernetes Deployment to AKS

After completing the previous step and confirming that the kubeconfig file can be accessed, a kubernetes manifest file must be created, which will allow the containerized application to be deployed to kubernetes. To do so, a kubernetes manifest file must be created, where two key definitions must be made: deployment and services, inside a yaml file called application-manifest.yaml.

During the deployment definition stage, a deployment called "flask-app-deployment" is defined, which will act as the central reference point for the containerised application. Following this, the number of replica pods, which will be running concurrently, will be defined as 2, allowing for high availability and scalability. Following this a label was defined, which lets kubernetes identify which pods are managed during deployment. This label will then be used again in the metadata section, establishing the connection between the application and pods.

In order to communicate with the kubernetes cluster, a port on the application must be exposed, to allow access to the user interface, in this case the "Add Delivery" function. Finally, a deployment stratergy must be deployed, which facilitates any updates, for this applciatin a "Rolling Updates" method was selected, which ensures that at least one pod is available for deployment, maintainig application availability.

The next step is to define the kubernetes services, which will allow internal communication within the AKS cluster. This will be added to the application-manifest.yaml file using the --- file. For example:

manifest deployment code
---
manifest services code

Having added this, a service named: "flask-app-service" was defined, allowing refference for internal routing. Followign this, similar to the previous section's definition a label called app: flask-app was also created , ensuring that the traffic properly goes to the relevant pods. Next the exposed ports for both internal and external communication must be defined, 80 for the internal and 5000 for the external communication. Finally, the service type is established, in this case the ClusterIP was used, which designates this file as an internal kubernetes service, completing the application-manifest.yaml file.

Once complete the file can be deployed, using the command: "kubectl port-forward <pod-name> 5000:5000". However, care  must be taken that the correct context is being used, which was defined in the last section and can be checked using: "kubectl config get-contexts", which will list all contexts currently available in the environment, with the current active context having a * next to it. If the correct context if being used the app can be deployed, however if not use the command: "kubectl config use-context <context-name>". Now the command to run the file can be executed and the application can be viewed locally at: "http://127.0.0.1:5000".



## CI/CD Pipeline with Azure DevOps:

Once the application has been deployed to kubernetes, a CI/CD pipeline must be configurated, which will automate the deployment of the application when any changes to the code are pushed to the remote repository. To begin, a new Azure DevOps project must be created, where the pipeline will be hosted. In order to set up the pipeline, connections must be made to the following services:

- Subscription ID
- Github repository
- Docker Hub
- AKS Cluster

These connections are made via: project settings --> service connecntions. Once established, pipeline configuration can begin, which will build and push the previously created docker image and deploy the kubernetes task. To configure this, navigate to the pipeline and click "Create pipeline". Azure will now ask which repository should be used as the source for control, here you will select the previously connected GitHub repository and begin to configure the file, now called azure-pipeline.yaml, to build and push the docker image. This will be done by searching for and selecting the Docker task, where the relevant information was input, as seen in the azure-pipeline.yaml file. Now initial pipelien testing can begin, in this case it can be manually triggered by clicking "Run" and selecting the "main" branch to run this on. Initially, the run will work due to a lack of persmissions, which can be easily resolved by clicking "Permit", after which the run can be monitored. Once completed, visit Docker Hub to verify that the image has been built.

Now that the docker image can be built, the pipeline must be configured so the application can be deployed to kubernetes, using the command: "kubeclt deploy". The pipeline's file will be configured the same way as for the docker file, however this time the "Deploy to Kubernetes" task will be searched for and added, as seen in the azure-pipeline.yaml file. Once set up, the file can also be tested in the same way as before, by manually triggering it on the main branch of the repository. Use the command: "kubectl get pods" to see the status of the pods, which will be "ContainerCreating" before transitioning to "Running". The application can be accessed via the command: "kubectl port-forward <pod-name> 5000:5000".



## AKS Cluster Monitoring

Monitoring is an important aspect of the CI/CD pipeline, which involves the continuous tracking, assessment and managment of deployed resources, ensuring that they are performing as intended and that they are available. Azure's solution to this issue is Azure Monitor, which provides comprehensive monitoring and managament services, such as metrics which provides numerical data realated to the performance and health of azure resources. The insights page is one of the monitoring features available and is used for monitoring containerized workloads, providing data related to the performance and health of AKS Clusters. To activate this feature, go to the "Insights" tab under the "Monitoring" section and begin to configure the container insights, selecting "Enable container logs" followed by configure.

Having set up Azure monitoring, charts can be created from the data that's being monitored. For this application the following charts are created:

- Average Node CPU Usage: Which allows you to track the CPU usage of nodes in the AKS Cluster, ensuring that the system runs efficiently and that resources are properly allocated.
- Average Pod Count: Displays the average number of pods running at any given time.
- Used Disk Percentage: Monitors how much disk space is being utilized.
- Bytes Read and Written per Second: Monitors the rate of data transfer.

To view these charts at any point, access the dashboard.

Log analytics is the next section to configure, which is the go to platform for writing, testing and executing log queries. To access this, go to the "Logs" section under the "Monitoring" tab, where you will be presented with a series of example queries. In this section, the following queries will be explored and then saved:

- Average Node CPU Usage Percentage per Minute: This shows node level data, recorded and displayed per minute.
- Average Node Memory Usage Percentage per Minute: Trakcs the memory usage of the at node level, allowing you to detect memory related issues.
- Pods Counts with Phase: Shows the number of pods in each phase  of it's lifecycle (i.e: pending, running, etc).
- Find Warning Value in Container Logs: Here a "warning" value is searched for, detecting issues and errors within the containers which can be handled swiftly.
- Monitoring Kubernetes Events: This will monitor all kubernetes events, from pod schedueling to erros, tracking the overall health of the cluster.

From the above queries and charts, the "Disk used percentage" will have an alarm created, which will alert the team when the conditions are met - in this case when it os over 90%. This is vital, as it allows for the proactive detection and resolving of error that can result in a performance downgrade or service interruptions. This alert is set up using the following instructions:

- Go to the "Alerts" tab on the "Monitoring" page.
- Click on "Alert rules", in the top ribbon, to create anad manage all rules.
- Click "+Create" to establish this new rule.
- From signal name, select "Disk Used Percentage", as this is the metric that will have alerts sent from.
- Set a threshold that will trigger the alert, in this case 90%
- Configure the time settings. "Check every" determines how often the rule should look for the alert conditions, which will be set to 5 minutes. "Loopback period" determines how far back the rule should look back when searching for the alert condition, which will be set to 15 minutes.

Following this alert, an action group must also be set up, which is a collection of notification prefences and actionsthat can be bundled together to form a response to an alert. Each alert must have an associated action group associated with it, allowing for quick responses to alerts. To create an action group, use the following instructions:

- Click "+Create action group" button.
- Configure basic information: name, display name, subscription and resource group.
- Select the alert type:
-- Email: Sends email to selected members.
-- SMS: Mobile text alert.
-- Push: Sends push alert to Azure App or other configured networks.
-- Voice: Voice message alert is send to mobile.
-- Azure Resource Manager Role: An Azure resource manager is triggered to resolve the issue.
- Click "Review + create"

Additionally, the CPU usage and Memory working set percentage must be modified to trigger when either exceed 80%. This is due to them being critical resources in the AKS Cluster, where if they are utilized, it can lead to decreased application performance and by setting these limits at 80%, proper notification of these resources reaching their limits are given.


## AKS Integration with Azure Key Vault for Secrets Managment

The code found in app.py interacts with the Azure SQL Database, however the credentials for establishing a connection to the database are currently hardcoded into the application's code, posing a security risk. In order to overcome this issue, an Azure Key Vault can be used to stored sensitive information such as passwords, connection string or cryptographic keys. The first step in securing this secretive information is creating an Azure Key Vault, which can be done using the following steps:

- Login to Azure Portal, using the same subscription ID that's associated with the AKS Cluster and kuberntes.
- Search for Key Vaults in the search bar.
- Click "+Create".
- Configure basic information for the Key Vault: name, subscription, resource group, region for vault.
- Click "Review + Click" to review the information.

Once created, access policies and roles must be assigned to all members of the team, specifiying which members can access and perform what actions on the stored secrets. Role Based Accessed Control (RBAC) is the most suitable method to use for this, as it provides a set of predefined roles. This can be done through the Azure portal using the following steps:

- Access the Key Vault's service homepage.
- Select Access control tab (IAM).
- Click "+ Add" and then "Add a role assignment".
- Select the "Key Vault Administrator" role from the list.
- From the Members tab, click "Select members" and assign the relevant member(s).
- Click "Review + assign" to confirm the configuration.

Having granted the appropriate roles to team members, the secrets can now be added to the previously created Key Vault, securing the credentials used to connect to the backend of the database. 

- From Key Vault homepage, access the Secrets tab.
- Click "+ Generate/Import" button to add secret.
- Enter a name for the secret, ideally a descriptive name that reflects the nature of the secret.
- Input the value for the secret.
- Configure any additional settings, such as activation date, as required.
- Click "Create" to finish.
- Repeate for as many secrets as needed.

All created secrets will now appear in the Secrets tab, where they can be modified, replaced or deleted.

In order for the AKS Cluster to access the sensitive information and securely access the database, it must be intergrated into the Azure Key Vault, enabling managed identities for the AKS and assigning the necessary key vault permissions. Managed identities are an important security feature in Azure, which is used to simplify the authentication and authorization for applications, removing the need for the manual managment of credentials and replacing it with an automatically managed identity. For this project, system-assigned managed identities are ideal, as a singular workload is being used, as opposed to the multi-resource user-assigned managed identity. 

In order to enable a managed identity, a command-line interface must b accessed, where you can then log into Azure using the command:
- az login

Following this command, login to the Azure account where the AKS Cluster and Key Vault as stored. The following command can then be used to enable the managed identity for the AKS cluster:
- az aks update --resource-group <resource-group> --name <aks-cluster-name> --enable-managed-identity

Replacing:
- <resource-group> with the name of the resource group of the AKS cluster.
- <aks-cluster-name> witht the name of the AKS cluster.

Having been created and and enabled, the client ID for the identity must be found, which will be used to assign permissions for the AKS cluster to interact with the key vault's secrets. This can be done using the following command:

- az aks show --resource-group <resource-group> --name <aks-cluster-name> --query identityProfile

Similarly to the previous command replace:
- <resource-group> with the name of the resource group of the AKS cluster.
- <aks-cluster-name> witht the name of the AKS cluster.

The clientID, along with other data for the managed identity. Note it down and use it to assign the "Key vault Secrets Officer" role, which provides permissions to read, list, set and delete sercrets, certificates and keys. This is done using the following command:

- az role assignment create --role "Key Vault Secrets Officer" \
  --assignee <managed-identity-client-id> \
  --scope /subscriptions/{subscription-id}/resourceGroups/{resource-group}/providers/Microsoft.KeyVault/vaults/{key-vault-name}

Replacing:
- <managed-identity-client-id> with the previously aquired clientID.
- {subscription-id} with the same ID that both the AKS cluster and kubernetes are assigned.
- {resource-group} with the AKS clsuter's resource group name.
- {key-vault-name} name of the Key vault currently holding the application's secrets.

Once assigned, the Azure Identity and Azure Key Vault libraries can both be integrated into the code, ensuring secure retrival of sensitive information from the Key Vault. Additionally, the Dockerfile must also be updated, including the following libraries are installed:

Libraries to add to Dockerfile requirements.txt file:
- azure-identity
- azure-keyvault-secrets

The following code must be added to the main application's code, replacing the hardcoded data base credentials:

Key vault details:
key_vault_url = <Insert URL here>

Set up Azure Key Vault client with Managed Identity:
credential = ManagedIdentityCredential()
secret_client = SecretClient(vault_url=key_vault_url, credential=credential)

Access the secret values from Key Vault:
Eg: secret = secret_client.get_secret("Server-name")
Server-name = secret_client.get_secret("Server-name").value
Server-password = secret_client.get_secret("Server-password").value
Server-username = secret_client.get_secret("Server-username").value
Database-name =  secret_client.get_secret("Database-name").value

Now the AKS hosted application gains the ability to access the secrets stored in Azure Key Vault, increasing the security of the applciation. 

Having completed the DevOps section of the project, the application must be tested, ensuring that both the application is working as expected. This test will consist of pushing the locally stored repository to github, triggering the CI/CD pipeline and running the command: "kubeclt port-forward <pod-name> 5000:5000". 



