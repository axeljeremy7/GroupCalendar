<?php
    /* It's an included file so it gets its session start from the includer file */
    // session_start();
    require_once('../includes/databaseConnection.php'); //Make the connection to the database

    $username = $_SESSION['username'];

    $sql = "SELECT * FROM google_calendar WHERE username = '". $_SESSION['username'] ."'";

    try {
        $result = $pdo->query($sql);

        $returnString = "";
        while ($calendar = $result->fetch(PDO::FETCH_ASSOC)) {
            $returnString .= "{ googleCalendarId: '". $calendar['google_calendar'] . "', editable: false },";
        }
    } catch (PDOException $e) {
        echo "Error (google_calendar): $e";
    }



    echo $returnString;
    ?>
