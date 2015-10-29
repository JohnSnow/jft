<?php
// build version map
$map = array();
$files = glob("./version_txt/version_*");
foreach ($files as $file) {
    $str = file_get_contents($file);
    if(preg_match('/版本信息:\s+(\w+)/', $str, $matches)) {
        $map[$matches[1]] = $file;
    }
}
?>

<html>
    <head>
        <meta charset="utf-8">
    </head>
<body>

<form action="handle_version.php" method="post" enctype="multipart/form-data">
    <div>
        <label for="version_info">版本信息</label>
        <select id="version_number" name="version_number">
            <?php
                $html = "";
                $keys = array_keys($map);
                rsort($keys);
                foreach ( $keys as $key) {
                    $file = $map[$key];
                    $str1 = file_get_contents($file);
                    if (preg_match('/P4版本号:\s+(\w+)/', $str1, $matches)) {
                        $version = $matches[1];
                    }
                    $html .= "<option value=$version>". $key. "</option>";
                }
                echo $html;
            ?>

        </select>
    </div>
    </br>
    <div class="version" id="version_info">

    </div>

    </br>

    <input type="submit" name="submit" value="Submit" />
</form>

<script src="js/jquery-2.1.4.min.js"></script>
<script src="js/common.js"></script>
</body>
</html>
