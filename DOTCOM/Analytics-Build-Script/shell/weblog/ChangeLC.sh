#!/bin/bash

# -- Last Modified : Sep 23, 2016 by Megazone
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

set -x
ASG_NAME=SEOUL-EC-A-PRD-ANALYTICS-ASG
ASG_TAG_NAME=aws:autoscaling:groupName
SERVER_TAG_NAME=Purpose
SERVER_TAG_VALUE=SEOUL-EC-A-PRD-ANALYTICS

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

# -- Get InstaceID -- #
RESULTS=`aws ec2 describe-instances  --filter Name=tag:${SERVER_TAG_NAME},Values=${SERVER_TAG_VALUE} --query 'Reservations[].Instances[].[InstanceId]' --region $awsDefaultRegion --output text | sort -u`
echo -e "\n${SERVER_TAG_VALUE} Server IDs"
for  each_item in ${RESULTS[@]//\"}
do
        InstaceID=${each_item}
        break
done

# -- Create a New AMI. -- #
IMG_NAME=${SERVER_TAG_VALUE}_$(date +%y%m%d-%H%M)
AMI_ID=$(aws ec2 create-image --instance-id ${InstaceID} --no-reboot --name $IMG_NAME --description "Golden Image for ${SEVICE_TYPE^^} Server" --region $awsDefaultRegion --output text)

while :
do

amistatus=$(aws ec2 describe-images --image-ids $AMI_ID --region $awsDefaultRegion| grep "State" | cut -d\" -f4)
echo "amistatus : " $amistatus
        if [ "$amistatus" == "available" ]; then
                break;
        fi
        sleep 10
done

# -- Attach a Tag For New AMI -- #
aws ec2 create-tags  --resources $AMI_ID --tags Key=Name,Value="API Server Image" --region $awsDefaultRegion

# -- Get Old Instance ID -- #
INST_ID=$(aws ec2 describe-instances  --filter Name=instance-state-name,Values=running Name=tag:${ASG_TAG_NAME},Values=${ASG_NAME} --query 'Reservations[].Instances[].[InstanceId]'   --region $awsDefaultRegion --output text | awk 'NR==1{print $1}')
LCNAME=LC-$IMG_NAME

# -- Create a New Launch Configuration -- #
aws autoscaling create-launch-configuration \
      --launch-configuration-name ${LCNAME} \
      --image-id $AMI_ID \
      --instance-id $INST_ID \
      --instance-monitoring Enabled=true --region $awsDefaultRegion

# -- Update a New Launch Configuration -- #
aws autoscaling update-auto-scaling-group \
      --auto-scaling-group-name ${ASG_NAME} \
      --launch-configuration-name ${LCNAME} --region $awsDefaultRegion

# --  Remove Old Launch Configuration -- #
#OLD_LCS=`aws autoscaling describe-launch-configurations --query 'LaunchConfigurations[].[LaunchConfigurationName]' --region $awsDefaultRegion --output text | grep $(date +%y%m%d -d "15 day ago")`
#for  old_lc in ${OLD_LCS[@]//\"}
#do
#                aws autoscaling delete-launch-configuration --launch-configuration-name ${old_lc} --region $awsDefaultRegion
#done

echo
echo "END Script"
echo

# -- End of Code (Lotte.com Deployment)-- #
