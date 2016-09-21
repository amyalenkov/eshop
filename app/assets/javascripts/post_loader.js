/**
 * Created by sushi on 9/21/16.
 */

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
