//$("#zoom_image").elevateZoom({gallery:'gallery_01', cursor: 'pointer', galleryActiveClass: 'active', imageCrossfade: true,
//    loadingIcon: 'http://www.elevateweb.co.uk/spinner.gif'});

$(document).ready(function() {
    $("#zoom_image").elevateZoom({gallery: 'gallery_01', cursor: 'pointer', galleryActiveClass: 'active'});

    $("#gal1").bind("click", function (e) {
        var elem = $.find
        console.log("click");
        var ez = $('#zoom_image').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });
});