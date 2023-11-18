#!/bin/bash

#!/bin/bash

# Prompt for the HTML file name
read -p "Enter the name of the HTML file (including extension): " HTML_FILE

# Check if the HTML file path is provided
if [ -z "$HTML_FILE" ]; then
    echo "Please provide the name of the HTML file."
    exit 1
fi

# Prompt for HTML code
echo -e "\nEnter your HTML code below. Press Ctrl+D when finished:\n"
HTML_CODE=""
while IFS= read -r line; do
    HTML_CODE+="$line"
    HTML_CODE+="\n"
done

# Check if HTML code is provided
if [ -z "$HTML_CODE" ]; then
    echo "Please provide HTML code."
    exit 1
fi

# Save HTML content to the specified file
echo -e "$HTML_CODE" > "$HTML_FILE"

echo "HTML file created successfully: $HTML_FILE"


../create.sh $HTML_FILE
