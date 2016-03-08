$(document).ready(function() {
    $("#zoom_image").elevateZoom({gallery:'gallery', cursor: 'pointer', galleryActiveClass: 'active'});

//pass the images to Fancybox
    $("#zoom_image").bind("click", function(e) {
        var ez = $('#zoom_image').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });
});
