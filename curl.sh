#!/bin/bash

# Function to display usage instructions
usage() {
  echo "Usage: $0 --url <url> --interval <interval> --timeout <timeout> --logfile <logfile>"
  echo "  --url      : The URL to curl"
  echo "  --interval : Interval between requests (seconds)"
  echo "  --timeout  : Timeout for each request (seconds)"
  echo "  --logfile  : Log file to store results"
  exit 1
}

# Parse command line arguments
while [[ $# -gt 0 ]]; do
  key="$1"
  case $key in
    --url)
      URL="$2"
      shift; shift
      ;;
    --interval)
      INTERVAL="$2"
      shift; shift
      ;;
    --timeout)
      TIMEOUT="$2"
      shift; shift
      ;;
    --logfile)
      LOGFILE="$2"
      shift; shift
      ;;
    *)
      usage
      ;;
  esac
done

# Ensure all parameters are provided
if [[ -z "$URL" || -z "$INTERVAL" || -z "$TIMEOUT" || -z "$LOGFILE" ]]; then
  usage
fi

# Print the URL
echo "Monitoring URL: $URL"

# Ensure the log file exists or create it
touch "$LOGFILE"

# Initialize try number
TRY_NO=0

# Indefinite loop
while true; do
  # Increment try number
  TRY_NO=$((TRY_NO + 1))

  # Record start time in milliseconds
  START_SECONDS=$(date +%s)
  START_NANOSECONDS=$(date +%N)
  START_TIME=$((START_SECONDS * 1000 + START_NANOSECONDS / 1000000))

  # Perform curl and capture response
  RESPONSE=$(curl -s -w "%{http_code}" -o /dev/null -m "$TIMEOUT" "$URL")
  CURL_EXIT_CODE=$?

  # Record end time in milliseconds
  END_SECONDS=$(date +%s)
  END_NANOSECONDS=$(date +%N)
  END_TIME=$((END_SECONDS * 1000 + END_NANOSECONDS / 1000000))

  # Calculate response time in milliseconds
  RESPONSE_TIME=$((END_TIME - START_TIME))

  # Handle timeout case
  if [ $CURL_EXIT_CODE -eq 28 ]; then
    RESPONSE_TIME="TIMEOUT"
    RESPONSE="000"
  fi

  # Get current timestamp
  CURRENT_TIME=$(date +"%Y-%m-%d %H:%M:%S")

  # Log to file with key=value pairs
  LOG_ENTRY="time=$CURRENT_TIME, TRY_NO=$TRY_NO, RESPONSE_TIME=$RESPONSE_TIME, STATUS_CODE=$RESPONSE"
  echo "$LOG_ENTRY" | tee -a "$LOGFILE"

  # Wait for the specified interval
  sleep "$INTERVAL"
done
