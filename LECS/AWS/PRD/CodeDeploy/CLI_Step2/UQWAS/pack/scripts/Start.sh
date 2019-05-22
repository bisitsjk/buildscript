#!/bin/bash

# -- Last Modified : Apr 13, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
SEVICE_TYPE="UQ"
SVR_TYPE="WAS"

set -x
ASG_NAME=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-${SVR_TYPE}-ASG
ASG_TAG_NAME=aws:autoscaling:groupName
SERVER_TAG_NAME=Name
SERVER_TAG_VALUE=SEOUL-LECS-A-STG-L20${SEVICE_TYPE}-${SVR_TYPE}-01

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

# -- Get New LC Name & AMI_ID -- #
LCNAME=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query 'AutoScalingGroups[].LaunchConfigurationName[]' --region $awsDefaultRegion --output text | awk 'NR==1{print $1}')
AMI_ID=$(aws autoscaling describe-launch-configurations --launch-configuration-names $LCNAME --region $awsDefaultRegion | grep ImageId | cut -d\" -f4 | awk 'NR==1{print $1}')

# -- Update a New Desired Value (Current Value * 2) -- #
OLD_DESIRED=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query AutoScalingGroups[].DesiredCapacity --region $awsDefaultRegion --output text)
NEW_DESIRED=$(($OLD_DESIRED*2))

aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${ASG_NAME} --desired-capacity $NEW_DESIRED --min-size $NEW_DESIRED --region $awsDefaultRegion

oldDate=$(date +%Y%m%d\ %H:%M:%S)

sleep 60

# -- Print ELBs -- #
ELB_NAMES=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names  $ASG_NAME --query 'AutoScalingGroups[].LoadBalancerNames'  --region $awsDefaultRegion --output text)
for  each_elb in ${ELB_NAMES[@]//\"}
do
    echo "$(aws elb describe-instance-health --load-balancer-name $each_elb --region $awsDefaultRegion  --output text | sort -u)"
    echo ""
done

# -- Check "InService" State of New Deploy Instance -- #

for instID in `aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=image-id,Values=$AMI_ID --region $awsDefaultRegion | grep "InstanceId" | cut -d\" -f4`
#for instID in `aws ec2 describe-instances --filters Name=image-id,Values=$AMI_ID --region $awsDefaultRegion | grep "InstanceId" | cut -d\" -f4`
do
	status=$(aws elb describe-instance-health --load-balancer-name $ELB_NAMES --instances $instID --region $awsDefaultRegion| grep "State" | cut -d\" -f4 | awk 'NR==2{print $1}')
	echo "status : $status"
	echo "instID : $instID"
	until [ "$status" = InService ]
	do
		status=$(aws elb describe-instance-health --load-balancer-name $ELB_NAMES --instances $instID --region $awsDefaultRegion| grep "State" | cut -d\" -f4 | awk 'NR==2{print $1}')
		echo "checkstate = $status"
		ec2status=$(aws autoscaling describe-auto-scaling-instances --instance-ids $instID --region $awsDefaultRegion | grep LifecycleState | cut -d\" -f4)
		echo "ec2status = $ec2status"
		if [[ "$ec2status" == *"Terminating"* ]]; then
			break;
		fi
		sleep 1
	done
done

# -- Decrease a Desire Value of Auto Scaling -- #
aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${ASG_NAME} --desired-capacity $OLD_DESIRED --min-size $OLD_DESIRED --region $awsDefaultRegion

newDate=$(date +%Y%m%d\ %H:%M:%S)
echo
echo $oldDate
echo $newDate

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #