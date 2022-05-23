#Manually retrieve the most recent fully qualified digest for the image.

# This will ensure that a service is only redeployed if the image has been updated
# This will require you to run 'gcloud builds submit', or similar, separately.

PROJECT=$1
IMAGE=$2

# deep JSON is invalid for terraform, so serve flat value
LATEST=$(gcloud container images describe gcr.io/${PROJECT}/${IMAGE}:latest  --format="value(image_summary.fully_qualified_digest)" | tr -d '\n')
echo "{\"image\": \"${LATEST}\"}"