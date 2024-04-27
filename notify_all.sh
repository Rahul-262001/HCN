cd payment 
result=$(./all.sh) && curl -d "$result" 10.0.0.11:81/income_alert
cd ..
