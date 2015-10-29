
<!DOCTYPE html>
<html>
    <head>
        <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"-->
        <meta charset="utf-8">
        <title>测试区</title>
    </head>
    <body>

<?php

    $version_number = trim($_POST['version_number']);
    $src_version_file = "version_txt/version_" . $version_number . ".txt";
    $dst_version_file = "version_txt/version.txt";

    copy($src_version_file, $dst_version_file);
    chmod($dst_version_file, 666);

