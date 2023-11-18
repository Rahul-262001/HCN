#!/bin/bash

loading_bar() {
    local duration=$1
    local bar_length=40
    local step=$((100 / bar_length))
    
    for ((i = 0; i <= 100; i += step)); do
        if ((i > 100)); then
            i=100
        fi

        printf "[%-40s] %d%%" "$(printf '=%.0s' $(seq 1 $((i / step))))>" "$i"
        sleep "$duration"
        printf "\r"
    done

    printf "[%-40s] %d%%" "$(printf '=%.0s' $(seq 1 $((i / step))))>" "$i"
    echo -e "\nLoading complete!"
}

loading_bar 0.1  # Adjust the duration based on your preference

