<!DOCTYPE html>
<html>
    <head>
        <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"-->
        <meta charset="utf-8">
        <title>测试区</title>
    </head>
    <body>
<?php

require_once("./global.php");

$version_time=trim($_POST['version_time']);
$version_info = trim($_POST['version_info']);
$p4_commit = trim($_POST['p4_commit']);

$version_change = trim($_POST['version_change']);

$version_string="版本时间：$version_time\n版本信息：$version_info\nP4版本号：$p4_commit";

$fp = fopen($VERSION_FILE, "w");

fwrite($fp, $version_string);
fclose($fp);

$fp1 = fopen($CHANGE_FILE, "w");
fwrite($fp1, $version_change);
fclose($fp1);

echo "<p><strong>更新信息成功</p>";
?>

    </body>
</html>
