// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require jquery
//= require jquery_ujs
//= require moment 
//= require fullcalendar
//= require recurring_select
//= require_tree .

$(document).ready(function() {
    // page is now ready, initialize the calendar...

    $('#calendar').fullCalendar({
        header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
        eventLimit: true,
        height: 650,
        eventSources: [

        // your event source
	        {
	            url: '/dashboard/welcome.json', // use the `url` property
	            color: 'yellow',    // an option!
	            textColor: 'black'  // an option!
	        }

        // any other sources...

    	]
    })

    $('#calendar_2').fullCalendar({
        header: {
                left: 'prev,next today',
                center: 'title',
                right: 'month,agendaWeek,agendaDay'
            },
        eventLimit: true,
        height: 650,
        eventSources: [

        // your event source
            {
                url: '/dashboard/welcome.json', // use the `url` property
                color: 'yellow',    // an option!
                textColor: 'black'  // an option!
            }

        // any other sources...

        ]
    })
});
