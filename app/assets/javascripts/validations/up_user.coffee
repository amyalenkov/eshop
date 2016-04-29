class @UpUser
  constructor: (button_class_name) ->
    @button_class_name = button_class_name
    @utils = new Utils()
    init_validation_for_registered_user()
    @utils.disable_button(@button_class_name)

  validate_registered_user_form: () ->
    if @utils.check_field('user[email]') && @utils.check_field('user[name]') && @utils.check_field('user[phone]') &&  @utils.check_field('user[password]') && @utils.check_field('user[password_confirmation]')
      @utils.visible_button(@button_class_name)
    else
      @utils.disable_button(@button_class_name)

  check_field: (field_name) ->
    @utils.check_field(field_name)

init_validation_for_registered_user = () ->
  $('.new_user').validate({
    rules:
      'user[email]':
        required: true
      'user[name]':
        required: true,
        maxlength: 30
      'user[phone]':
        required: true,
#        matches: "[0-9]+",
        minlength:9,
        maxlength:9
      'user[password]':
        required: true,
        minlength: 8
      'user[password_confirmation]':
        required: true,
        equalTo: "#user_password"
    messages:
      'user[email]':
        required: 'Для регистрации необходим email'
        email: 'Email некорректный'
      'user[name]':
        required: 'Введите имя пользователя'
        maxlength: 'Максимальная длина имени 30 символов'
      'user[phone]':
        required: 'Введите номер телефона'
        matches: 'Номер телефона должен содержать только цифры'
        minlength: 'Номер телефона должен содержать 9 цифр'
        maxlength: 'Номер телефона должен содержать 9 цифр'
      'user[password]':
        required: 'Для регистрации необходим пароль'
        minlength: 'Минимальная длина пароля 8 символов'
      'user[password_confirmation]':
        required: 'Для регистрации необходим пароль'
        minlength: 'Минимальная длина пароля 8 символов'
        equalTo: 'Пароли не совпадают'

  })