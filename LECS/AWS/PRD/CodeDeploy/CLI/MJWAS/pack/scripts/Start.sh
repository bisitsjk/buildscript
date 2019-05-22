#!/bin/bash

# -- Last Modified : Apr 13, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
SEVICE_TYPE="MJ"
SVR_TYPE="WAS"

set -x
ASG_NAME_1SET=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-${SVR_TYPE}-ASG
ASG_NAME_2SET=SEOUL-LECS-PRD-L20${SEVICE_TYPE}-${SVR_TYPE}2-ASG
ASG_NAME=""
ASG_TAG_NAME=aws:autoscaling:groupName
SERVER_TAG_NAME=Name
SERVER_TAG_VALUE=SEOUL-LECS-A-STG-L20${SEVICE_TYPE}-${SVR_TYPE}-01
SECURITY_GROUP="sg-1c228b74 sg-5ef07734 sg-1530997d"

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

# -- Get Not Using ASG -- #
CHECK_CNT=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${ASG_NAME_1SET} --query 'AutoScalingGroups[].MinSize[]' --region $awsDefaultRegion --output text)
CHECK_CNT2=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-name ${ASG_NAME_2SET} --query 'AutoScalingGroups[].MinSize[]' --region $awsDefaultRegion --output text)
if [ ${CHECK_CNT} -eq 0 ]; then
ASG_NAME=${ASG_NAME_1SET}

elif [ ${CHECK_CNT2} -eq 0 ]; then
ASG_NAME=${ASG_NAME_2SET}

else
echo "#### Check ASG Use EC2 Count Deploy Not Available State 1Set MIN Count = ${CHECK_CNT} / 2Set MIN Count = ${CHECK_CNT2} ####"
exit 1;

fi

echo "### Not Using ${ASG_NAME}"

# -- Copy Prd Config -- #

cp /usr1/home/jeus/configfile/config_lecs.xml.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/lecs/config_lecs.xml

cp /usr1/home/jeus/configfile/config_salt.xml.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/salt/config_salt.xml

cp /usr1/home/jeus/configfile/common.xml.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/spring/bean/common.xml

cp /usr1/home/jeus/configfile/interfaces.properties.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/interfaces.properties

cp /usr1/home/jeus/configfile/CancelRefund.properties.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/CancelRefund.properties

cp /usr1/home/jeus/configfile/Mcash.properties.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/Mcash.properties


cp /usr1/home/jeus/configfile/config_muji.xml.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/muji/config_muji.xml

cp /usr1/home/jeus/configfile/LECS-Store-Muji/log4j.xml.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/log4j/log4j.xml

cp /usr1/home/jeus/configfile/spring_properties.properties.main.prd /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/spring/common/spring_properties.properties

sleep 1

sync

sleep 1

sync

sleep 1

sync

sleep 120

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

cp /usr1/home/jeus/configfile/config_lecs.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/lecs/config_lecs.xml

cp /usr1/home/jeus/configfile/config_salt.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/salt/config_salt.xml

cp /usr1/home/jeus/configfile/common.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/spring/bean/common.xml

cp /usr1/home/jeus/configfile/interfaces.properties.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/interfaces.properties

cp /usr1/home/jeus/configfile/CancelRefund.properties.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/CancelRefund.properties

cp /usr1/home/jeus/configfile/Mcash.properties.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/Mcash.properties


cp /usr1/home/jeus/configfile/config_muji.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/system/muji/config_muji.xml

cp /usr1/home/jeus/configfile/LECS-Store-Muji/log4j.xml.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/log4j/log4j.xml

cp /usr1/home/jeus/configfile/spring_properties.properties.main.stg /lotte/lecs/webapp/muji/ROOT/WEB-INF/classes/config/spring/common/spring_properties.properties

sleep 1

# -- Check New LC Update -- #

until [ "$ASG_LCNAME" = "$LCNAME" ]
        do
        ASG_LCNAME=$(aws autoscaling describe-auto-scaling-groups --auto-scaling-group-names $ASG_NAME --query 'AutoScalingGroups[].LaunchConfigurationName[]' --region $awsDefaultRegion --output text)
        echo "ASG_LCNAME = $ASG_LCNAME"
        sleep 5
        done

# -- Update a New Desired Value -- #
NEW_DESIRED=4

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
			break;
		fi
		sleep 1
	done
done

newDate=$(date +%Y%m%d\ %H:%M:%S)
echo
echo $oldDate
echo $newDate

echo "End Script"

# -- End of Code (Lotte.com Deployment)-- #