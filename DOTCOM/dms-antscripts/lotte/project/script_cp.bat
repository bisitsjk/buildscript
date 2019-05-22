@echo off
SET CopyDir="./lotte/project/*"
SET ToDir="D:/deployer/scripts"
echo ================== START COPY BUILD SCRIPT ==================
xcopy /S /F /Y %CopyDir% %ToDir%
if %errorlevel% neq 0 (
	echo Fail Copy..!
	exit 1	
	) else (
		echo Seccess Copy To %ToDir% 
	exit 0
	)