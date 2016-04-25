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
    var hoursSpan = clock.querySelector('.hours');
    var minutesSpan = clock.querySelector('.minutes');

    function updateClock(){
        var t = getTimeRemaining(endtime);
        clock.innerHTML =
            '<div class="blockTimer"><span>'+t.days+' : '+'</span><br>'+'<span class="desc">Дней</span></div>'+
            '<div class="blockTimer"><span>'+t.hours+' : '+'</span><br>'+'<span class="desc">Часов</span></div>' +
            '<div class="blockTimer"><span>'+t.minutes+'</span><br>'+'<span class="desc">Минут</span></div>';

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

window.onload = function() {
    $.ajax({
        type: 'get',
        url: '/static_pages/get_datetime_for_stop',
        response: 'text',
        dataType: "text",
        success: function (data) {
            data;
            initializeClock('clock', data);
        }
    });
};
