jQuery ->
  registered_user = new UpUser('register-btn-crafter')
  login_user = new InUser('btn-login-crafter')

  $('input.crafter_registration').on 'keyup', ->
    registered_user.check_field(@.name)
    registered_user.validate_registered_user_form()

  $('input.login_crafter').on 'keyup', ->
    login_user.check_field(@.name)
    login_user.validate_login_user_form()

#  $("#user_phone").inputmask("+375-99-9999999");
  $("#user_phone").inputmask({"mask": "+375-99-9999999"});