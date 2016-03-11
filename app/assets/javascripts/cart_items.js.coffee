# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('.delete').on 'click', ->
    check_button_disable()

  $('.new_cart_item').on 'submit', ->
    val = $(this).parent().find('#cart_item_product_id').val()
    $('#' + val).hide()

  $('.btn-number').click ->
    fieldName = $(this).attr('data-field');
    type = $(this).attr('data-type');
    input = $("input[name='" + fieldName + "']");
    currentVal = parseInt(input.val());
    if (!isNaN(currentVal))
      price = $("input[name='price_" + fieldName + "']")
      total_price = $("input[name='total_price_" + fieldName + "']")
      if(type == 'minus')
        if(currentVal > input.attr('min'))
          input.val(currentVal - 1).change();
          total_price.val(price.val() * input.val())
      if(type == 'plus')
        if(currentVal < input.attr('max'))
          input.val(currentVal + 1).change();
          total_price.val(price.val() * input.val())
    else
      input.val(0);

  $(".input-number").keyup ->
    this.value = this.value.replace(/[^0-9\.]/g,'')
    fieldName = $(this).attr('name');
    price = $("input[name='price_" + fieldName + "']")
    total_price = $("input[name='total_price_" + fieldName + "']")
    total_price.val(price.val() * this.value)

check_button_disable = () ->
  disable = true
  $('.check_box_items').each (index, element) =>
    if element.checked == true
      disable = false
  if disable == true
    $('#create_order_for_all_cart').addClass("disabled")
  else
    $('#create_order_for_all_cart').removeClass("disabled")
