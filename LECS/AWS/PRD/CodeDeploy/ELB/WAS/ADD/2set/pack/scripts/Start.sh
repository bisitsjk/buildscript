#!/bin/sh

# -- Last Modified : jul 09, 2018 by Kjjung
echo -e "\n\n"
echo "======================================================="
echo "    Deploying time is [ $(TZ="Asia/Seoul" date --rfc-3339=seconds) ]"
echo "======================================================="

# Define some Env Variables
#BO1_EC2_ID="i-08ecd7a379923fdf2"
BO2_EC2_ID="i-06f5497211b358303"
#CC1_EC2_ID="i-0a1a92f3f4e75f204"
CC2_EC2_ID="i-08751c93358190bbe"
#PO1_EC2_ID="i-0001345b33380977d"
PO2_EC2_ID="i-046773f393190d297"

BOWAS_ELB_NAME="LECS-PRD-INT-L20BO-WAS"
CCWAS_ELB_NAME="LECS-PRD-INT-L20CC-WAS"
POWAS_ELB_NAME="LECS-PRD-INT-L20PO-WAS"

set -x

# -- Get AZ Name & Region Name -- #
EC2_AVAIL_ZONE=`curl -s http://169.254.169.254/latest/meta-data/placement/availability-zone`
export AWS_DEFULAT_REGION="`echo \"$EC2_AVAIL_ZONE\" | sed -e 's:\([0-9][0-9]*\)[a-z]*\$:\\1:'`"
awsDefaultRegion=$AWS_DEFULAT_REGION

echo "Add was 2set ..."

aws elb register-instances-with-load-balancer --load-balancer-name $BOWAS_ELB_NAME --instances $BO2_EC2_ID --region $awsDefaultRegion
#aws elb deregister-instances-from-load-balancer --load-balancer-name $BOWAS_ELB_NAME --instances $BO1_EC2_ID --region $awsDefaultRegion

sleep 1

aws elb register-instances-with-load-balancer --load-balancer-name $CCWAS_ELB_NAME --instances $CC2_EC2_ID --region $awsDefaultRegion
#aws elb deregister-instances-from-load-balancer --load-balancer-name $CCWAS_ELB_NAME --instances $CC1_EC2_ID --region $awsDefaultRegion

sleep 1

aws elb register-instances-with-load-balancer --load-balancer-name $POWAS_ELB_NAME --instances $PO2_EC2_ID --region $awsDefaultRegion
#aws elb deregister-instances-from-load-balancer --load-balancer-name $POWAS_ELB_NAME --instances $PO1_EC2_ID --region $awsDefaultRegion

sleep 1

until [ "$status" = InService ]
	do
		status=$(aws elb describe-instance-health --load-balancer-name $BOWAS_ELB_NAME --instances $BO2_EC2_ID --region $awsDefaultRegion | grep State | cut -d\" -f4 | awk 'NR==2{print $1}');
		echo "checkstate ="$status
		sleep 5
	done

until [ "$status" = InService ]
	do
		status=$(aws elb describe-instance-health --load-balancer-name $CCWAS_ELB_NAME --instances $CC2_EC2_ID --region $awsDefaultRegion | grep State | cut -d\" -f4 | awk 'NR==2{print $1}');
		echo "checkstate ="$status
		sleep 5
	done

until [ "$status" = InService ]
	do
		status=$(aws elb describe-instance-health --load-balancer-name $POWAS_ELB_NAME --instances $PO2_EC2_ID --region $awsDefaultRegion | grep State | cut -d\" -f4 | awk 'NR==2{print $1}');
		echo "checkstate ="$status
		sleep 5
	done


echo
echo "END Script"
echo


# -- End of Code (Lotte.com Deployment)-- #