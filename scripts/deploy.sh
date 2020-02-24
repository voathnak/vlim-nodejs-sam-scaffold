#!/usr/bin/env bash

source scripts/config.sh

aws s3api 	--profile "$PROFILE" create-bucket \
			--bucket "$S3_BUCKET" \
			--region "$REGION"

sam package --profile "$PROFILE" \
			--template-file "$INPUT_FILE" \
			--output-template-file "$OUTPUT_FILE" \
			--s3-bucket "$S3_BUCKET"

sam deploy 	--profile "$PROFILE" \
			--region "$REGION" \
			--template-file "$OUTPUT_FILE" \
			--s3-bucket "$S3_BUCKET" \
			--stack-name "$STACK_NAME" \
			--parameter-overrides \
				StageName="$STAGE_NAME" \
				DeploymentS3BucketName="$S3_BUCKET" \
				AppName="$APP_NAME" \
			--capabilities CAPABILITY_IAM
