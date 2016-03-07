//$(document).ready(function() {
//    $("#zoom_image").elevateZoom({gallery: 'gallery_01', cursor: 'pointer', galleryActiveClass: 'active'});
//});
//
//function get_id(clicked_id)
//{
//    var new_src = document.getElementById(clicked_id).src;
//    document.getElementById("zoom_image").setAttribute("src", new_src);
//    document.getElementById("zoom_image").setAttribute("data-zoom-image", new_src);
//    //var zoomWindow = document.getElementsByClassName("zoomWindow");
//    document.getElementsByClassName("zoomWindow").style.backgroundImage="url("+new_src+")";
//    //.toHTML().style("background-image: url("+new_src+")");
//    return false;
//}

$(document).ready(function() {
    $("#zoom_image").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: 'active',
        imageCrossfade: true, loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif'});

//pass the images to Fancybox
    $("#zoom_image2").bind("click", function(e) {
        console.log("click");
        var ez = $('#zoom_image2').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });
});

//$(document).ready(function() {
//    $("#zoom_image").bind("click", function(e) {
//        console.log("click");
//        var ez = $('#zoom_image').data('elevateZoom');
//        $.fancybox(ez.getGalleryList());
//        return false;
//    });
//});
