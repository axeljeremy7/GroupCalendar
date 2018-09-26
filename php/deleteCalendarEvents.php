<?php
    require_once('../includes/databaseConnection.php'); //Make the connection to the database

    $event_id = $_POST["id"];

    try {
        $stmt = $pdo->prepare("
			DELETE FROM calendar_events WHERE event_id = :event_id");

        $stmt->bindParam(":event_id", $event_id);

        $stmt->execute();
        echo json_encode($stmt);
    } catch (PDOException $e) {
        echo "Erro: $e";
    }
?>