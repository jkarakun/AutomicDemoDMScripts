# automic-demo-deployment-scripts
Deployment Scripts for Automic demo environments

This repository contains GCP deployment manager template scripts that will create demo instances for Automic, CDD, and other related products.

To execute these you will need:
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
4. Execute:

   `gcloud deployment-manager deployments create aemain-demo-v1 --config aemain-v1-config.yaml --preview`

5. A preview of the environment will be generated that you can review in the [Deployment Manager GUI](https://console.cloud.google.com/dm/deployments)
6. You can deploy the environment by:
   - Click the deploy button in the preview detail window from step 6. (looks like a media play icon)
   - Execute the gcloud command:
     `gcloud deployment-manager deployments update aemain-demo-v1`
   - Or cancel it with the gcloud command (click on the trash icon on the preview window):
     `gcloud deployment-manager deployments cancel aemain-demo-v1`
7. RDP and SSH firewall rules only permit internal IP addresses from the newly created subnetwork to access the machines. It is recommended that you add your personal IP to these rules. Determine your IP by searching ["What's my IP" on google.com](https://www.google.com/search?q=whats+my+ip+address) and adding it to the "aemain-allow-rdp" and "aemain-allow-ssh" firewall rule. Note: A fully defined IP address needs to have /32 at the end of it. EX: 192.168.1.1/32
8. Additional notes:
   - To access the linux machines you will need to add an ssh key to the VM profile.
   - Passwords are the same as the default passwords for the master environment for now.
