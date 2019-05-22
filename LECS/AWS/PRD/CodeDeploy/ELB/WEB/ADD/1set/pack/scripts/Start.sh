#!/bin/sh

# -- Last Modified : jul 09, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
BO1_EC2_ID="i-015e8a9b1e8c3981c"
#BO2_EC2_ID="i-0bc64328ecd6991e3"
CC1_EC2_ID="i-059d6329083d8a6de"
#CC2_EC2_ID="i-01a712c6fcd42bd8e"
PO1_EC2_ID="i-034513d4adb7b69bb"
#PO2_EC2_ID="i-0123c0a9449df2e8f"

BOWEB_T_ARN="arn:aws:elasticloadbalancing:ap-northeast-2:313526127569:targetgroup/LECS-PRD-L20BO-WEB-80/c54ac6470adb76f3"
CCWEB_T_ARN="arn:aws:elasticloadbalancing:ap-northeast-2:313526127569:targetgroup/LECS-PRD-L20CC-WEB-80/af8647d26785f0ec"
POWEB_T_ARN="arn:aws:elasticloadbalancing:ap-northeast-2:313526127569:targetgroup/LECS-PRD-L20PO-WEB-80/ca1a2cf43229a398"

set -x

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

echo "Add web 1set ..."

aws elbv2 register-targets --target-group-arn $BOWEB_T_ARN --targets Id=$BO1_EC2_ID --region $awsDefaultRegion

sleep 1

aws elbv2 register-targets --target-group-arn $CCWEB_T_ARN --targets Id=$CC1_EC2_ID --region $awsDefaultRegion

sleep 1

aws elbv2 register-targets --target-group-arn $POWEB_T_ARN --targets Id=$PO1_EC2_ID --region $awsDefaultRegion

sleep 1

until [ "$status" = healthy ]
	do
		status=$(aws elbv2 describe-target-health --targets Id=$BO1_EC2_ID,Port=80 --target-group-arn $BOWEB_T_ARN --region $awsDefaultRegion | grep State | cut -d\" -f4);
		echo "checkstate = $status"
		sleep 5
	done

until [ "$status" = healthy ]
	do
		status=$(aws elbv2 describe-target-health --targets Id=$CC1_EC2_ID,Port=80 --target-group-arn $CCWEB_T_ARN --region $awsDefaultRegion | grep State | cut -d\" -f4);
		echo "checkstate = $status"
		sleep 5
	done

until [ "$status" = healthy ]
	do
		status=$(aws elbv2 describe-target-health --targets Id=$PO1_EC2_ID,Port=80 --target-group-arn $POWEB_T_ARN --region $awsDefaultRegion | grep State | cut -d\" -f4);
		echo "checkstate = $status"
		sleep 5
	done


echo
echo "END Script"
echo


# -- End of Code (Lotte.com Deployment)-- #
