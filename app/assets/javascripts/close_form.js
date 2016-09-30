/**
 * Created by sushi on 9/30/16.
 */

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

