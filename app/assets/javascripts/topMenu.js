//var h_hght = 135; // высота шапки
//var h_mrg = 0;     // отступ когда шапка уже не видна
//$(function(){
//    $(window).scroll(function(){
//        var top = $(this).scrollTop();
//        var elem = $('.top_menu');
//        if (top+h_mrg < h_hght) {
//            elem.css('top', (h_hght-top));
//        } else {
//            elem.css('top', h_mrg);
//        }
//    });
//});

//<script>
$(document).ready(function() {
    $('#nav').affix({
        offset: {
            top: $('header').height()
        }
    });

    $('#sidebar').affix({
        offset: {
            top: 200
        }
    });
});
//</script>