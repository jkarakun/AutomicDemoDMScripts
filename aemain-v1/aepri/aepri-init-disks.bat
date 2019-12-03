call /b gcloud compute disks create aeprimary-ddrive-v1 --image=aemain-ddrive-img-v4 --zone=us-east1-c --type=pd-ssd
call /b gcloud compute disks create aeprimary-cdrive-v1 --image=aemain-cdrive-img-v4 --zone=us-east1-c --type=pd-ssd
call /b gcloud compute disks create aejenkins-cdrive-v1 --image=aejenkins-img-v4 --zone=us-east1-c --type=pd-ssd
