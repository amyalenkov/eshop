$(document).ready(function() {

    $('.required').on('blur keyup', function() {
        if ($("#orderCall").valid()) {
            $(".go").removeAttr('disabled')
        } else {
            $('.go').prop('disabled', 'disabled');
        }
    });

    $("#orderCall").validate({
        rules: {
            name: {
                required: true,
                regex: /\S+ \S+ \S+/
            },
            email: {
                required: true,
                email: true
            },
            phone: {
                required: true,
                regex: /\d{3}-\d{3}-\d{2}-\d{2}/
            }
        },
        messages: {
            name: {
                required: "Введите Ваше имя",
                regex: "Нужно ввести: Фамилию Имя Отчесвто"
            },
            email: {
                required: "Введите Ваш Email",
                email: "Введите Email в формате example@mail.com"
            },
            phone: {
                required: "Введите Ваш номер телефона",
                regex: "Введите номер в формате +375-25-937-99-92"
            }
        }
    });

    $.validator.addMethod("regex", function(value, element, regexpr) {
        return regexpr.test(value);
    });

});




//
//$(document).ready(function () {
//    $("#contact_us").goValidate();
//});
//
//$.fn.goValidate = function() {
//    //$("#phone").mask("+375-(99)-999-99-99");
//
//    var $form = this,
//        $inputs = $form.find('input:text');
//
//    var button = $form.find('.go');
//
//    var validators = {
//        name: {
//            regex: /^[A-Za-z]{3,} [A-Za-z]{3,} [A-Za-z]{3,}$/
//        },
//        pass: {
//            regex: /(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{6,}/
//        },
//        email: {
//            regex: /^[\w\-\.\+]+\@[a-zA-Z0-9\.\-]+\.[a-zA-z0-9]{2,4}$/
//        },
//        phone: {
//            regex: /^[2-9]\d{2}-\d{3}-\d{4}$/,
//        }
//    };
//    var validate = function(klass, value) {
//        var isValid = true,
//            error = '';
//
//        if (!value && /required/.test(klass)) {
//            error = 'This field is required';
//            isValid = false;
//        } else {
//            klass = klass.split(/\s/);
//            $.each(klass, function(i, k){
//                if (validators[k]) {
//                    if (value && !validators[k].regex.test(value)) {
//                        isValid = false;
//                        error = validators[k].error;
//                    }
//                }
//            });
//        }
//        return {
//            isValid: isValid,
//            error: error
//        }
//    };
//    var showError = function($input) {
//        var klass = $input.attr('class'),
//            value = $input.val(),
//            test = validate(klass, value);
//
//        $input.removeClass('invalid');
//        $('#form-error').addClass('hide');
//
//        if (!test.isValid) {
//            $input.addClass('invalid');
//
//            if(typeof $input.data("shown") == "undefined" || $input.data("shown") == false){
//                $input.popover('show');
//            }
//
//        }
//        else {
//            $input.popover('hide');
//        }
//    };
//
//    $inputs.keyup(function() {
//        showError($(this));
//        console.log('delete disabled');
//        button.disabled = false;
//    });
//
//    $inputs.on('shown.bs.popover', function () {
//        $(this).data("shown",true);
//    });
//
//    $inputs.on('hidden.bs.popover', function () {
//        $(this).data("shown",false);
//    });
//
//    if(name.valid && email.valid)
//
//    $form.submit(function(e) {
//        console.log("asdasdasd");
//
//        $inputs.each(function() { /* test each input */
//            if ($(this).is('.required') || $(this).hasClass('invalid')) {
//                showError($(this));
//            }
//        });
//        if ($form.find('input.invalid').length) { /* form is not valid */
//            e.preventDefault();
//            $('#form-error').toggleClass('hide');
//        }
//    });
//    return this;
//};
