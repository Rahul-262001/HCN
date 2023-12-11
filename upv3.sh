#!/bin/bash

clear
figlet -c "Welcome to my Program" | sed 's/./\x1b[31m&\x1b[0m/g'

# List directories in the current location
echo "Directories in the current location:"
ls -l | grep '^d'

# Prompt for the new directory name
read -p "Enter the name of the new directory: " NEW_DIRECTORY_NAME

# Check if the directory name is provided
if [ -z "$NEW_DIRECTORY_NAME" ]; then
    echo "Please provide a name for the new directory."
    exit 1
fi

# Create the new directory
mkdir "$NEW_DIRECTORY_NAME"

# Change into the new directory
cd "$NEW_DIRECTORY_NAME"
clear

# HTML and PHP code for file upload
HTML_FILE="index.php"

echo -e "<?php
$message = '';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get file name and content from the form
    $file_name = isset($_POST['file_name']) ? $_POST['file_name'] : '';
    $file_content = isset($_POST['file_content']) ? $_POST['file_content'] : '';

    // Check if file name and content are provided
    if (empty($file_name) || empty($file_content)) {
        $message = 'Please provide both file name and content.';
    } else {
        // Save file in the same directory
        $file_path = './' . $file_name;
        $result = file_put_contents($file_path, $file_content);

        // Check if file creation was successful
        if ($result !== false) {
            $message = 'File ' . $file_name . ' created successfully.';
        } else {
            $message = 'Error creating file ' . $file_name . '.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>File Creation</title>
    <style>
        /* ... (previous styling) ... */
        .message {
            margin-top: 20px;
            color: #333;
            text-align: center;
        }
    </style>
</head>
<body>
    <form action="" method="post">
        <h1>File Creation Form</h1>
        <label for="file_name">File Name (with extension):</label>
        <input type="text" name="file_name" id="file_name" required>
        <br>
        <label for="file_content">File Content:</label>
        <br>
        <textarea name="file_content" id="file_content" rows="5" cols="40" required></textarea>
        <br>
        <input type="submit" value="Create File" name="submit">
        <div class="message"><?php echo $message; ?></div>
    </form>
</body>
</html>

" > "$HTML_FILE"


echo "HTML file and PHP file created successfully: $HTML_FILE"

DOCKERFILE_NAME="Dockerfile"

# Create a directory for storing uploaded files
mkdir -p uploads

# Generate Dockerfile content
DOCKERFILE_CONTENT=$(cat <<EOF
FROM php:apache

# Enable Apache mod_rewrite
RUN a2enmod rewrite

# Remove default Apache HTML files
RUN rm -rf /var/www/html/*

# Copy your HTML and PHP files
COPY $HTML_FILE /var/www/html/index.php
COPY uploads /var/www/html/uploads

EXPOSE 80

CMD ["apache2-foreground"]
EOF
)

# Save Dockerfile content to the specified file
echo -e "$DOCKERFILE_CONTENT" > "$DOCKERFILE_NAME"

# Check if Dockerfile creation was successful
if [ $? -ne 0 ]; then
    echo "Error creating Dockerfile."
    exit 1
fi

echo "Dockerfile created successfully: $DOCKERFILE_NAME"

# Prompt for Docker Hub repository name
read -p "Enter a name for Docker Hub repository: " DOCKERHUB_REPO

# Check if Docker Hub repository name is provided
if [ -z "$DOCKERHUB_REPO" ]; then
    echo "Please provide a name for Docker Hub repository."
    exit 1
fi

# Build Docker image
docker build -t $DOCKERHUB_REPO:latest .

# Check if Docker build was successful
if [ $? -ne 0 ]; then
    echo "Error building Docker image."
    exit 1
fi

# Tag Docker image
docker tag $DOCKERHUB_REPO:latest serieswatcher/$DOCKERHUB_REPO:latest

# Push Docker image to Docker Hub
docker push serieswatcher/$DOCKERHUB_REPO:latest

# Check if Docker push was successful
if [ $? -ne 0 ]; then
    echo "Error pushing Docker image to Docker Hub."
    exit 1
fi

# Prompt for the name of the Kubernetes deployment
read -p "Enter the name of the Kubernetes deployment: " K8S_DEPLOYMENT_NAME

echo "Please check the port"
kubectl get services
# Prompt for the NodePort value
read -p "Enter the NodePort value (e.g., 30000-32767): " NODE_PORT

# Check if NodePort is provided
if [ -z "$NODE_PORT" ]; then
    echo "Please provide a NodePort value."
    exit 1
fi

# Create deployment.yaml file
echo "apiVersion: apps/v1
kind: Deployment
metadata:
  name: $K8S_DEPLOYMENT_NAME
spec:
  replicas: 1
  selector:
    matchLabels:
      app: $K8S_DEPLOYMENT_NAME
  template:
    metadata:
      labels:
        app: $K8S_DEPLOYMENT_NAME
    spec:
      containers:
      - name: $K8S_DEPLOYMENT_NAME
        image: serieswatcher/$DOCKERHUB_REPO:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: $K8S_DEPLOYMENT_NAME-service
spec:
  selector:
    app: $K8S_DEPLOYMENT_NAME
  ports:
    - protocol: TCP
      port: 80
      targetPort: 80
      nodePort: $NODE_PORT
  type: NodePort" > deployment.yaml

# Apply Kubernetes deployment
kubectl apply -f deployment.yaml

# Check if Kubernetes deployment was successful
if [ $? -ne 0 ]; then
    echo "Error applying Kubernetes deployment."
    exit 1
fi

echo "Workflow completed"
echo "The link is http://10.0.0.8:$NODE_PORT/$HTML_FILE"
