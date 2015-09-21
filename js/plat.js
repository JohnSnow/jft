var controlList = document.getElementsByClassName("control-item");

if (/(iPhone|iPad|iPod|iOS)/i.test(navigator.userAgent))
{
    if (/(7_1|8_0|8_1|8_2|8_3|8_4|9_0)/i.test(navigator.userAgent))
    {
        document.getElementById("cer_download").style.display = '';
    }
    else
    {
        document.getElementById("cer_download").style.display = 'none';
    }
}
else
{
    if( !/(android_download)/i.test(window.location.herf) )
    {
        controlList[1].click();
    }
}

if (!/(Safari)/i.test(navigator.userAgent))
{
    document.getElementById("webview").style.display = '';
    document.getElementById("web_brower").style.display = 'none';
}
else
{
    document.getElementById("webview").style.display = 'none';
    document.getElementById("web_brower").style.display = '';
}

