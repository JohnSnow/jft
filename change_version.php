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

$version_info = trim($_POST['version_info']);

$version_change = trim($_POST['version_change']);

$str=file_get_contents($VERSION_FILE);

if(preg_match('/P4版本号:\s+(\w+)/', $str, $matches)) {
    $version = $matches[1];
}
$newStr = preg_replace('/(版本信息:).*/', '${1}    '.$version_info, $str);

file_put_contents($VERSION_FILE, $newStr);

$fp1 = fopen($CHANGE_FILE, "w");
fwrite($fp1, $version_change);
fclose($fp1);

copy($VERSION_FILE, $VERSION_FILE_PREFIX.$version.".txt");
copy($CHANGE_FILE, $CHANGE_FILE_PREFIX.$version.".txt");

echo "<p><strong>更新信息成功</p>";
?>

    </body>
</html>
