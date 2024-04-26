#!/bin/bash

#run 1.py and 2.py

python3 /root/project/payment/1.py
python3 /root/project/payment/2.py

# Run 3.py and capture its output
echo "Total earnings per device"
python3 /root/project/payment/3.py

# Run 4.py and capture its output
echo "Monthly earning per device"
python3 /root/project/payment/4.py

