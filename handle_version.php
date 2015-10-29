<?php

    $version_number = trim($_POST['version_number']);
    $src_version_file = "version_txt/version_" . $version_number . ".txt";
    $dst_version_file = "version_txt/version.txt";

    copy($src_version_file, $dst_version_file);
    chmod($dst_version_file, 666);

    shell_exec("sudo ./cv.sh");

    header('Location: '. "/");
