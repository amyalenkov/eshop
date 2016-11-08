$ ->
  $('.next').on 'click', ->
    date = $(this).attr('href')
    event.preventDefault();
    call_ajax(date)

  $('.pre').on 'click', ->
    date = $(this).attr('href')
    event.preventDefault();
    call_ajax(date)

call_ajax = (date) ->
  $.ajax '',
    type: 'GET'
    url: date
    success: (data) ->
      el = document.createElement('html');
      el.innerHTML = data
      newCalendar = el.querySelector('#calTable')
      pre = el.querySelector('#pre')
      title = el.querySelector('#title')
      next = el.querySelector('#next')

      document.getElementById('calTable').innerHTML = newCalendar.innerHTML
      document.getElementById('pre').setAttribute('href', pre.getAttribute("href"))
      document.getElementById('next').setAttribute("href", next.getAttribute("href"))
      document.getElementById('title').innerHTML = title.innerHTML