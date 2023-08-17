#!/usr/bin/env bash

PROJECT_ROOT="/home/ubuntu/app"
JAR_FILE="$PROJECT_ROOT/server.jar"
S3_BUCKET_NAME="pre016"


APP_LOG="$PROJECT_ROOT/application.log"
ERROR_LOG="$PROJECT_ROOT/error.log"
DEPLOY_LOG="$PROJECT_ROOT/deploy.log"

TIME_NOW=$(date +%c)

export CREDENTIALS_FILE="/home/ubuntu/service_account.json"


# build 파일 복사
echo "$TIME_NOW > $JAR_FILE 파일 복사!" >> $DEPLOY_LOG
cp $PROJECT_ROOT/build/libs/*.jar $PROJECT_ROOT


# jar 파일 실행
echo "$TIME_NOW > $JAR_FILE 파일 실행" >> $DEPLOY_LOG
nohup java -jar $JAR_FILE > $APP_LOG 2> $ERROR_LOG &

CURRENT_PID=$(pgrep -f $JAR_FILE)
echo "$TIME_NOW > 실행된 프로세스 아이디 $CURRENT_PID 입니다." >> $DEPLOY_LOG

