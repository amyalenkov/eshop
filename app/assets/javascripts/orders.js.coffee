# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.check_box_items').change ->
    check_button_disable()

  $('#create_order').click ->
    cart_items = {}
    $('.check_box_items').each (index, element) =>
      if element.checked == true
        input = $("input[name='quant[" + element.value + "]']");
        cart_items[element.value] = input.val()
    $.post(
      '/orders',
      card_items: cart_items
    )

  $('#create_order_for_all_cart').click ->
    cart_items = []
    $('.check_box_items').each (index, element) =>
      cart_items.push element.value
    if cart_items.length > 0
      $.post(
        '/orders',
        card_items_id: cart_items
      )

check_button_disable = () ->
  disable = true
  $('.check_box_items').each (index, element) =>
    if element.checked == true
      disable = false
  if disable == true
    $('#create_order').addClass("disabled")
  else
    $('#create_order').removeClass("disabled")
