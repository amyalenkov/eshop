$(document).ready(function(){
    $(".favourite").click(function (e) {
        //if ($(this).is(":checked")) {
            $(this).closest('tr').addClass("highlight_row_click");
        //} else {
        //    $(this).closest('tr').removeClass("highlight_row");
        //}
    });
});