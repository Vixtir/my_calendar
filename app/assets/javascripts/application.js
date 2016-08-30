//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require moment 
//= require fullcalendar
//= require bootstrap-datepicker
//= require recurring_select
//= require_tree .

$(document).ready(function() {
    var cal_url_func = function(){
        if($('li.all_event').length){
          result = '/dashboard/events.json'
        } else {
          result = '/dashboard/events.json?all=1'
        }
        return result
    };

    $('#calendar').fullCalendar({
        header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
        eventLimit: true,
        height: 650,
        eventSources: [
            {
                url: cal_url_func(),
                textColor: 'black'
            }
    	]
    });

    $('input#event_date').datepicker({
        "language": 'ru',
        "autoclose": true,
        "format": "dd.mm.yyyy"
    });
});
