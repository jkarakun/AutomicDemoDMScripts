# automic-demo-deployment-scripts
 Deployment Scripts for Automic demo environments

This repostiory contains GCP deployment manager template scripts that will create demo instances for Automic, CDD, and other related products. 

To execute these you will need access to the private demo images on our GCP account. 

To execute these deployment scripts in your own GCP project:
1. Copy this repository to a location where you can run the gcloud command.
2. Ensure the following GCP services are activated: Deployment Manager, Cloud DNS, Compute
3. Go to the aemain-v1\templates directory
4. Edit the parameters in aemain-v1-config.yaml to deploy in your preferred region and zone. The 'stamp' value allows you to personalize all the base-names of the objects created. It is not necessary to change this, but it cannot be NULL.
5. Execute: 
    gcloud deployment-manager deployments create aemain-demo-v1 -config aemain-v1-config.yaml --preview
    
6. A preview of the environment will be generated that you can review and, if you choose, deploy.
7. Review the configuration and click the deploy button (looks like a media play icon) if you want to crate all the resources.
8. RDP and SSH firewall rules only permit internal IP addresses from the newly created subnetwork to access the machines. It is recommended that you add your personal IP to these rules. Determine your IP by seaching "Whats my IP" in google. 
   - To access the linux machines you will need to add an ssh key to the VM profile. 
   - Passwords are the same as the default passwords for the master environment for now. 
