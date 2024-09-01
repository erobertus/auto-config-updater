#!/bin/bash

# Check if the correct number of arguments are provided
if [ "$#" -ne 7 ]; then
    echo "Usage: $0 <config_file> <config_variable> <start_value> <end_value> <start_date> <end_date> <command>"
    echo "Example: $0 /etc/csf/csf.conf CC_ALLOW_FILTER 'CA,IT' 'CA' '2024-09-18' '2024-10-07' 'csf -ra'"
    exit 1
fi

# Assign arguments to variables
CONFIG_FILE="$1"
CONFIG_VAR="$2"
START_VALUE="$3"
END_VALUE="$4"
START_DATE="$5"
END_DATE="$6"
COMMAND="$7"

# Check if the configuration file exists
if [ ! -f "$CONFIG_FILE" ]; then
    echo "Error: Configuration file '$CONFIG_FILE' not found."
    exit 1
fi

# Get the current date in YYYY-MM-DD format
CURRENT_DATE=$(date +%Y-%m-%d)

# Function to update the configuration variable in the file
update_config() {
    local variable="$1"
    local value="$2"
    local file="$3"
    local changed=0

    # Check if the variable exists and needs to be updated
    if grep -q "^${variable} = " "$file"; then
        current_value=$(grep "^${variable} = " "$file" | cut -d '"' -f 2)
        if [ "$current_value" != "$value" ]; then
            sed -i "s/^${variable} = \".*\"/${variable} = \"${value}\"/" "$file"
            echo "Updated ${variable} to '${value}' in ${file}"
            changed=1
        else
            echo "${variable} is already set to '${value}', no changes made."
        fi
    else
        # If the variable doesn't exist, add it to the file
        echo "${variable} = \"${value}\"" >> "$file"
        echo "Added ${variable} as '${value}' to ${file}"
        changed=1
    fi

    return $changed
}

# Determine the appropriate value based on the date range
if [[ "$CURRENT_DATE" > "$START_DATE" && "$CURRENT_DATE" < "$END_DATE" ]]; then
    # Current date is within the range, set to start value
    update_config "$CONFIG_VAR" "$START_VALUE" "$CONFIG_FILE"
    changed=$?
elif [[ "$CURRENT_DATE" < "$START_DATE" || "$CURRENT_DATE" > "$END_DATE" ]]; then
    # Current date is outside the range, set to end value
    update_config "$CONFIG_VAR" "$END_VALUE" "$CONFIG_FILE"
    changed=$?
else
    # On the exact boundary date, set to start value (customize as needed)
    update_config "$CONFIG_VAR" "$START_VALUE" "$CONFIG_FILE"
    changed=$?
fi

# Execute the command if a change was made
if [ $changed -eq 1 ]; then
    echo "Executing command: $COMMAND"
    $COMMAND
else
    echo "No changes made to ${CONFIG_VAR}, command not executed."
fi
