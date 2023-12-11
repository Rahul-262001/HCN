<?php
 = '';

if (['REQUEST_METHOD'] === 'POST') {
    // Get file name and content from the form
     = ['file_name'];
     = ['file_content'];

    // Check if file name and content are provided
    if (empty() || empty()) {
         = 'Please provide both file name and content.';
    } else {
        // Save file in the same directory
         = './' . ;
         = file_put_contents(, );

        // Check if file creation was successful
        if ( !== false) {
             = 'File ' .  . ' created successfully.';
        } else {
             = 'Error creating file ' .  . '.';
        }
    }
}
?>
<!DOCTYPE html>
<html lang=en>
<head>
    <meta charset=UTF-8>
    <meta name=viewport content=width=device-width, initial-scale=1.0>
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
    <form action= method=post>
        <h1>File Creation Form</h1>
        <label for=file_name>File Name (with extension):</label>
        <input type=text name=file_name id=file_name required>
        <br>
        <label for=file_content>File Content:</label>
        <br>
        <textarea name=file_content id=file_content rows=5 cols=40 required></textarea>
        <br>
        <input type=submit value=Create File name=submit>
        <div class=message><?php echo ; ?></div>
    </form>
</body>
</html>

