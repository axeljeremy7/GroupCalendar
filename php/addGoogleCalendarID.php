<?php
    require_once('../includes/databaseConnection.php'); //Make the connection to the database

session_start();// essential for session variables
    $calendarID = $_POST['calendarID'];
    $username = $_SESSION['username'];
echo json_encode([$calendarID,$username]);
    try {
        // $stmt->beginTransaction();
        $stmt = $pdo->prepare("
			INSERT google_calendar(username, google_calendar)
			VALUES(:username, :calendarID)");

        $stmt->bindParam(":username", $username);
        $stmt->bindParam(":calendarID", $calendarID);

        $stmt->execute();
    } catch (PDOException $e) {
        echo "Erro: $e";
    }
// it adds correclty
?>
