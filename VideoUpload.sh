#!/bin/bash
# filepath: /opt/video-upload.bash

# Usage: /opt/video-upload.bash <full_path_to_mp4>
# "%f" is a placeholder for the full path to the mp4 file.

VIDEO_FILE="$1"
STORAGE_ACCOUNT="<storage-account>"
CONTAINER="videos"
SAS_TOKEN="<your_sas_token>"
source /opt/azure-cli-env/bin/activate

if [ -z "$VIDEO_FILE" ]; then
  echo "No video file specified."
  exit 1
fi

if [ ! -f "$VIDEO_FILE" ]; then
  echo "File not found: $VIDEO_FILE"
  exit 2
fi

# Upload the file to Azure Blob Storage
az  storage blob upload \
  --account-name "$STORAGE_ACCOUNT" \
  --container-name "$CONTAINER" \
  --name "$(basename "$VIDEO_FILE")" \
  --file "$VIDEO_FILE" \
  --sas-token "$SAS_TOKEN" \
  --overwrite

if [ $? -eq 0 ]; then
  echo "Upload successful: $VIDEO_FILE"
else
  echo "Upload failed: $VIDEO_FILE"
