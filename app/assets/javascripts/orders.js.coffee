# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.check_box_items').change ->
    check_button_disable()

  $('#create_order').click ->
    cart_items = []
    $('.check_box_items').each (index, element) =>
      if element.checked == true
        cart_items.push element.value
    $.post(
      '/orders',
      card_items_id: cart_items
    )
#      error: (jqXHR, textStatus, errorThrown) ->
#        console.log('error')
#      success: (data, textStatus, jqXHR) ->
#        console.log('success' + data)

check_button_disable = () ->
  disable = true
  $('.check_box_items').each (index, element) =>
    if element.checked == true
      disable = false
  if disable == true
    $('#create_order').addClass("disabled")
  else
    $('#create_order').removeClass("disabled")
