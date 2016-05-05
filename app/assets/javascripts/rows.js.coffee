# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('.check_category').on 'change', ->
    if(@.checked)
      $('.subcategory_id_'+@.value).show()
    else
      $('.subcategory_id_'+@.value).hide()

