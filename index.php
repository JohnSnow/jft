<?php
    require_once("./global.php");
    $version = file($VERSION_FILE, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    $versionArray = array_values(array_filter($version, "trim"));
    $updateR = file($CHANGE_FILE, FILE_IGNORE_NEW_LINES | FILE_SKIP_EMPTY_LINES);
    $updateRArray = array_values(array_filter($updateR, "trim"));
?>

<!DOCTYPE html>
<html>
    <head>
        <!--meta http-equiv="Content-Type" content="text/html; charset=UTF-8"-->
        <meta charset="utf-8">
        <title>测试区</title>

        <!-- Sets initial viewport load and disables zooming  -->
        <meta name="viewport" content="initial-scale=1, maximum-scale=1, user-scalable=no, minimal-ui">

        <!-- Makes your prototype chrome-less once bookmarked to your phone's home screen -->
        <meta name="apple-mobile-web-app-capable" content="yes">
        <meta name="apple-mobile-web-app-status-bar-style" content="black">

        <!-- Include the compiled Ratchet CSS -->
        <link href="css/ratchet.css" rel="stylesheet">

        <!-- Include the compiled Ratchet JS -->
        <script src="js/ratchet.js"></script>
    </head>
    <body>
        <!-- Make sure all your bars are the first things in your <body> -->
        <header class="bar bar-nav">
            <div class="segmented-control" style="font-size: 20px">
                <a class="control-item active" href="#ios_download">苹果用户</a>
                <a class="control-item" href="#android_download">安卓用户</a>
            </div>
        </header>

        <!-- Wrap all non-bar HTML in the .content div (this is actually what scrolls) -->
        <div class="content">
            <div class="column control-content active" id="ios_download">
                <div class="docs-module">
                    <div id="cer_download">
                        <a class="btn btn-block btn-primary" data-ignore="push" href="http://192.168.1.253/server.crt">
                            <span class="icon icon-download"></span>IOS7.1+先安装证书
                        </a>
                        <a class="btn btn-block btn-primary" data-ignore="push" href="itms-services:///?action=download-manifest&url=https://123.59.41.14:4443/download_ssl.plist">
                            <span class="icon icon-download"></span><strong>点此下载正式版</strong>
                        </a>
                    </div>
                    <div id="normal_download">
                        <a class="btn btn-block btn-primary" data-ignore="push" href="itms-services:///?action=download-manifest&url=https://123.59.41.14:4443/download_ssl.plist">
                            <span class="icon icon-download"></span><strong>点此下载正式版</strong>
                        </a>
                    </div>
                    <div id="webview" style="display: none;">
                        <h5 class="docs-module-title" style="text-align:center;color:red">IOS7.1请使用Safari打开下面的链接进行安装:</h5>
                        <h5 class="docs-module-title" style="text-align:center;color:red"><a href="http://192.168.1.253">http://192.168.1.253/</a></h5>
                        <h5 class="docs-module-title" style="text-align:center;">长按拷贝链接 使用Safari打开</h5>
                    </div>
                    <div class="version" id="version_info">
                        <ul>
                        <?php
                            foreach ($versionArray as $line) {
                                echo "<li>$line</li>";
                            }
                        ?>
                        </ul>
                    </div>
                    <div class="update context-padded" id="update_info">
                        <p align="center" style="font-size:20px"> 版本更新内容</p>
                        <ol>
                        <?php
                            foreach($updateRArray as $line) {
                                echo "<li>$line</li>";
                            }
                        ?>
                        </ol>
                    </div>
                </div>
            </div>
            <div class="column control-content" id="android_download">
                <div class="docs-module">
                    <p class="column" align="center">
                        <img src="./test_files/Icon.png" width="200px" height="200px">
                    </p>
                    <a class="btn btn-block btn-primary " data-ignore="push" href="www.baidu.com">
                        <span class="icon icon-close"></span><strong>不支持</strong>
                    </a>
                </div>
            </div>

        </div>
    </div>
    </body>
    <script src="js/plat.js"></script>
</html>
