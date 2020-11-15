import moment from 'moment'
import { Calendar } from '@fullcalendar/core';
import dayGridPlugin from '@fullcalendar/daygrid';
import timeGridPlugin from '@fullcalendar/timegrid';
import interactionPlugin from '@fullcalendar/interaction';
import adaptivePlugin from '@fullcalendar/adaptive'
import roLocale from '@fullcalendar/core/locales/ro';

document.addEventListener('turbolinks:load', function() {
  var calendarEl = document.getElementById('calendar');

  var calendar = new Calendar(calendarEl, {
    plugins: [ dayGridPlugin, timeGridPlugin, interactionPlugin, adaptivePlugin ],
    schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
    locale: roLocale,
    headerToolbar: {
      start: 'prev,next today',
      center: 'title',
      end: 'dayGridMonth,timeGridWeek,timeGridDay',
    },
    // themeSystem: 'bootstrap',
    height: 734,
    aspectRatio: 1.35,
    nowIndicator: true,
    navLinks: true,
    selectable: true,
    selectHelper: true,
    editable: true,
    eventLimit: true,
    dayMaxEventRows: 4,
    eventTimeFormat: {
      hour: 'numeric',
      minute: '2-digit',
      meridiem: false
    },
    datesSet: (info) => {
      localStorage.setItem("fcDefaultView", info.view.type);
      localStorage.setItem("fcStartDate", moment(info.view.currentStart).format());
    },
    initialView: (localStorage.getItem("fcDefaultView") != null ? localStorage.getItem("fcDefaultView") : "dayGridMonth"),
    initialDate: (localStorage.getItem("fcStartDate") != null ? localStorage.getItem("fcStartDate") : moment(new Date).format()),

    select: (info) => {
      $.getScript('/events/new', () => {
        $('#start_date_field').val(moment(info.start).format('YYYY/MM/DD HH:mm'));
        $('#end_date_field').val(moment(info.end).format('YYYY/MM/DD HH:mm'));
      });

      calendar.unselect()
      $('#modal-window').on('hide.bs.modal', () => {
        calendar.render()
        calendar.getEventSources().forEach(eventSource => eventSource.refetch())
      });
    },
    eventSources: [
      {
        url: '/events.json',
        failure: function() {
          alert('there was an error while fetching events!');
        },
      }
    ],

    eventDrop: (info) => {
      let eventData = {
        event: {
          id: info.event.id,
          start: info.event.start,
          end: info.event.end,
          all_day: info.event.allDay,
        },
      };
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
      reloadWithTurbolinks()
    },
    eventResize: (info) => {
      let eventData = {
        event: {
          id: info.event.id,
          start: info.event.start,
          end: info.event.end,
          all_day: info.event.allDay,
        },
      };
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
      reloadWithTurbolinks()
    },
    eventClick: (info) => {
      info.jsEvent.preventDefault();

      $.getScript(`events/${info.event.id}/edit`, () => {
        $('#start_date_field').val(moment(info.event.start).format('YYYY/MM/DD HH:mm'));
        $('#end_date_field').val(moment(info.event.end).format('YYYY/MM/DD HH:mm'));
      });

      calendar.unselect()
      $('#modal-window').on('hide.bs.modal', () => {
        calendar.render()
        calendar.getEventSources().forEach(eventSource => eventSource.refetch())
      });
    },
  });

  calendar.render();
});
