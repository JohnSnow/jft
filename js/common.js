
$("#version_number").change(function() {
    display_version_info();
});

function display_version_info() {
    var version = $("#version_number").val();
    var filename = "version_" + version + ".txt";
    $.get("/version_txt/" + filename, function(data) {
        var splitted = data.split("\n");
        var html = "";
        var len = splitted.length;
        for (var i = 0; i< len; i++) {
            html += "<li>" + splitted[i]+ "</li>";
        }
        $("#version_info").html(html);
    });
}

$(function() {
    display_version_info();
});