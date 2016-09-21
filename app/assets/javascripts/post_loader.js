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
        changeAttr()}, 2500);
});
