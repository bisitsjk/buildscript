#!/bin/bash

# -- Last Modified : Dec 8, 2017 by kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

set -x
CD_APP_NAME=CodeDeploy_"$DEPLOYMENT_GROUP_NAME"_"$DEPLOYMENT_ID"
ASG_TAG_NAME=aws:autoscaling:groupName
SERVER_TAG_NAME=Name
SERVER_TAG_VALUE=SEOUL-EC-PRD-ANALYTICS-API
LB_NAME=EC-PRD-ANALYTICS-API

echo -e "CD_APP_NAME = ${CD_APP_NAME}"

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

# -- Get CD ASG_NAME -- #
RESULTS=`aws ec2 describe-instances  --filter Name=instance-state-name,Values=running Name=tag:${SERVER_TAG_NAME},Values=${SERVER_TAG_VALUE} --query 'Reservations[].Instances[].Tags[].{TKey:Key,TValue:Value}' --region $awsDefaultRegion | grep ${CD_APP_NAME} | cut -d\" -f4`
echo -e "\n${SERVER_TAG_VALUE} ASG NAMES"
for  each_item in ${RESULTS[@]//\"}
do
        CD_ASG_NAME=${each_item}
        break
done

# -- Get CD InstaceID -- #
CD_EC2_ID=$(aws ec2 describe-instances  --filter Name=instance-state-name,Values=running Name=tag:${ASG_TAG_NAME},Values=${CD_ASG_NAME} --query 'Reservations[].Instances[].[InstanceId]'   --region $awsDefaultRegion --output text | awk 'NR==1{print $1}')

# -- Create a New AMI. -- #
IMG_NAME=${SERVER_TAG_VALUE}_$(date +%y%m%d-%H%M)
AMI_ID=$(aws ec2 create-image --instance-id ${CD_EC2_ID} --no-reboot --name $IMG_NAME --description "Golden Image for ${SERVER_TAG_VALUE} Server" --region $awsDefaultRegion --output text)

sleep 1

# -- Check New AMI. -- #
if [ "$AMI_ID" == "" ]; then
	exit 0;
fi

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
aws ec2 create-tags  --resources $AMI_ID --tags Key=Name,Value="${SERVER_TAG_VALUE} Server Image" --region $awsDefaultRegion

# -- Create a New Launch Configuration -- #
LCNAME=LC-$IMG_NAME

aws autoscaling create-launch-configuration \
      --launch-configuration-name ${LCNAME} \
      --image-id $AMI_ID \
      --instance-type m4.large \
      --instance-id $CD_EC2_ID \
      --instance-monitoring Enabled=true --region $awsDefaultRegion

# -- Update a New Launch Configuration -- #
aws autoscaling update-auto-scaling-group \
      --auto-scaling-group-name ${CD_ASG_NAME} \
      --launch-configuration-name ${LCNAME} --region $awsDefaultRegion
      
# -- Update a LB Configuration -- #
aws autoscaling attach-load-balancers \
      --auto-scaling-group-name ${CD_ASG_NAME} \
      --load-balancer-names ${LB_NAME} --region $awsDefaultRegion

# -- Put Policy ASG scale-in -- #
aws autoscaling put-scaling-policy \
	--auto-scaling-group-name ${CD_ASG_NAME} \
	--policy-name PRD-ANALYTICS-API-SCALING-IN \
	--metric-aggregation-type Average \
	--policy-type StepScaling \
	--step-adjustments "MetricIntervalUpperBound=0.0,ScalingAdjustment=-1" \
	--adjustment-type ChangeInCapacity \
	--region ap-northeast-2

P_ARN_IN=$(aws autoscaling describe-policies --auto-scaling-group-name ${CD_ASG_NAME} --policy-name PRD-ANALYTICS-API-SCALING-IN --query 'ScalingPolicies[].PolicyARN[]' --region ap-northeast-2 --output text)

L_ALARM_NM=${CD_ASG_NAME}-Low-CPU-Utilization-$(date +%y%m%d-%H%M)

# -- Put Alarm ASG scale-in -- #
aws cloudwatch put-metric-alarm \
	--alarm-name ${L_ALARM_NM} \
	--actions-enabled \
	--namespace "AWS/EC2" \
	--metric-name CPUUtilization \
	--statistic Average \
	--period 300 \
	--evaluation-periods 1 \
	--threshold 15 \
	--comparison-operator LessThanOrEqualToThreshold \
	--dimensions "Name=AutoScalingGroupName,Value=${CD_ASG_NAME}" \
	--alarm-actions ${P_ARN_IN} \
	--region ap-northeast-2

# -- Put Policy ASG scale-out -- #
aws autoscaling put-scaling-policy \
	--auto-scaling-group-name ${CD_ASG_NAME} \
	--policy-name PRD-ANALYTICS-API-SCALING-OUT \
	--metric-aggregation-type Average \
	--policy-type StepScaling \
	--step-adjustments "MetricIntervalLowerBound=0.0,MetricIntervalUpperBound=15.0,ScalingAdjustment=1" "MetricIntervalLowerBound=15.0,ScalingAdjustment=2" \
	--adjustment-type ChangeInCapacity \
	--region ap-northeast-2

P_ARN_OUT=$(aws autoscaling describe-policies --auto-scaling-group-name ${CD_ASG_NAME} --policy-name PRD-ANALYTICS-API-SCALING-OUT --query 'ScalingPolicies[].PolicyARN[]' --region ap-northeast-2 --output text)

H_ALARM_NM=${CD_ASG_NAME}-High-CPU-Utilization-$(date +%y%m%d-%H%M)

# -- Put Alarm ASG scale-out -- #
aws cloudwatch put-metric-alarm \
	--alarm-name ${H_ALARM_NM} \
	--actions-enabled \
	--namespace "AWS/EC2" \
	--metric-name CPUUtilization \
	--statistic Average \
	--period 300 \
	--evaluation-periods 1 \
	--threshold 35 \
	--comparison-operator GreaterThanOrEqualToThreshold \
	--dimensions "Name=AutoScalingGroupName,Value=${CD_ASG_NAME}" \
	--alarm-actions ${P_ARN_OUT} \
	--region ap-northeast-2

echo
echo "END Script"
echo

# -- End of Code (Lotte.com Deployment)-- #
