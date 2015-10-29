<?php

    $version_number = trim($_POST['version_number']);
    $src_version_file = "version_txt/version_" . $version_number . ".txt";
    $dst_version_file = "version_txt/version.txt";

    $src_change_file = "version_txt/change_" . $version_number . ".txt";
    $dst_change_file = "version_txt/change.txt";

    copy($src_version_file, $dst_version_file);
    copy($src_change_file, $dst_change_file);

    shell_exec("sudo ./cv.sh $version_number");

    header("Location: /");
