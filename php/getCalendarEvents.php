<?php
    /*
     * Documentation for getCalendarEvents.php
     * Summary: getCalendarEvents will query the database for all the events (dates) that should be
     * 	displayed on the calendar for the user.
     *
     *	Step 1: Set local variables to start and end date ranges
     *	Step 2: Select the data from the database
     *	Step 3: Format the data as specified with key : value attributes in https://fullcalendar.io/docs/event-object
     *	Step 4: Convert the data into Event objects to be returned to the client
     *	Step 5: Send JSON to the client

    //This can be used to add events to the calendar_events table for testing
    INSERT INTO `calendar_events`(`calendar_id`, `name`, `start_date`, `end_date`) VALUES ("1","4430 Assignment","2018-03-29 08:20:20", "2018-03-30 08:20:20")
    */
    //Start the session to access the array
    session_start();

    require_once('../includes/databaseConnection.php'); //Make the connection to the database
    require_once('../php/fullCalendarUtil.php'); //Includes the Event class and the datetime utilities (provided by FullCalendar.io)

    /* Step 1: Set variables for start and end date ranges */
    //Short-circuit if the client did not give us a date range.
    if (!isset($_GET['start']) || !isset($_GET['end'])) {
        die("Please provide a date range.");
    }

    // Parse the start/end parameters.
    // These are assumed to be ISO8601 strings with no time nor timezone, like "2013-12-29".
    // Since no timezone will be present, they will parsed as UTC.
    $range_start = parseDateTime($_GET['start']);
    $range_end = parseDateTime($_GET['end']);

    //Set the $_SESSION parameters for the side bar in calendar.php
    // $_SESSION['start'] = $_GET['start'];
    // $_SESSION['end'] = $_GET['end'];

    /* Test start and end ranges */
    // $range_start = parseDateTime("2018-04-01");
    // $range_end = parseDateTime("2018-04-30");
    // $_SESSION['username'] = 'user1';

    // Parse the timezone parameter if it is present.
    $timezone = null;
    if (isset($_GET['timezone'])) {
        $timezone = new DateTimeZone($_GET['timezone']);
    }


    /* Step 2: Select the data from the database */
    $all_events = array(); //Holds all the events for the user

    /* Step 2a: Get the calendars the user has access to */
    $sql = "SELECT calendar_id FROM calendar_rights WHERE username = '" . $_SESSION['username'] . "'";
    try {
        $userCalendars = $pdo->query($sql);
    } catch (PDOException $e) {
        echo "Error (./getCalendarEvents.php [infile]): $e";
    }

    // print_r($userCalendars);

    /* Step 2b: Iterate through the calendars and add all events for those calendars to the $all_events array */
    $results = array(); // Holds all the events that are found for the user
    while ($singleCalendar = $userCalendars->fetch()) {
        $sql = "SELECT * FROM calendar_events WHERE calendar_id = '" . $singleCalendar['calendar_id'] . "'";

        try {
            $allEvents = $pdo->query($sql);
        } catch (PDOException $e) {
            echo "Error (./getCalendarEvents.php [infile]): $e";
        }

        /* Step 3: Format the data as specified with key : value attributes in https://fullcalendar.io/docs/event-object */
        while ($row = $allEvents->fetch()) {
            // echo $row['name'];
            // echo $row['calendar_id'];
            $results[] = array(
                    "id"			=> $row['event_id'],
                    "title"			=> $row['title'],
                    "start"			=> $row['start_date'],
                    "end"			=> $row['end_date'],
                    "allDay"		=> $row['all_day'],
                    "description" 	=> $row['description'],
                    "color" 		=> $row['color'],
                    "textColor" 	=> $row['text_color']
                );
        }
    }

    /* Step 4: Convert the data into Event objects to be returned to the client */
    // Accumulate an output array of event data arrays.
    $output_arrays = array();
    foreach ($results as $array) {
        //Convert the input array into a useful Event object
        $event = new Event($array, $timezone);

        //If the event is in-bounds, add it to the output
        if ($event->isWithinDayRange($range_start, $range_end)) {
            $output_arrays[] = $event->toArray();
        }
    }
    /* Step 5:  Send JSON to the client */
    echo json_encode($output_arrays);
?>
