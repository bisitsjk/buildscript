#!/bin/bash

# -- Last Modified : Apr 13, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
SEVICE_TYPE="UQ"
SVR_TYPE="WEB"

set -x
ASG_NAME=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-${SVR_TYPE}-ASG
ASG_TAG_NAME=aws:autoscaling:groupName
SERVER_TAG_NAME=Name
SERVER_TAG_VALUE=SEOUL-LECS-A-STG-L20${SEVICE_TYPE}-${SVR_TYPE}-01
SECURITY_GROUP="sg-1c228b74 sg-f7f0779d sg-1530997d"

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

# -- create file of Launch Configuration User Data -- #
echo "#!/bin/bash" > user-data.txt
echo "sudo yum install amazon-ssm-agent -y" >> user-data.txt
echo "sudo /sbin/start amazon-ssm-agent" >> user-data.txt

# -- Get STG InstaceID -- #
STG_EC2_ID=$(aws ec2 describe-instances  --filter Name=instance-state-name,Values=running Name=tag:${SERVER_TAG_NAME},Values=${SERVER_TAG_VALUE} --query 'Reservations[].Instances[].[InstanceId]'   --region $awsDefaultRegion --output text | awk 'NR==1{print $1}')

# -- Create a New AMI. -- #
IMG_NAME=${SERVER_TAG_VALUE}_$(date +%y%m%d-%H%M)
AMI_ID=$(aws ec2 create-image --instance-id ${STG_EC2_ID} --no-reboot --name $IMG_NAME --description "Golden Image for ${SVR_TYPE^^} Server" --region $awsDefaultRegion --output text)

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
aws ec2 create-tags  --resources $AMI_ID --tags Key=Name,Value="${SVR_TYPE} Server Image" --region $awsDefaultRegion

# -- Create a New Launch Configuration -- #
LCNAME=LC-$IMG_NAME

aws autoscaling create-launch-configuration \
      --launch-configuration-name ${LCNAME} \
      --image-id $AMI_ID \
      --instance-id $STG_EC2_ID \
      --instance-monitoring Enabled=true --region $awsDefaultRegion \
      --security-group $SECURITY_GROUP \
      --user-data file://user-data.txt

sleep 1

# -- Update a New Launch Configuration -- #
aws autoscaling update-auto-scaling-group \
      --auto-scaling-group-name ${ASG_NAME} \
      --launch-configuration-name ${LCNAME} --region $awsDefaultRegion

sleep 1

until [ "$ASG_LCNAME" = "$LCNAME" ]
        do
        ASG_LCNAME=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query 'AutoScalingGroups[].LaunchConfigurationName[]' --region $awsDefaultRegion --output text | awk 'NR==1{print $1}')
        echo "ASG_LCNAME = $ASG_LCNAME"
        sleep 5
        done

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #