#!/bin/bash

# ssl_cert_check.sh
# Checks SSL certificate expiry for one or more domains

ALERT_DAYS=15

if [ "$#" -lt 1 ]; then
  echo "Usage: $0 domain1 [domain2 ...]"
  exit 1
fi

for domain in "$@"; do
  expiry_date=$(echo | openssl s_client -servername "$domain" -connect "$domain:443" 2>/dev/null \
    | openssl x509 -noout -dates | grep notAfter | cut -d= -f2)
  if [ -z "$expiry_date" ]; then
    echo "ERROR: Could not fetch SSL certificate for $domain"
    continue
  fi
  expiry_seconds=$(date --date="$expiry_date" +%s)
  now_seconds=$(date +%s)
  days_left=$(( (expiry_seconds - now_seconds) / 86400 ))

  if [ "$days_left" -le "$ALERT_DAYS" ]; then
    echo "ALERT: $domain certificate expires in $days_left days! ($expiry_date)"
    # To send email, uncomment the following line:
    # echo "$domain SSL cert expires in $days_left days" | mail -s "SSL Alert" your@mail.com
  else
    echo "OK: $domain certificate expires in $days_left days. ($expiry_date)"
  fi
done
