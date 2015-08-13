unzip *.ipa > /etc/null
cp plutil.pl Payload/battle_demo\ iOS.app/
cd Payload/battle_demo\ iOS.app/
perl plutil.pl Info.plist >p.log  2>&1
grep CFBundleVersion Info.text.plist -A1|grep string|awk -F ">" '{print $2}'|awk -F "<" '{print $1}'
cd - >/etc/null
rm Payload -rf
