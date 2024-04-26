import subprocess
import csv
import re

# Run kubectl command to get pod information
kubectl_command = "kubectl get pods -o wide"
pod_info = subprocess.run(kubectl_command, shell=True, capture_output=True, text=True)

# Parse the output and extract relevant information, removing data within parentheses
lines = pod_info.stdout.strip().split('\n')
cleaned_lines = []
for line in lines:
    # Replace multiple consecutive commas with a single comma
    cleaned_line = re.sub(r',{2,}', ',', line)
    cleaned_line = re.sub(r'\(.*?\)', '', cleaned_line)  # Remove data within parentheses
    cleaned_lines.append(cleaned_line.split(','))

# Write the cleaned data to a CSV file
with open('1_pod_info.csv', 'w', newline='') as csvfile:
    writer = csv.writer(csvfile)
    writer.writerows(cleaned_lines)

