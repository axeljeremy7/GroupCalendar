<?php
/* Called by login.php
 * Summary: This file queries the database for the user and username.
 * If the query is successful, the page is redirected to calendar.php.
 * Otherwise the page is redirected to login.php.
 */
session_start();
require_once '../includes/databaseConnection.php';


if (!empty($_POST)) {
    $id = '';
    $first = '';
    $last = '';
    $username = $_POST['username'];
    $password = $_POST['password'];
    $error;

    if (empty($username)) {
        $error = 'emptyusername=1';
    }

    if (empty($password)) {
        if (empty($error)) {
            $error = 'emptypass=1';
        } else {
            $error .= '&emptypass=1';
        }
    }

    if (!empty($error)) {
        header('Location: ./login.php?'.$error.'');
        exit();
    } else {
        $statement = $pdo->prepare("SELECT * FROM users, user_info WHERE users.username = :username AND users.password = :password AND users.username = user_info.username");

		$statement->bindParam(":username", $username);
		$statement->bindParam(":password", $password);
		$statement->execute();
		if ($row = $statement->fetch(PDO::FETCH_ASSOC)) {
			$_SESSION['username'] 	= $row['username'];
			$_SESSION['firstName'] 	= $row['first_name'];
			$_SESSION['lastName'] 	= $row['last_name'];
			$_SESSION['email'] 		= $row['email'];
			


			header('Location: ./calendar.php?success=1');
		} else {
			header('Location: ./login.php?usernotfound=1');
			exit();
		}

    }
}
?>
