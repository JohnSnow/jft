#!/usr/bin/env sh

# 这个脚本用来改变下载链接中ipa/apk的版本号
# 用sudo 跑, 需要更改sudoers

if [[ $# < 1 ]]; then
    echo "$0 version_number"
    exit 1
fi

VERSION="$1"
RH='dgame@123.59.41.14'
LOCAL_SERVER="192.168.1.253"
LOCAL_IP=`ifconfig | grep "192.168.1\." | cut -d: -f2 |cut -d " " -f 1`

LOCAL=true
BASE_DIR="/var/www"
PLIST_FILE=""
INDEX_PHP="/var/www/html/index.php"

if [[ "$LOCAL_IP" == "$LOCAL_SERVER" ]];then
    LOCAL=true
    PLIST_FILE=$BASE_DIR/online/download_ssl.plist
else
    LOCAL=false
    PLIST_FILE=$BASE_DIR/online_pub/download_ssl.plist
fi

# change plist file
ssh -p 6469 $RH sudo sed -i "s;Battle_release.*.ipa;Battle_release_${VERSION}.ipa;" $PLIST_FILE

# change ipa link
if [[ $LOCAL == true ]]; then
    sed -i "s;Battle_release.*.apk;Battle_release_${VERSION}.apk;" $INDEX_PHP
else
    ssh -p 6469 sudo sed -i "s;Battle_release.*.apk;Battle_release_${VERSION}.apk;" $INDEX_PHP
fi
