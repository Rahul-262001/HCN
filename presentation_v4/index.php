<?php
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    // Get file name and content from the form
    $file_name = $_POST['file_name'];
    $file_content = $_POST['file_content'];

    // Check if file name and content are provided
    if (empty($file_name) || empty($file_content)) {
        echo 'Please provide both file name and content.';
    } else {
        // Save file in the same directory
        $file_path = './' . $file_name;
        $result = file_put_contents($file_path, $file_content);

        // Check if file creation was successful
        if ($result !== false) {
            echo 'File ' . $file_name . ' created successfully.';
        } else {
            echo 'Error creating file ' . $file_name . '.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Home Computing Network</title>
    <style>
        body {
            font-family: 'Arial', sans-serif;
            background-color: #e6f7ff; /* Light Blue */
            margin: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }

        h1 {
            color: #333;
            text-align: center;
            font-size: 3em;
            margin-bottom: 20px;
        }

        form {
            background-color: #fff;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            width: 400px;
        }

        label {
            display: block;
            margin-bottom: 8px;
        }

        input, textarea {
            width: 100%;
            padding: 8px;
            margin-bottom: 16px;
            box-sizing: border-box;
            border: 1px solid #ccc;
            border-radius: 4px;
        }

        input[type="submit"] {
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>
    <h1>Home Computing Network</h1>
    <form action="" method="post">
        <label for="file_name">File Name (with extension):</label>
        <input type="text" name="file_name" id="file_name" required>
        <br>
        <label for="file_content">File Content:</label>
        <br>
        <textarea name="file_content" id="file_content" rows="5" cols="40" required></textarea>
        <br>
        <input type="submit" value="Create File" name="submit">
    </form>
</body>
</html>
