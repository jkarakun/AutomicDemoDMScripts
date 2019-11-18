# automic-demo-deployment-scripts
Deployment Scripts for Automic demo environments

This repository contains GCP deployment manager template scripts that will create demo instances for Automic, CDD, and other related products.

### Deployment of Environment

To execute these you will need-
+ A GCP account and project space.
+ The [Google Cloud SDK](https://cloud.google.com/sdk/docs/) installed or use the [Google Cloud ](https://cloud.google.com/shell/docs/)
+ Access to the private demo images on the Broadcom ESD demo project.
  - **For Broadcom Employees**: e-mail **marc.carkeek@broadcom.com** your "Google APIs Service Agent" member account. This can be found in the [IAM Gui](https://console.cloud.google.com/iam-admin/iam).
  - **For Partners**: Contact your primary Broadcom contact.
  - I'll grant you access as soon as I am able and let you know by e-mail.
+ The following API's enabled:
  - [Deployment Manager V2 API](https://console.cloud.google.com/apis/library/deploymentmanager.googleapis.com?q=deploy)
  - [Cloud DNS API](https://console.cloud.google.com/apis/library/dns.googleapis.com?q=cloud%20dns)
  - [Compute API](https://console.cloud.google.com/apis/library/compute.googleapis.com?q=compute)

To execute these deployment scripts in your own GCP project:
1. Copy this repository to a location where you can run the gcloud command.

2. Go to the aemain-v1/templates directory of the copied repository.

3. Edit the parameters in aemain-v1-config.yaml to deploy in your preferred region and zone. The 'stamp' value allows you to personalize all the base-names of the objects created. It is not necessary to change this, but it cannot be NULL.

4. In the Google Cloud SDK environment execute (note: you can change the name of the deployment: 'aemain-demo-v1'):

   `gcloud deployment-manager deployments create aemain-demo-v1 --config aemain-v1-config.yaml --preview`

5. A preview of the environment will be generated that you can review in the [Deployment Manager GUI](https://console.cloud.google.com/dm/deployments)

6. You can deploy or cancel the environment once you have reviewed the deployment:
  * **Deploy option 1** - Executing the gcloud command:  
     `gcloud deployment-manager deployments update aemain-demo-v1`
  * **Deploy option 2** - In the [Deployment Manager GUI](https://console.cloud.google.com/dm/deployments):  
    click on the right arrow next to Deploy in the Deployment preview/detail window
  * **Cancel option 1** - Execute the gcloud command:  
     `gcloud deployment-manager deployments cancel aemain-demo-v1`
  * **Cancel option 2** - Clicking on the trash icon on the Deployment preview/detail window)

### Post-Deployment Steps and Information:

##### Set firewall rules to allow access. . . but not too much access
RDP and SSH firewall rules only permit internal IP addresses from the newly created subnetwork by default. It is recommended that you add **ONLY** your personal IPV4 address(es) or a **VERY LIMITED** CIDR Block. (Ex: 192.168.1.1/32 gives access to only that IP address. 192.168.1.1/24 gives access the range 192.168.1.1 - 192.168.1.255)
1. Determine your IP by going to [What Is My IP Address](https://whatismyipaddress.com/). You will need the IPV4 address.
2. Add this the "aemain-allow-rdp-???" and "aemain-allow-ssh-???" firewall rule. **Note:** A fully defined IP address needs to have /32 at the end of it. For more informaiton EX: 192.168.1.1/32

8. Additional notes:
   - To access the linux machines you will need to add an ssh key to the VM profile.
   - Passwords are the same as the default passwords for the master environment for now.

##### Add your GCP project credentials to Automic
You will need to add your service account credentials to Automic so it can provision temporary VM's for deployments.  
To get your credentials:
1. Go to [Create service account key](https://console.cloud.google.com/apis/credentials/serviceaccountkey) on GCP.  
2. Select your **"Compute Engine default service account"**.  
3. Select **JSON** for the key type and click **Create**.
4. In the AWI open the **Release Automation** perspective.  
5. Navigate to Provisioning > Infrastructure Providers
6. Click the Add button in the toolbar.
7. In the dialog, enter an infrastructure provider name (EX: GCP_MYDEMO).
8. Select **Google Cloud** for type and click **Next**.  
9. In the next dialog select the JSON file you downloaded in step 3 and click **ADD**.

##### Update GCP project setting variables.
1. In the AWI client click in the search box in the upper right and type **VARA.GCP.INFO**
2. Click on the Vara object it finds to edit it. 
3. Update the variables so they match the settings for your project. Values can be  

| Variable | Desc | Value | 
| ------------ | ------------- | ------------- |
| IM_PROVIDER| Infra. Provider (CDA) | Provider name created in step 7 of previous section (EX: GCP_MYDEMO) |
| PROJECT | GCP Project Name | Can be displayed by executing the following command on AEMAIN VM:  `curl "http://metadata.google.internal/computeMetadata/v1/project/project-id" -H "Metadata-Flavor: Google"` |
| REGION | GCP Region of Deployed Demo | Ex: 'us-east1'. Can be displayed by executing the following command on AEMAIN VM:  `curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google"` |
| SERVICEACCOUNT | GCP "Compute Engine default service account" | Can be found in [IAM Gui](https://console.cloud.google.com/iam-admin/iam). |
| SUBNETWORK | Subnetwork of deployed demo system | Set by deployment: aemain-v1-subnet-**STAMP VALUE** (Ex: aemain-v1-subnet-mine) |
| ZONE | GCP Zone of Deployed Demo | Ex: 'us-east1-c'. Can be displayed by executing the following command on AEMAIN VM:  `curl "http://metadata.google.internal/computeMetadata/v1/instance/zone" -H "Metadata-Flavor: Google"` |

##### Working with the demo system.

