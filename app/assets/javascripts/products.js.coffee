# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$ ->

  $('#sorted_by').on 'change', ->
    $.ajax
      type: 'POST'
      url: '/products/sorted_by'
      data:
        sorted_by: @.value
        subcategoryid: $(@).attr('subcategoryid')
        is_hit: $(@).attr('is_hit')
        min_sum: $(@).attr('min_sum')
        max_sum: $(@).attr('max_sum')
        news: $(@).attr('news')

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
          live_search(data, search_string)

live_search = (data,search_request) ->
  ul = $('#result_search_ul').empty()
  ul.empty()
  for index of data
    if index < 5
      li = $('<li></li>', {
        "class": "li_class"
      })
      a = $('<a></a>', {
        "href":"/products/#{data[index].id}",
        "class": "a_class"
      })
      console.log(data[index].image)
      add_image_tag(li, data[index].image+"0/700.jpg".replace("/assets/", ""))
      create_new_li(li, 'name', data[index].name)
#      create_new_li(li, 'description_search', data[index].description)
#      create_new_li(li, 'address', data[index].address)
#      create_new_li(li, 'city', data[index].city)

      a.append(li)

      ul.append(a)
    else
      url = "/products/search?utf8=✓&search="+search_request+"&commit=OK"
      li = $('<li><a id="all_results" class="all_results" href='+url+'>Просмотреть все результаты</a></li>', {
        "class": "li_class"
      })
      ul.append(li)
      break


create_new_li = (li, div_class_name, data) ->
  div = $('<div></div>', {
    "class": div_class_name
  }).text(data).appendTo(li)

add_image_tag = (li, image_src) ->
  image = $('<img/>', {
    "src": image_src,
    "class": "company_logo"
  }).appendTo(li)