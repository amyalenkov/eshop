# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->
  $('.new_cart_item').on 'submit', ->
    val = $(this).parent().find('#cart_item_product_id').val()
    $('#'+val).hide()