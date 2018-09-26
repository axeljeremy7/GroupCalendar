<?php
    require_once('../includes/databaseConnection.php'); //Make the connection to the database

    $event_id 		= $_POST["id"];
    $title			= $_POST["title"];
    $startDate 		= $_POST["start"];
    $endDate 		= $_POST["end"];
    $allDay			= $_POST["allDay"];
    $description	= $_POST["description"];
    $color			= $_POST["color"];
    $textColor		= $_POST["textColor"];

    try {
        // $stmt->beginTransaction();
        $stmt = $pdo->prepare("
			UPDATE calendar_events
			SET title = :title, start_date = :startDate, end_date = :endDate, all_day = :allDay, description = :description, color = :color, text_color = :textColor
			WHERE event_id = (:event_id);
			");

        $stmt->bindParam(":event_id", $event_id);
        $stmt->bindParam(":title", $title);
        $stmt->bindParam(":startDate", $startDate);
        $stmt->bindParam(":endDate", $endDate);
        $stmt->bindParam(":allDay", $allDay);
        $stmt->bindParam(":description", $description);
        $stmt->bindParam(":color", $color);
        $stmt->bindParam(":textColor", $textColor);

        $stmt->execute();
        echo $allDay;
        // $stmt->commit();
    } catch (PDOException $e) {
        // $stmt->rollback();
        echo "Erro: $e";
    }
    ?>
