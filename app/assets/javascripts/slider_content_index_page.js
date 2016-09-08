$(document).ready(function(){
    var currentPosition = 0;
    var slideWidth = 265;
    var slides = $('.slide_hot_product');
    var numberOfSlides = slides.length;
    // Убираем прокрутку
    $('#slidesContainerIndex').css('overflow', 'hidden');
    // Вставляем все .slides в блок #slideInner
    slides
        .wrapAll('<div id="slideInnerIndex"></div>')
        // Float left to display horizontally, readjust .slides width
        .css({
            'float' : 'left',
            'width' : slideWidth
        });
    // Устанавливаем ширину #slideInner, равную ширине всех слайдов
    $('#slideInnerIndex').css('width', 2000);
    // Вставляем элементы контроля в DOM
    $('#slideshowIndex')
        .prepend('<span class="control_hot_product" id="leftControl"></span>')
        .append('<span class="control_hot_product" id="rightControl"></span>');
    // Прячем правую стрелку при загрузке скрипта
    manageControls(currentPosition);
    // Отлавливаем клик на класс .controls
    $('.control_hot_product')
        .bind('click', function(){
            // Определение новой позиции
            currentPosition = ($(this).attr('id')=='rightControl')
                ? currentPosition+1 : currentPosition-1;
            // Прячет / показывает элементы контроля
            manageControls(currentPosition);
            // Move slideInner using margin-left
            console.log(slideWidth*(-currentPosition));
            console.log(slideWidth*(-currentPosition)+30);
            $('#slideInnerIndex').animate({
                'marginLeft' : slideWidth*(-currentPosition)
            });
        });
    // manageControls: показывает или скрывает стрелки в зависимости от значения currentPosition
    function manageControls(position){
        // Спрятать левую стрелку, если это левый слайд
        if(position==0){ $('#leftControl').hide() }
        else{ $('#leftControl').show() }
        // Спрятать правую стрелку, если это последний слайд
        //if(position==5){ $('#rightControl').hide() }
        //else{ $('#rightControl').show() }
        if(position==5){ $('#rightControl').css('visibility', 'hidden') }
        else{ $('#rightControl').css('visibility', 'visible') }
    }
});