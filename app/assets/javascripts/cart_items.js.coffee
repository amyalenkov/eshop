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
    total_amount_old = $('#total_amount').text()
    total_count_old = $('#total_count').text()
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
          $('#total_amount').text(parseInt(total_amount_old) - parseInt(price.val()) )
          $('#total_count').text(parseInt(total_count_old) - 1)
      if(type == 'plus')
        if(currentVal < input.attr('max'))
          input.val(currentVal + 1).change();
          total_price.val(price.val() * input.val())
          $('#total_amount').text(parseInt(total_amount_old) + parseInt(price.val()) )
          $('#total_count').text(parseInt(total_count_old) + 1)
    else
      input.val(0);

  $(".input-number").keyup ->
    this.value = this.value.replace(/[^0-9\.]/g,'')
    fieldName = $(this).attr('name');
    price = $("input[name='price_" + fieldName + "']")
    total_price = $("input[name='total_price_" + fieldName + "']")
    total_price.val(price.val() * this.value)
    total_count = 0
    all_total_price = 0

    $('.count_field').each (index, element) ->
      current_count = parseInt($(element).val())
      if (!isNaN(current_count))
        total_count = current_count + total_count
    $('#total_count').text(total_count)

    $('.amount').each (index, element) ->
      current_price = parseInt($(element).val())
      all_total_price = current_price + current_price
    $('#total_amount').text(all_total_price )


check_button_disable = () ->
  disable = true
  $('.check_box_items').each (index, element) =>
    if element.checked == true
      disable = false
  if disable == true
    $('#create_order_for_all_cart').addClass("disabled")
  else
    $('#create_order_for_all_cart').removeClass("disabled")
