from collections import defaultdict

with open('output.csv', 'r') as file:
     input_data= file.read()

# Split the input data into lines
lines = input_data.strip().split('\n')

# Skip the header line
lines = lines[1:]

# Initialize a dictionary to store node names and total ages
node_ages = defaultdict(int)

# Extract node name and age, and accumulate ages for each node
for line in lines:
    columns = line.split(',')
    node_name = columns[6]
    age = int(columns[4].replace('d', ''))  # Remove 'd' and convert age to int
    node_ages[node_name] += age

# Multiply total age by 15 for each node and print the result
for node, total_age in node_ages.items():
    result = (total_age%30) * 15
    print(f"Node: {node}\n Total Age: {total_age%30}, Result: {result}")
