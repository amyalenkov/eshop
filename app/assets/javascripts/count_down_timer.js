function getTimeRemaining(endtime){
    var t = Date.parse(endtime) - Date.parse(new Date());
    var seconds = Math.floor( (t/1000) % 60 );
    var minutes = Math.floor( (t/1000/60) % 60 );
    var hours = Math.floor( (t/(1000*60*60)) % 24 );
    var days = Math.floor( t/(1000*60*60*24) );
    return {
        'total': t,
        'days': days,
        'hours': hours,
        'minutes': minutes,
        'seconds': seconds
    };
}

function initializeClock(idElem, endtime){
    var clock = document.getElementById(idElem);
    var daysSpan = document.getElementsByClassName('days');
    var hoursSpan;
    var minutesSpan;
    if(clock !=null){
        hoursSpan = clock.querySelector('.hours');
    }
    if(clock !=null){
        minutesSpan = clock.querySelector('.minutes');
    }

    function updateClock(){
        var t = getTimeRemaining(endtime);

        clock.innerHTML =
            '<div class="blockTimer"><span>' + t.days + ' : ' + '</span><br>' + '<span class="desc">Дней</span></div>' +
            '<div class="blockTimer"><span>' + t.hours + ' : ' + '</span><br>' + '<span class="desc">Часов</span></div>' +
            '<div class="blockTimer"><span>' + t.minutes + '</span><br>' + '<span class="desc">Минут</span></div>';

        daysSpan.innerHTML = t.days;
        hoursSpan.innerHTML = t.hours;
        minutesSpan.innerHTML = t.minutes;

        if(t.total<=0){
            clearInterval(timeinterval);
        }
    }
    updateClock();
    var timeinterval = setInterval(updateClock, 1);
}

function colorForDateCalendar(data){
    var t = JSON.parse(data);
    var events = document.getElementsByClassName('has-events');

    var stop = t['stop'].slice(-2);
    var next_meeting = t['next_meeting'].slice(-2);
    var next_bringing = t['next_bringing'].slice(-2);
    var next_stop = t['next_stop'].slice(-2);

    //console.log(data);

    if(stop.charAt(0)==0){
        stop = stop.substring(1, 2);
    }

    if(next_stop.charAt(0)==0){
        next_stop = next_stop.substring(1, 2);
    }

    if(next_meeting.charAt(0)==0){
        next_meeting = next_meeting.substring(1, 2);
    }

    if(next_bringing.charAt(0)==0){
        next_bringing = next_bringing.substring(1, 2);
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == stop){
            events[i].className += ' next_stop';
        }
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == next_meeting){
            events[i].className += ' next_meeting';
        }
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == next_bringing){
            events[i].className += ' next_bringing';
        }
    }

    for(i=0; i<3; i++){
        if(events[i] != undefined && events[i].innerHTML.replace(/ /g,'').replace('\n','').replace(/ /g,'') == next_stop){
            events[i].className += ' next_stop';
        }
    }

}

function get_dates(){
    $.ajax({
        type: 'get',
        url: '/static_pages/get_datetime_for_stop',
        response: 'text',
        dataType: "text",
        success: function (data) {
            var t = JSON.parse(data);
            //initializeClock('clock', t['stop']);
            initializeClock('clock', t['next_stop']);
            colorForDateCalendar(data);
        }
    });
}

window.onload = function() {
    get_dates()
};

$(document).on('page:load', function() {
    get_dates()
});
$(document).on('page:unload', function() {
    get_dates()
});
$(document).on('page:ready', function() {
    get_dates()
});
$(document).on('turbolinks:load', function() {
    get_dates()
});
