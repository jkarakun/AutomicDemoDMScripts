#!/usr/bin/env bash
echo "This script will complete a deployment that is in preview mode."
echo "Enter the number of the deployment you want to complete: (type 'q' to exit)"

prev_list=`gcloud deployment-manager deployments list --filter="operation.status='DONE' AND operation.operationType='preview'" --simple-list`

select sel_dep in $prev_list;
do
  case $sel_dep in
    q)
      echo "Exiting script."
      break
      ;;
    *)
      echo "Completing deployment $sel_dep . . ."
      gcloud deployment-manager deployments update $sel_dep
      break
      ;;
  esac
done
