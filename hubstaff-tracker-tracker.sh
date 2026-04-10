#!/bin/bash

# Grab script path
SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &> /dev/null && pwd)
LOG="$SCRIPT_DIR/gaps.log"

# Initialize just in case script starts in the middle to
# prevent weird stuff from happening
gaps=()
prev_time=0
curr_time=0

format_time() {
    local seconds=$1
    local minutes=$(( seconds / 60 ))
    local secs=$(( seconds % 60 ))
    echo "${minutes}m ${secs}s"
}

while IFS= read -r line; do

    # This is what should be before the dbus notification. We're just
    # grabbing every time and then using only the relevant ones
    if [[ "$line" == *"method call time"* ]]; then

        last_seen_time=$(echo "$line" | awk -F'[= .]' '{print $4}')
        
    # Script must be running before timer starts to 'lock in' the starting point
    # and initialize the variables
    elif [[ "$line" == *"Started timer"* ]]; then

        echo "Hubstaff timer started!"
        gaps=()
        prev_time=0
        curr_time=0
        count=0

    elif [[ "$line" == *"Screenshot taken"* ]]; then

        # Handle first edge case so we don't do math on null
        if [[ $prev_time -eq 0 ]]; then
            prev_time=$last_seen_time
            curr_time=$last_seen_time

        # Otherwise, calculate the gap and add to the array
        else
            prev_time=$curr_time
            curr_time=$last_seen_time
            gap=$(( curr_time - prev_time ))
            gaps+=($gap)
        fi

    # Once the timer is stopped, the calculations happen and echo to gaps.log
    # The script may be stopped after this point
    elif [[ "$line" == *"Stopped timer"* ]]; then

        echo "Hubstaff timer stopped!"
        smallest=${gaps[0]}
        largest=${gaps[0]}
        average=0

        for gap in "${gaps[@]}"; do
            count=$(( count + 1 ))
            average=$((average + $gap ))

            if [[ $gap -lt $smallest ]]; then
                smallest=$gap
            fi

            if [[ $gap -gt $largest ]]; then
                largest=$gap
            fi
        done

        if [[ $count -eq 0 ]]; then
            echo "----------" >> "$LOG"
            echo "$(date)" >> "$LOG"
            echo "----------" >> "$LOG"
            echo "No screenshots taken this session" >> "$LOG"
            echo "" >> "$LOG"
        else
            average=$(( average / count ))

            echo "----------" >> "$LOG"
            echo "$(date)" >> "$LOG"
            echo "----------" >> "$LOG"
            echo "Amount of screenshots taken: $((count + 1))" >> "$LOG"
            echo "Average time between screenshots: $(format_time $average)" >> "$LOG"
            echo "Largest gap: $(format_time $largest)" >> "$LOG"
            echo "Smallest gap: $(format_time $smallest)" >> "$LOG"
            echo "" >> "$LOG"
        fi
    fi

done < <(dbus-monitor "interface='org.freedesktop.Notifications'" 2>/dev/null)
