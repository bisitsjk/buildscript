#!/bin/bash

# -- Last Modified : Apr 13, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
SEVICE_TYPE="UQAPI"
SVR_TYPE="WEB"

set -x

CLB_NAME=LECS-PRD-INT-L20UQ-APIWEB

ASG_WEB1=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-${SVR_TYPE}-ASG
ASG_WEB2=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-${SVR_TYPE}2-ASG

ASG_WAS1=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-WAS-ASG
ASG_WAS2=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-WAS2-ASG

ASG_NAME=""
OLD_ASG_NAME=""
OLD_WAS=""
ASG_TAG_NAME=aws:autoscaling:groupName
SERVER_TAG_NAME=Name
SERVER_TAG_VALUE=SEOUL-LECS-A-STG-L20${SEVICE_TYPE}-${SVR_TYPE}-01
SECURITY_GROUP="sg-1c228b74 sg-f7f0779d sg-1530997d"

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

# -- Get Not Using ASG -- #
WEB_CHECK_CNT=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${ASG_WEB1} --query 'AutoScalingGroups[].MinSize[]' --region $awsDefaultRegion --output text)
WEB_CHECK_CNT2=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${ASG_WEB2} --query 'AutoScalingGroups[].MinSize[]' --region $awsDefaultRegion --output text)
WAS_CHECK_CNT=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${ASG_WAS1} --query 'AutoScalingGroups[].MinSize[]' --region $awsDefaultRegion --output text)
WAS_CHECK_CNT2=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${ASG_WAS2} --query 'AutoScalingGroups[].MinSize[]' --region $awsDefaultRegion --output text)


if [ ${WAS_CHECK_CNT} -eq 0 ]; then
echo "#### Check ASG Use EC2 Count Deploy Not Available State WAS 1Set MIN Count = ${WAS_CHECK_CNT} ####"
exit 1;

elif [ ${WAS_CHECK_CNT2} -eq 0 ]; then
echo "#### Check ASG Use EC2 Count Deploy Not Available State WAS 2Set MIN Count = ${WAS_CHECK_CNT2} ####"
exit 1;

else
echo "#### Deploy Available State WAS ####"

fi

if [ ${WEB_CHECK_CNT} -eq 0 ]; then
ASG_NAME=${ASG_WEB1}
OLD_ASG_NAME=${ASG_WEB2}
OLD_WAS=${ASG_WAS2}

elif [ ${WEB_CHECK_CNT2} -eq 0 ]; then
ASG_NAME=${ASG_WEB2}
OLD_ASG_NAME=${ASG_WEB1}
OLD_WAS=${ASG_WAS1}

else
echo "#### Check ASG Use EC2 Count Deploy Not Available State WEB 1Set MIN Count = ${WEB_CHECK_CNT} / 2Set MIN Count = ${WEB_CHECK_CNT2} ####"
exit 1;

fi

echo "### Not Using ${ASG_NAME}"
echo "### Using ${OLD_ASG_NAME}"
echo "### Using ${OLD_WAS}"

# -- Not Using ASG atach CLB -- #

ATACH_CHECK_ELB=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names  $ASG_NAME --query 'AutoScalingGroups[].LoadBalancerNames[]'  --region $awsDefaultRegion --output text)

until [ "$ATACH_CHECK_ELB" != "" ]
do
    echo "ATACH_CHECK_ELB Value = $ATACH_CHECK_ELB"
	aws autoscaling attach-load-balancers --auto-scaling-group-name ${ASG_NAME} --load-balancer-names ${CLB_NAME} --region $awsDefaultRegion
    sleep 5
    ATACH_CHECK_ELB=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names  $ASG_NAME --query 'AutoScalingGroups[].LoadBalancerNames[]'  --region $awsDefaultRegion --output text)
done

# -- create file of Launch Configuration User Data -- #
echo "#!/bin/bash" > user-data.txt
echo "sudo yum install amazon-ssm-agent -y" >> user-data.txt
echo "sudo /sbin/start amazon-ssm-agent" >> user-data.txt

# -- Get STG InstaceID -- #
STG_EC2_ID=$(aws ec2 describe-instances  --filter Name=instance-state-name,Values=running Name=tag:${SERVER_TAG_NAME},Values=${SERVER_TAG_VALUE} --query 'Reservations[].Instances[].[InstanceId]'   --region $awsDefaultRegion --output text)

# -- Create a New AMI. -- #
IMG_NAME=${SERVER_TAG_VALUE}_$(date +%y%m%d-%H%M)
AMI_ID=$(aws ec2 create-image --instance-id ${STG_EC2_ID} --no-reboot --name $IMG_NAME --description "Golden Image for ${SVR_TYPE^^} Server" --region $awsDefaultRegion --output text)

while :
do

amistatus=$(aws ec2 describe-images --image-ids $AMI_ID --query 'Images[].State[]' --region ap-northeast-2 --output text)
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

# -- Check New LC Update -- #

until [ "$ASG_LCNAME" = "$LCNAME" ]
        do
        ASG_LCNAME=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query 'AutoScalingGroups[].LaunchConfigurationName[]' --region $awsDefaultRegion --output text)
        echo "ASG_LCNAME = $ASG_LCNAME"
        sleep 5
        done

# -- Update a New Desired Value -- #
OLD_DESIRED=0
NEW_DESIRED=2
MAX_SIZE=30

aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${ASG_NAME} --desired-capacity $NEW_DESIRED --min-size $NEW_DESIRED --max-size $MAX_SIZE --region $awsDefaultRegion

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

for instID in $(aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=image-id,Values=$AMI_ID --query 'Reservations[].Instances[].InstanceId[]' --region $awsDefaultRegion --output text)
do
	status=$(aws elb describe-instance-health --load-balancer-name $ELB_NAMES --instances $instID --query 'InstanceStates[].State[]' --region $awsDefaultRegion --output text)
	echo "status : $status"
	echo "instID : $instID"
	until [ "$status" = InService ]
	do
		status=$(aws elb describe-instance-health --load-balancer-name $ELB_NAMES --instances $instID --query 'InstanceStates[].State[]' --region $awsDefaultRegion --output text)
		echo "checkstate = $status"
		ec2status=$(aws autoscaling describe-auto-scaling-instances --instance-ids $instID --query 'AutoScalingInstances[].LifecycleState[]' --region $awsDefaultRegion --output text)
		echo "ec2status = $ec2status"
		if [[ "$ec2status" == *"Terminating"* ]]; then
			echo "### Process Something Wrong Check Status ###"
			exit 1;
		fi
		sleep 1
	done
done

# -- Wait 20 Second Service Normalization -- #

sleep 20

# -- OLD ASG detach CLB -- #

DETACH_CHECK_ELB=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names  ${OLD_ASG_NAME} --query 'AutoScalingGroups[].LoadBalancerNames[]'  --region $awsDefaultRegion --output text)

until [ "$DETACH_CHECK_ELB" = "" ]
do
    echo "DETACH_CHECK_ELB Value = $DETACH_CHECK_ELB"
	aws autoscaling detach-load-balancers --auto-scaling-group-name ${OLD_ASG_NAME} --load-balancer-names ${CLB_NAME} --region $awsDefaultRegion
    sleep 5
    DETACH_CHECK_ELB=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names  ${OLD_ASG_NAME} --query 'AutoScalingGroups[].LoadBalancerNames[]'  --region $awsDefaultRegion --output text)
done

# -- Get dereg info -- #

oldinstID=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${OLD_ASG_NAME} --query 'AutoScalingGroups[].Instances[].InstanceId[]' --region ap-northeast-2 --output text)



# -- Decrease a Desire Value of Auto Scaling WEB -- #
aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${OLD_ASG_NAME} --desired-capacity $OLD_DESIRED --min-size $OLD_DESIRED --max-size $OLD_DESIRED --region $awsDefaultRegion

sleep 1

# -- Deregister lb -- #

for deregIDs in $oldinstID
do
	for lbNames in $ELB_NAMES
	do
		aws elb deregister-instances-from-load-balancer --load-balancer-name $lbNames --instances $deregIDs --region $awsDefaultRegion
		echo "#deregIDs : $deregIDs"
		echo "#ELB_NAMES : $lbNames"
	done
done

# -- health Check Deregister lb -- #

for checkIDs in $oldinstID
do
	for checkLBs in $ELB_NAMES
	do
		lbhstatus=$(aws elb describe-instance-health --load-balancer-name $checkLBs --instances $checkIDs --query 'InstanceStates[].State[]' --region $awsDefaultRegion --output text)
		echo "#lbhstatus : $lbhstatus"
		echo "#checkLBs : $checkLBs"
		until [ "$lbhstatus" = "OutOfService" ]
		do
			lbhstatus=$(aws elb describe-instance-health --load-balancer-name $checkLBs --instances $checkIDs --query 'InstanceStates[].State[]' --region $awsDefaultRegion --output text)
			echo "## lbhstatus : $lbhstatus"
			sleep 5
		done
	done
done

sleep 20

echo "#### Deregister target End ####"

newDate=$(date +%Y%m%d\ %H:%M:%S)
echo
echo $oldDate
echo $newDate

# -- Decrease a Desire Value of Auto Scaling WAS -- #
aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${OLD_WAS} --desired-capacity $OLD_DESIRED --min-size $OLD_DESIRED --region $awsDefaultRegion

sleep 1

echo "End Script"

# -- End of Code Deployment -- #