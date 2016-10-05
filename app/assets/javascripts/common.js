//active_zoom
$(document).ready(function() {
    $("#zoom_image").elevateZoom({gallery:'gallery', cursor: 'pointer', galleryActiveClass: 'active'});

//pass the images to Fancybox
    $("#zoom_image").bind("click", function(e) {
        var ez = $('#zoom_image').data('elevateZoom');
        $.fancybox(ez.getGalleryList());
        return false;
    });
//});
//top_menu
//$(document).ready(function() {
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
//});
//select_row_by_checkbox_in_cart
//$(document).ready(function(){
    $("input[type='checkbox']").change(function (e) {
        if ($(this).is(":checked")) {
            $(this).closest('tr').addClass("highlight_row");
        } else {
            $(this).closest('tr').removeClass("highlight_row");
        }
    });
//});
//slider_content
//$(document).ready(function(){
    var currentPosition = 0;
    var slideWidth = 190;
    var slides = $('.slide');
    var numberOfSlides = slides.length;
    // Убираем прокрутку
    $('#slidesContainer').css('overflow', 'hidden');
    // Вставляем все .slides в блок #slideInner
    slides
        .wrapAll('<div id="slideInner"></div>')
        // Float left to display horizontally, readjust .slides width
        .css({
            'float' : 'left',
            'width' : slideWidth
        });
    // Устанавливаем ширину #slideInner, равную ширине всех слайдов
    $('#slideInner').css('width', slideWidth * numberOfSlides);
    // Вставляем элементы контроля в DOM
    $('#slideshow')
        .prepend('<span class="control" id="leftControl"></span>')
        .append('<span class="control" id="rightControl"></span>');
    // Прячем правую стрелку при загрузке скрипта
    manageControls(currentPosition);
    // Отлавливаем клик на класс .controls
    $('.control')
        .bind('click', function(){
            // Определение новой позиции
            currentPosition = ($(this).attr('id')=='rightControl')
                ? currentPosition+1 : currentPosition-1;
            // Прячет / показывает элементы контроля
            manageControls(currentPosition);
            // Move slideInner using margin-left
            $('#slideInner').animate({
                'marginLeft' : slideWidth*(-currentPosition)
            });
        });
    // manageControls: показывает или скрывает стрелки в зависимости от значения currentPosition
    function manageControls(position){
        // Спрятать левую стрелку, если это левый слайд
        if(position==0){ $('#leftControl').hide() }
        else{ $('#leftControl').show() }
        // Спрятать правую стрелку, если это последний слайд
        if(position==numberOfSlides-1){ $('#rightControl').hide() }
        else{ $('#rightControl').show() }
    }
//});

//slider_content_index_page
//    $(document).ready(function(){
    var currentPosition = 0;
    var slideWidth = 265;
    var slides = $('.slide_hot_product');
    var numberOfSlides = slides.length;
    // Убираем прокрутку
    $('#slidesContainerIndex').css('overflow', 'hidden');
    slides
        .wrapAll('<div id="slideInnerIndex"></div>')
        .css({
            'float' : 'left',
            'width' : slideWidth
        });
    $('#slideInnerIndex').css('width', 2000);
    $('#slideshowIndex')
        .prepend('<span class="control_hot_product" id="leftControl"></span>')
        .append('<span class="control_hot_product" id="rightControl"></span>');
    manageControls(currentPosition);
    $('.control_hot_product')
        .bind('click', function(){
            currentPosition = ($(this).attr('id')=='rightControl')
                ? currentPosition+1 : currentPosition-1;
            manageControls(currentPosition);
            console.log(slideWidth*(-currentPosition));
            console.log(slideWidth*(-currentPosition)+30);
            $('#slideInnerIndex').animate({
                'marginLeft' : slideWidth*(-currentPosition)
            });
        });
    function manageControls(position){
        if(position==0){ $('#leftControl').hide() }
        else{ $('#leftControl').show() }
        if(position==5){ $('#rightControl').css('visibility', 'hidden') }
        else{ $('#rightControl').css('visibility', 'visible') }
    }
    //});

// slider_content_index_page_catalog
//    $(document).ready(function(){
    var currentPosition = 0;
    var slideHeight = 230;
    var slidesCatalog = $('.slide_catalog');
    var numberOfSlides = slidesCatalog.length;
    $('#slidesContainerIndexCatalog').css('overflow', 'hidden');
    slidesCatalog
        .wrapAll('<div id="slideInnerIndexCatalog"></div>')
        .css({
            'float' : 'left',
            'height' : slideHeight
        });
    $('#slideInner').css('height', 800);
    $('#slideShowIndexCatalog')
        .prepend('<span class="control_catalog" id="leftControlCatalog"></span>')
        .append('<span class="control_catalog" id="rightControlCatalog"></span>');
    manageControlsCatalog(currentPosition);
    $('.control_catalog')
        .bind('click', function(){
            currentPosition = ($(this).attr('id')=='rightControlCatalog')
                ? currentPosition+1 : currentPosition-1;
            manageControlsCatalog(currentPosition);
            console.log(slideHeight*(-currentPosition));
            $('#slideInnerIndexCatalog').animate({
                'marginTop' : slideHeight*(-currentPosition)
            });
        });
    function manageControlsCatalog(position){
        if(position==0){ $('#leftControlCatalog').hide(); }
        else{
            $('#leftControlCatalog').show();
            $('#leftControlCatalog').css('display', 'inline-block');
        }
        if(position==3){ $('#rightControlCatalog').hide(); }
        else{
            $('#rightControlCatalog').show();
            $('#rightControlCatalog').css('display', 'inline-block');
        }
    }
    //});

//open_reminder
//$(document).ready(function() {
    $("#reminderModal").modal('show');
});

// downTop
$(function(){
    if ($(window).scrollTop()>="250") $("#ToTop").fadeIn("slow")
    $(window).scroll(function(){
        if ($(window).scrollTop()<="250") $("#ToTop").fadeOut("slow")
        else $("#ToTop").fadeIn("slow")
    });

    if ($(window).scrollTop()<=$(document).height()-"999") $("#OnBottom").fadeIn("slow")
    $(window).scroll(function(){
        if ($(window).scrollTop()>=$(document).height()-"999") $("#OnBottom").fadeOut("slow")
        else $("#OnBottom").fadeIn("slow")
    });

    $("#ToTop").click(function(){$("html,body").animate({scrollTop:0},"slow")})
    $("#OnBottom").click(function(){$("html,body").animate({scrollTop:$(document).height()},"slow")})
});
//sortBy
function sortBy(typeSort){
    deleteAllCookies();
    setCookie('sort_by', typeSort, {expires: 0});
    console.log('typeSort: '+typeSort);
    if (typeSort=="by_line"){
        setCookie('class_for_sort_by', 'product_in_line', {expires: 0});
    }
    else{
        deleteCookie('class_for_sort_by');
    }
    //alert(document.cookie);
}

function setCookie(name, value, options) {
    options = options || {};

    var expires = options.expires;

    if (typeof expires == "number" && expires) {
        var d = new Date();
        d.setTime(d.getTime() + expires * 1000);
        expires = options.expires = d;
    }
    if (expires && expires.toUTCString) {
        options.expires = expires.toUTCString();
    }

    value = encodeURIComponent(value);

    var updatedCookie = name + "=" + value;

    for (var propName in options) {
        updatedCookie += "; " + propName;
        var propValue = options[propName];
        if (propValue !== true) {
            updatedCookie += "=" + propValue;
        }
    }

    document.cookie = updatedCookie;
}

function deleteCookie(name) {
    setCookie(name, "", {
        expires: -1
    })
}

function deleteAllCookies() {
    var cookies = document.cookie.split(";");

    for (var i = 0; i < cookies.length; i++) {
        var cookie = cookies[i];
        var eqPos = cookie.indexOf("=");
        var name = eqPos > -1 ? cookie.substr(0, eqPos) : cookie;
        document.cookie = name + "=;expires=Thu, 01 Jan 1970 00:00:00 GMT";
    }
}
//post_loader
$(function(){
    var changeAttr = function(){
        $('#product_list div img[class]').each(function(){
            $(this).attr('src', $(this).attr('class')).removeAttr('class')
        })
    };

    setTimeout(function(){
        changeAttr()}, 2000);
});

$(function(){
    var changeCategoryLogo = function(){
        $('#catalog_items div img[class]').each(function(){
            $(this).attr('src', $(this).attr('class')).removeAttr('class')
        })
    };

    setTimeout(function(){
        changeCategoryLogo()}, 1500);
});

$(function(){
    var changeSubCategoryLogo = function(){
        $('#list_categories a img[class]').each(function(){
            $(this).attr('src', $(this).attr('class')).removeAttr('class')
        })
    };

    setTimeout(function(){
        changeSubCategoryLogo()}, 1500);
});
//close_form
function close_form(name_message, user_name){
    if(name_message === 'after_stop'){
        close_form_ajax(name_message, user_name);
    }else if(name_message === 'choice_delivery'){
        close_form_ajax(name_message, user_name);
    }else if(name_message === 'info_delivery'){
        close_form_ajax(name_message, user_name);
    }else if(name_message === 'info_stop'){
        close_form_ajax(name_message, user_name);
    }
}

function close_form_ajax(name_message, user_id){
    $.ajax({
        type: 'get',
        url: '/static_pages/close_form',
        response: 'text',
        data: {name_message: name_message, user_id: user_id},
        success: function(data){
            console.log('data: '+data)
        }
    })
}
//count_down_timer
function getTimeRemaining(endtime){
    var t = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor( (t/1000) % 60 );
    var minutes = Math.floor( (t/1000/60) % 60 );
    var hours = Math.floor( (t/(1000*60*60)) % 24 );
    var days = Math.floor( t/(1000*60*60*24) );
    return {
        'total': t,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
    };
}

function initializeClock(idElem, endtime){
    var clock = document.getElementById(idElem);
    var daysSpan = document.getElementsByClassName('days');
    var hoursSpan;
    var minutesSpan;
    if(clock !=null){
        hoursSpan = clock.querySelector('.hours');
    }
    if(clock !=null){
        minutesSpan = clock.querySelector('.minutes');
    }

    function updateClock(){
        var t = getTimeRemaining(endtime);

        clock.innerHTML =
            '<div class="blockTimer"><span>' + t.days + ' : ' + '</span><br>' + '<span class="desc">Дней</span></div>' +
            '<div class="blockTimer"><span>' + t.hours + ' : ' + '</span><br>' + '<span class="desc">Часов</span></div>' +
            '<div class="blockTimer"><span>' + t.minutes + '</span><br>' + '<span class="desc">Минут</span></div>';

        daysSpan.innerHTML = t.days;
        hoursSpan.innerHTML = t.hours;
        minutesSpan.innerHTML = t.minutes;

        if(t.total<=0){
            clearInterval(timeinterval);
        }
    }
    updateClock();
    var timeinterval = setInterval(updateClock, 1);
}

function colorForDateCalendar(data){
    var t = JSON.parse(data);
    var events = document.getElementsByClassName('has-events');

    var stop = t['stop'].slice(-2);
    var next_meeting = t['next_meeting'].slice(-2);
    var next_bringing = t['next_bringing'].slice(-2);
    var next_stop = t['next_stop'].slice(-2);

    //console.log(data);

    if(stop.charAt(0)==0){
        stop = stop.substring(1, 2);
    }

    if(next_stop.charAt(0)==0){
        next_stop = next_stop.substring(1, 2);
    }

    if(next_meeting.charAt(0)==0){
        next_meeting = next_meeting.substring(1, 2);
    }

    if(next_bringing.charAt(0)==0){
        next_bringing = next_bringing.substring(1, 2);
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == stop){
            events[i].className += ' next_stop';
        }
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == next_meeting){
            events[i].className += ' next_meeting';
        }
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == next_bringing){
            events[i].className += ' next_bringing';
        }
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == next_stop){
            events[i].className += ' next_stop';
        }
    }

}

function get_dates(){
    $.ajax({
        type: 'get',
        url: '/static_pages/get_datetime_for_stop',
        response: 'text',
        dataType: "text",
        success: function (data) {
            var t = JSON.parse(data);
            //initializeClock('clock', t['stop']);
            initializeClock('clock', t['next_stop']);
            colorForDateCalendar(data);
        }
    });
}

window.onload = function() {
    get_dates()
};

$(document).on('page:load', function() {
    get_dates()
});
$(document).on('page:unload', function() {
    get_dates()
});
$(document).on('page:ready', function() {
    get_dates()
});
