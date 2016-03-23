$(document).ready(function() {

    $('.go').click(function() {
        $("#orderCall").valid()
    });

    $("#orderCall").validate({
        rules: {
            name: {
                required: true,
                minlength: 2
            },
            email: {
                required: true,
                email: true
            },
            phone: {
                required: true,
                regex: /\+\d{3}-\d{2}-\d{3}-\d{2}-\d{2}/
            }
        },
        messages: {
            name: {
                required: "Введите Ваше имя",
                minlength: "Минимум 2 символа"
            },
            email: {
                required: "Введите Ваш Email",
                email: "Введите в формате example@mail.com"
            },
            phone: {
                required: "Введите Ваш номер телефона",
                regex: "Введите в формате +375-25-937-99-92"
            }
        }
    });

    $.validator.addMethod("regex", function(value, element, regexpr) {
        return regexpr.test(value);
    });

});