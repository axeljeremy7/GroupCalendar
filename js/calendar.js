$(document).ready(function() {
    $("#navbar-switch").removeClass("navbar-fixed");
    $("#navbar-switch").addClass("navbar");
    $("#navbar").removeClass("transparent");
    $("#navbar").css("background-color", "rgba(55, 71, 79, 1.0)");

    var globalClickedEvent = null;

    $('#calendar-right').fullCalendar({
      editable: true, //Allows for drag and drop events
      eventLimit: true, //When there are more events than the day can hold, compress to a list
      googleCalendarApiKey: 'AIzaSyCb7F3cZOnQ-gmZCbFmjU6Z3DuBfe23jMo', //pull Google Calendar Events

      header :{
        left: 'today,prev,next',
        center: 'importGoogle',
        right: 'month,agendaWeek,agendaDay,listMonth'//, basicDay,basicWeek'
      },
      customButtons: {
        /* Add a Google Calendar ID to the google_calendar table */
        importGoogle: {
          text: 'Import Google Calendar',
          click: function() {
            var calendarID = prompt("Enter the Google Calendar ID");
            if (calendarID === ""){
              alert("Calendar ID was empty");
              console.log("Calendar ID was empty");
              return;
            }

            var username = <?php echo '"'.$_SESSION['username'].'"'; ?>;

            console.log(username);
            console.log("Add the Google Calendar ID to the database");
            /* Add the calendar ID to the database */
            $.ajax({
              url: "./addGoogleCalendarID.php",
              type: "POST",
              data: {"username": username, "calendarID": calendarID},
              success: function () {
                console.log("Google Calendar was added");
                //Re-render the calendar events
                location.reload();
              },
              error: function(XMLHttpRequest, textStatus, errorThrown) {
                console.log("Error adding the Google Calendar to the database");
              }
            });
          }
        }
      },
      /* Add an event to the calendar by clicking a day */
      dayClick: function(date, jsEvent, view) {
        $('#modal').modal();
        $('#modal').modal('open');

          /* When clicking on day, clears fields if it was previously filled. */
          $('#title').val('');
          $('#text-color').val('');
          $('#description').val('');
          $('#hour-start').val('');
          $('#date-end').val('');
          $('#hour-end').val('');

          /* Always fileld so should always be active */
          $('#label-day-start').addClass('active');
          $('#label-day-end').addClass('active');


          var elem = document.querySelector('#date-start');
          var instance = M.Datepicker.init(elem, options = {
            defaultDate: new Date(date.format("MMM DD, YYYY")),
            setDefaultDate: true,
            //format: "yyyy-mm-dd",
            //firstDay: 0
          });

          $('#date-start').val(date.format("MMM DD, YYYY"));

          //var elem2 = document.querySelector('#hour-start');
          //var instance2 = M.Timepicker.init(elem, options);
          $('#hour-start').timepicker();
          $('#hour-end').timepicker();


          $("#date-end").val(date.format("MMM DD, YYYY"));
          $("#date-end").click(function(){
            console.log("Click ... !");
            $(document).ready(function(){
              $('#date-end').datepicker();
              $('#date-end').datepicker('open');
            });
          })


          $("#btn-add").show();
          $("#btn-remove").hide();
          $("#btn-modify").hide();
      }, //dayClick end

      eventClick: function(calEvent, jsEvent, view){
        globalClickedEvent = calEvent.id;
        console.log("Clicked event id: " + globalClickedEvent);

        $('#modal').modal();
        $('#modal').modal('open');

        console.log(calEvent);

        $('#label-title').removeClass('active').addClass('active');
        $('#label-description').removeClass('active').addClass('active');
        $('#label-description').removeClass('active').addClass('active');
        $('#label-hour-start').removeClass('active').addClass('active');
        $('#label-hour-end').removeClass('active').addClass('active');

        //If there is color data, move the label above the text
        if (calEvent.color){
          $('#label-color').addClass('active');
        }

        $('#label-day-start').addClass('active');
        $('#label-day-end').addClass('active');

        $('#title').val(calEvent.title);
        $('#text-color').val(calEvent.color);
        $('#description').val(calEvent.description);

        $('#date-start').val(moment(calEvent.start).format("MMM DD, YYYY"));
        $('#hour-start').val(moment(calEvent.start).format("h:mm A"));

        $('#date-end').val(moment(calEvent.end).format("MMM DD, YYYY"));
        $('#hour-end').val(moment(calEvent.end).format("h:mm A"));

        if (calEvent.allDay == true) {
          $("#switch-allday").prop("checked", true);

          $('#hour-start').prop("disabled", true);
          $('#date-end').prop("disabled", true);
          $('#hour-end').prop("disabled", true);
        } else {
          $("#switch-allday").prop("checked", false);

          $('#hour-start').prop("disabled", false);
          $('#date-end').prop("disabled", false);
          $('#hour-end').prop("disabled", false);
        }

        $("#btn-modify").show();
        $("#btn-remove").show();
        $("#btn-add").hide();
      }, //eventClick end

        /* Auto resize the calendar */
        height: "auto",
        /* Pull calendar events from multiple sources */
        eventSources: [
        <?php include_once './getGoogleCalendars.php'; ?> //Adds all the user's public google calendars as eventSources
        {
          //Get google holiday events
          googleCalendarId: 'en.usa#holiday@group.v.calendar.google.com',
          editable: false
        },
        {
          url: './getCalendarEvents.php',
          success: function(data) {
            console.log("fetch succesful (./getCalendarEvents.php)");
          },
          error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.log("fetch unsuccessful (./getCalendarEvents.php)");
          }
        }], // End of event sources

      /* Handle when the user drag and drops an event */
      eventDrop: function(event, delta, revertFunc) {
        console.log("event id: " + event.id + " title: " + event.title + " was dropped on " + event.start.format() + " and ends on " + event.end + " allday: " + event.allDay);
        var end;
        var allDayBoolean;
        /* (event.end == null) -> start + 1 day
         * (event.end != null) -> end
         */
        if (event.allDay) {
          if (event.end == null) {
            end = moment(event.start.format("YYYY-MM-DD HH:mm:ss").toString()).add(1, "days");
            console.log("end = " + end);
            // $("#calendar-right").fullCalendar("updateEvent", event);
          } else {
            end = event.end;
          }
          allDayBoolean = 1;
        /* (event.end == null) -> start + 1 hour
         * (event.end != null) -> end
         */
        } else {
            console.log("start----->"+event.start.format());
            if (event.end == null) {
              end = moment(event.start.format("YYYY-MM-DD HH:mm:ss").toString()).add(1, "h");
              console.log("end ----->"+end.format());
            } else {
              end = event.end;
            }
            allDayBoolean = 0;
        }

        //console.log(event.allDay);

        /* Update the database with the new information */
        $.ajax({
          url: "./updateCalendarEvents.php",
          type: "POST",
          data: {
            "id": event.id, 
            "title": event.title,
            "start": event.start.format(), 
            "end": end.format(),
            "allDay": allDayBoolean,
            "color": event.color,
            "textColor": event.textColor
          },
          success: function () {
            console.log(event.title + " updated successful (./updateCalendarEvents.php)");
                $('#calendar-right').fullCalendar('refetchEvents');
              },
          error: function(XMLHttpRequest, textStatus, errorThrown) {
            console.log("updated unsuccessful (./updateCalendarEvents.php)");
            revertFunc();
          }
        });
        }, //End of event Drop

        /* Handle the resizing of events */
        eventResize: function(event, delta, revertFunc) {
          console.log(" title: " + event.title + " was dropped on " + event.start.format() + " ends on: " + event.end.format() + " allday: " + event.allDay);
          /* calendar_events table uses 1 and 0 to represent all day */
          if (event.allDay) {
            allDayBoolean = 1;
          } else {
            allDayBoolean = 0;
          }

          /* Update the information in the database */
          $.ajax({
            url: "./updateCalendarEvents.php",
            type: "POST",
            data: {
              "id": event.id, 
              "title": event.title,
              "start": event.start.format(), 
              "end": event.end.format(),
              "allDay": allDayBoolean,
              "color": event.color,
              "textColor": event.textColor
            },
            success: function () {
              console.log(event.title + " updated successfully (./updateCalendarEvents.php)");
              $('#calendar-right').fullCalendar('refetchEvents');
            },
            error: function(XMLHttpRequest, textStatus, errorThrown) {
              console.log("Update failed (./updateCalendarEvents.php)");
              revertFunc();
            }
          });
        } //End of event resizing
      });

/* Used to modify or add an event.  This function will collect the
 * data in the form to be sent to the database for adding/updating 
 */
function getEventData() {
  newEvent = {
    id: globalClickedEvent,
    title: $("#title").val(),
    start:moment($("#date-start").val() + " " + $("#hour-start").val() ).format('YYYY-MM-DD HH:mm:ss'),
    end:moment($("#date-end").val() + " " + $("#hour-end").val() ).format('YYYY-MM-DD HH:mm:ss'),
    allDay: $("#switchAllday").prop("checked")? 1 : 0,// $("#text-color").val()
    description: $("#description").val(),
    color: $("#color").val(),
    textColor: $("#text-color").val()
  };
}

/* Takes in an event object created om getEventData() and calls
 * the correct database action based on the action value
 */
function sendEventDataToDB(action, objEvent) {
  console.log(newEvent);
  var php = null;
  console.log(action);
  if (action == 1) {
    php = "./addCalendarEvents.php";
  } else if (action == 2) {
    php = "./updateCalendarEvents.php";
  } else if (action == 3) {
    php = "./deleteCalendarEvents.php";
  }

  $.ajax({
    type: 'POST',
        url: php,
        data: objEvent,
        success:function (msg) {
          console.log(msg);
          $("#calendar-right").fullCalendar('refetchEvents');
          $('#modal1').modal('close');
        console.log("Operation (" + php + ") successful.");
      },
      error:function(XMLHttpRequest, textStatus, errorThrown) {
        console.log(textStatus);
        console.log(errorThrown);
        console.log("Operation (" + php + ") failed.");
      }
    });
}

/* Add function when an event is added */
$("#btn-add").click(function(){
  getEventData();
  sendEventDataToDB(1, newEvent);
  $("#date-start").val('');
});

/* Add function when an event is modified */
$("#btn-modify").click(function(){
  getEventData();
  sendEventDataToDB(2, newEvent);
});

/* Add function when an event is changed to an all day event */
$("#switchAllday").click(function() {
  if ($("#switchAllday").is(":checked")) {
    $('#hour-start').prop("disabled", true);
    $('#date-end').prop("disabled", true);
    $('#hour-end').prop("disabled", true);
    console.log()
    $('#date-end').val(moment($("#date-start").val()).add(1, "days").format("MMM DD, YYYY"));
  } else {
    $('#hour-start').prop("disabled", false);
    $('#date-end').prop("disabled", false);
    $('#hour-end').prop("disabled", false);
  }
});
});