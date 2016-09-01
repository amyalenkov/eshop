$(document).ready(function(){
    var currentPosition = 0;
    var slideHeight = 230;
    var slidesCatalog = $('.slide_catalog');
    var numberOfSlides = slidesCatalog.length;
    // Убираем прокрутку
    $('#slidesContainerIndexCatalog').css('overflow', 'hidden');
    // Вставляем все .slides в блок #slidesContainerIndexCatalog
    slidesCatalog
        .wrapAll('<div id="slideInnerIndexCatalog"></div>')
        // Float left to display horizontally, readjust .slides width
        .css({
            'float' : 'left',
            'height' : slideHeight
        });
    // Устанавливаем ширину #slideInner, равную ширине всех слайдов
    $('#slideInner').css('height', 800);
    //$('#slideInnerIndexCatalog').css('height', 2000);
    // Вставляем элементы контроля в DOM
    $('#slideShowIndexCatalog')
        .prepend('<span class="control_catalog" id="leftControlCatalog"></span>')
        .append('<span class="control_catalog" id="rightControlCatalog"></span>');
    // Прячем правую стрелку при загрузке скрипта
    manageControlsCatalog(currentPosition);
    // Отлавливаем клик на класс .controls
    $('.control_catalog')
        .bind('click', function(){
            // Определение новой позиции
            currentPosition = ($(this).attr('id')=='rightControlCatalog')
                ? currentPosition+1 : currentPosition-1;
            // Прячет / показывает элементы контроля
            manageControlsCatalog(currentPosition);
            // Move slideInner using margin-left
            console.log(slideHeight*(-currentPosition));
            $('#slideInnerIndexCatalog').animate({
                'marginTop' : slideHeight*(-currentPosition)
            });
        });
    // manageControls: показывает или скрывает стрелки в зависимости от значения currentPosition
    function manageControlsCatalog(position){
        // Спрятать левую стрелку, если это левый слайд
        if(position==0){ $('#leftControlCatalog').hide(); }
        else{
            $('#leftControlCatalog').show();
            $('#leftControlCatalog').css('display', 'inline-block');
        }
        // Спрятать правую стрелку, если это последний слайд
        if(position==3){ $('#rightControlCatalog').hide(); }
        else{
            $('#rightControlCatalog').show();
            $('#rightControlCatalog').css('display', 'inline-block');
        }
    }
});