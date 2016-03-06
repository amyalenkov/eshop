$(document).ready(function() {
    $("#zoom_image").elevateZoom({gallery: 'gallery_01', cursor: 'pointer', galleryActiveClass: 'active'});
});

function get_id(clicked_id)
{
    var new_src = document.getElementById(clicked_id).src;
    document.getElementById("zoom_image").setAttribute("src", new_src);
    return false;
}