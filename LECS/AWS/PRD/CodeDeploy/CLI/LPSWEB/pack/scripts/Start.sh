#!/bin/bash

# -- Last Modified : Apr 13, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
SEVICE_TYPE="LPS"
SVR_TYPE="WEB"

set -x

LPS_T_ARN="arn:aws:elasticloadbalancing:ap-northeast-2:313526127569:targetgroup/LECS-PRD-L20UQLPS-WEB-80/1273ab1962025ef3 arn:aws:elasticloadbalancing:ap-northeast-2:313526127569:targetgroup/LECS-PRD-L20GULPS-WEB-80/4c8813dcfb77f968 arn:aws:elasticloadbalancing:ap-northeast-2:313526127569:targetgroup/LECS-PRD-L20MJLPS-WEB-80/50cd86a9c481bb3d"

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
SECURITY_GROUP="sg-1c228b74 sg-659a8b0e sg-1530997d"

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

# -- Not Using ASG atach Target -- #
ATACH_CHECK_TARGET=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query 'AutoScalingGroups[].TargetGroupARNs[]' --region $awsDefaultRegion --output text)

until [ "$ATACH_CHECK_TARGET" != "" ]
do
    echo "ATACH_CHECK_TARGET Value = $ATACH_CHECK_TARGET"
	aws autoscaling attach-load-balancer-target-groups --auto-scaling-group-name ${ASG_NAME} --target-group-arns ${LPS_T_ARN} --region $awsDefaultRegion
    sleep 5
    ATACH_CHECK_TARGET=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query 'AutoScalingGroups[].TargetGroupARNs[]' --region $awsDefaultRegion --output text)
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

# -- Check State of New Deploy Instance -- #
ELB_TARGET_NAMES=$(aws autoscaling describe-load-balancer-target-groups --auto-scaling-group-name $ASG_NAME --query 'LoadBalancerTargetGroups[].LoadBalancerTargetGroupARN' --region $awsDefaultRegion --output text)
for each_elb_target in ${ELB_TARGET_NAMES[@]//\"}
do
	for instID in $(aws ec2 describe-instances --filters Name=instance-state-name,Values=running Name=image-id,Values=$AMI_ID --query 'Reservations[].Instances[].InstanceId[]' --region $awsDefaultRegion --output text) 
	do
		status=$(aws elbv2 describe-target-health --targets Id=$instID,Port=80 --target-group-arn $each_elb_target --query 'TargetHealthDescriptions[].TargetHealth[].State[]' --region ap-northeast-2 --output text)
		echo "status : $status"
		echo "instID : $instID"
		until [ "$status" = healthy ]
		do
			status=$(aws elbv2 describe-target-health --targets Id=$instID,Port=80 --target-group-arn $each_elb_target --query 'TargetHealthDescriptions[].TargetHealth[].State[]' --region ap-northeast-2 --output text);
			echo "checkstate ="$status
			ec2status=$(aws autoscaling describe-auto-scaling-instances --instance-ids $instID --query 'AutoScalingInstances[].LifecycleState[]' --region $awsDefaultRegion --output text)
			echo "ec2status = $ec2status"
			if [[ "$ec2status" == *"Terminating"* ]]; then
				echo "### Process Something Wrong Check Status ###"
				exit 1;
			fi
			sleep 1
		done
	done
done

# -- Wait 20 Second Service Normalization -- #

sleep 20

# -- OLD ASG detach Target -- #

DETACH_CHECK_TARGET=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${OLD_ASG_NAME} --query 'AutoScalingGroups[].TargetGroupARNs[]'  --region $awsDefaultRegion --output text)

until [ "$DETACH_CHECK_TARGET" = "" ]
do
    echo "DETACH_CHECK_TARGET Value = $DETACH_CHECK_TARGET"
	aws autoscaling detach-load-balancer-target-groups --auto-scaling-group-name ${OLD_ASG_NAME} --target-group-arns ${LPS_T_ARN} --region $awsDefaultRegion
    sleep 5
    DETACH_CHECK_TARGET=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${OLD_ASG_NAME} --query 'AutoScalingGroups[].TargetGroupARNs[]'  --region $awsDefaultRegion --output text)
done

# -- Get dereg info -- #

oldinstID=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names ${OLD_ASG_NAME} --query 'AutoScalingGroups[].Instances[].InstanceId[]' --region ap-northeast-2 --output text)



# -- Decrease a Desire Value of Auto Scaling WEB -- #
aws autoscaling update-auto-scaling-group --auto-scaling-group-name ${OLD_ASG_NAME} --desired-capacity $OLD_DESIRED --min-size $OLD_DESIRED --max-size $OLD_DESIRED --region $awsDefaultRegion

sleep 1

# -- Deregister target -- #

for deregIDs in $oldinstID
do
	for targetARNs in $ELB_TARGET_NAMES
	do
		aws elbv2 deregister-targets --target-group-arn $targetARNs --targets Id=$deregIDs --region ap-northeast-2
		echo "#deregIDs : $deregIDs"
		echo "#ELB_TARGET_NAMES : $targetARNs"
	done
done

# -- health Check Deregister target -- #

for checkIDs in $oldinstID
do
	for checkARNs in $ELB_TARGET_NAMES
	do
		thstatus=$(aws elbv2 describe-target-health --targets Id=$checkIDs,Port=80 --target-group-arn $checkARNs --query 'TargetHealthDescriptions[].TargetHealth[].State[]' --region ap-northeast-2 --output text)
		echo "#thstatus : $thstatus"
		echo "#checkIDs : $checkIDs"
		until [ "$thstatus" = draining ]
		do
			thstatus=$(aws elbv2 describe-target-health --targets Id=$checkIDs,Port=80 --target-group-arn $checkARNs --query 'TargetHealthDescriptions[].TargetHealth[].State[]' --region ap-northeast-2 --output text)
			echo "## thstatus : $thstatus"
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