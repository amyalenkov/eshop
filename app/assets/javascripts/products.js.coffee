# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('#search').on 'keyup', ->
    search_string = @.value
    if search_string.length >= 3
      $('#search_result').show()
      $.ajax
        type: 'POST'
        url: '/products/search_ajax'
        data: {search: search_string}
        error: (jqXHR, textStatus, errorThrown) ->
          console.log('error search')
        success: (data, textStatus, jqXHR) ->
          console.log('success search')
#          live_search(data, search_string)
