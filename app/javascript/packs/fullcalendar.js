import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import roLocale from '@fullcalendar/core/locales/ro';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, timeGridPlugin, interactionPlugin ],
    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
    locale: roLocale,
    headerToolbar: {
      start: 'prev,next today',
      center: 'title',
      end: 'dayGridMonth,timeGridWeek,timeGridDay',
    },
    // themeSystem: 'bootstrap',
    height: 700,
    nowIndicator: true,
    navLinks: true,
    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    select: function(info) {
      var title;
      title = prompt("Title: ");
      var eventData;
      //this validates that the user must insert a name in the input
      if (title) {
        eventData = {
          event: {
            title: title,
            start: info.start,
            end: info.end,
          },
        };
        //here I validate that the user can't create an event before today
        if (eventData.event.start < new Date()) {
          alert('You can\'t choose a date that already past.');
          calendar.unselect();
          return
        }
        //if everything it's ok, then the event is saved in database with ajax
        $.ajax({
          url: "events",
          type: "POST",
          data: eventData,
          dataType: 'json',
          success: function(json) {
            alert(json.msg);
            calendar.render()
            calendar.getEventSources().forEach(eventSource => eventSource.refetch())
          }
        });
      }
      calendar.unselect()
    },
    eventSources: [
      {
        url: '/events.json',
        failure: function() {
          alert('there was an error while fetching events!');
        },
      }
    ],
    eventDrop: function(info) {
      let eventData = {
        event: {
          id: info.event.id,
          start: info.event.start,
          end: info.event.end,
        },
      };
      console.log(info.event)
      $.ajax({
        url: info.event.url,
        data: eventData,
        type: 'PATCH',
        dataType: 'json',
        success: function(json) {
          alert(json.msg);
          calendar.render()
          calendar.getEventSources().forEach(eventSource => eventSource.refetch())
        }
      });
    }
  });

  calendar.render();
  console.log(calendar.getEvents())
});