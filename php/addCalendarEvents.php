<?php
    session_start();
    require_once('../includes/databaseConnection.php'); //Make the connection to the database

    $calendarId 	= $pdo->query("SELECT calendar_id FROM calendar_rights WHERE username = '".$_SESSION["username"]."'")->fetch(PDO::FETCH_ASSOC)["calendar_id"];
    $title			= $_POST["title"];
    $startDate 		= $_POST["start"];
    $endDate 		= $_POST["end"];
    $allDay			= $_POST["allDay"];
    $description	= $_POST["description"];
    $color 			= $_POST["color"];
    $textColor 		= $_POST["textColor"];


    try {
        $stmt = $pdo->prepare("
			INSERT INTO calendar_events(calendar_id, title, start_date, end_date, all_day, description, color, text_color)
			VALUES(:calendarId, :title, :startDate, :endDate, :allDay, :description, :color, :textColor);
			");

        $stmt->bindParam(":calendarId", $calendarId);
        $stmt->bindParam(":title", $title);
        $stmt->bindParam(":startDate", $startDate);
        $stmt->bindParam(":endDate", $endDate);
        $stmt->bindParam(":allDay", $allDay);
        $stmt->bindParam(":description", $description);
        $stmt->bindParam(":color", $color);
        $stmt->bindParam(":textColor", $textColor);

        $stmt->execute();
        echo json_encode($stmt);
    } catch (PDOException $e) {
        echo "Erro: $e";
    }
    ?>
