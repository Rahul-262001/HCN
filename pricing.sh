#!/bin/bash

# Get the list of pods in the Kubernetes cluster
pods=$(kubectl get pods -o jsonpath='{range .items[*]}{.metadata.name}{"\t"}{.metadata.labels.app}{"\t"}{.spec.nodeName}{"\t"}{.status.startTime}{"\n"}{end}')

# Print header
echo -e "System Name\tNode Name\tActive Time\tEarnings"

# Loop through each line (pod) in the output
while read -r line; do
    # Extract pod name, system name, node name, and start time
    pod_name=$(echo "$line" | awk '{print $1}')
    system_name=$(echo "$line" | awk '{print $2}')
    node_name=$(echo "$line" | awk '{print $3}')
    start_time=$(echo "$line" | awk '{print $4}')

    # Calculate active time in hours
    current_time=$(date "+%s")
    start_time_seconds=$(date -d "$start_time" "+%s")
    active_time_seconds=$((current_time - start_time_seconds))
    active_time_hours=$(echo "scale=2; $active_time_seconds / 3600" | bc)

    # Calculate earnings
    earnings=$(echo "scale=2; $active_time_hours * 2.30" | bc)

    # Print the results
    echo -e "$system_name\t$node_name\t$active_time_hours hrs\t₹$earnings"
done <<< "$pods"
