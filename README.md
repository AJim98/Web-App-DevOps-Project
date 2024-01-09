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