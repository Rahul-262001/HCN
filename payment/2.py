import csv

# Read input from file
with open('1_pod_info.csv', 'r') as file:
    data = file.read()

# Convert text data to CSV format
csv_data = []
lines = data.strip().split('\n')
for line in lines:
    row = [x.strip() for x in line.split()]
    csv_data.append(row)

# Write CSV data to a new file
with open('output.csv', 'w', newline='') as csvfile:
    csv_writer = csv.writer(csvfile)
    csv_writer.writerows(csv_data)

