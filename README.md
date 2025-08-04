# SSL Certificate Expiry Checker

A simple Bash script to check the expiry date of SSL certificates for one or more domains.  
It shows how many days are left before the certificate expires and prints an alert if the expiration is near.

## Features

- Checks SSL expiration for multiple domains
- Shows days remaining for each certificate
- Alerts if the certificate will expire soon (default: less than 15 days)
- Easy to integrate with cron jobs, email, or messaging alerts

## Usage

```bash
./ssl_cert_check.sh domain1.com domain2.com ...

By default, the alert threshold is 15 days.
To change the threshold, set the ALERT_DAYS variable inside the script.
