result=$(bash /root/project/payment/all.sh) && curl -d "$result" 10.0.0.11:81/income_alert
