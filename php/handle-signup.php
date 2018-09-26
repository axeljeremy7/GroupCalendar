<?php
require_once("../includes/databaseConnection.php");
session_start();

$emailReg = '/^(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){255,})(?!(?:(?:\\x22?\\x5C[\\x00-\\x7E]\\x22?)|(?:\\x22?[^\\x5C\\x22]\\x22?)){65,}@)(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22))(?:\\.(?:(?:[\\x21\\x23-\\x27\\x2A\\x2B\\x2D\\x2F-\\x39\\x3D\\x3F\\x5E-\\x7E]+)|(?:\\x22(?:[\\x01-\\x08\\x0B\\x0C\\x0E-\\x1F\\x21\\x23-\\x5B\\x5D-\\x7F]|(?:\\x5C[\\x00-\\x7F]))*\\x22)))*@(?:(?:(?!.*[^.]{64,})(?:(?:(?:xn--)?[a-z0-9]+(?:-+[a-z0-9]+)*\\.){1,126}){1,}(?:(?:[a-z][a-z0-9]*)|(?:(?:xn--)[a-z0-9]+))(?:-+[a-z0-9]+)*)|(?:\\[(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){7})|(?:(?!(?:.*[a-f0-9][:\\]]){7,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,5})?)))|(?:(?:IPv6:(?:(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){5}:)|(?:(?!(?:.*[a-f0-9]:){5,})(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3})?::(?:[a-f0-9]{1,4}(?::[a-f0-9]{1,4}){0,3}:)?)))?(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))(?:\\.(?:(?:25[0-5])|(?:2[0-4][0-9])|(?:1[0-9]{2})|(?:[1-9]?[0-9]))){3}))\\]))$/iD';


if (!empty($_POST)) {
    $first = ucwords($_POST['firstName']);
    $last = ucwords($_POST['lastName']);
    $email = strtolower($_POST['email']);
    $username = $_POST['username'];
    $password = $_POST['password'];
    $calendarName = $_POST['calendarName'];
    $error;

    if (empty($first)) {
        $error = 'emptyfname=1';
    }
    if (empty($last)) {
        if (empty($error)) {
            $error = 'emptylname=1';
        } else {
            $error .= '&emptylname=1';
        }
    }
    if (empty($email)) {
        if (empty($error)) {
            $error = 'emptyemail=1';
        } else {
            $error .= '&emptyemail=1';
        }
    }
    if (empty($username)) {
        if (empty($error)) {
            $error = 'emptyusername=1';
        } else {
            $error .= '&emptyusername=1';
        }
    }
    if (empty($password)) {
        if (empty($error)) {
            $error = 'emptypass=1';
        } else {
            $error .= '&emptypass=1';
        }
    }
    if (empty($calendarName)) {
        if (empty($error)) {
            $error = 'emptycalendarname=1';
        } else {
            $error .= '&emptycalendarname=1';
        }
    }
    if (!empty($error)) {
        header('Location: ./signup.php?'.$error.'');
        exit();
    } else {
        $sql = "SELECT COUNT(*) FROM user_info WHERE email = $email";
        $result = $pdo->prepare($sql);
        $result->execute();
        $emailExists = $result->fetchColumn();


        $sql = "SELECT COUNT(*) FROM users WHERE username = $username";
        $result = $pdo->prepare($sql);
        $result->execute();
        $usernameExists = $result->fetchColumn();

        if (!preg_match($emailReg, $email)) {
            $error = 'emailformat=1';
        } elseif ($emailExists > 0) {
            $error = 'emailtaken=1';
        }
        if ($usernameExists > 0) {
            if (!empty($error)) {
                $error .= '&usernametaken=1';
            } else {
                $error = 'usernametaken=1';
            }
        }

        if (!empty($error)) {
            header('Location: ./signup.php?'.$error.'');
            exit();
        } else {
            try {
                $pdo->beginTransaction();
                $sql = "
				INSERT INTO users(username, password) VALUES(:username, :password);
				INSERT INTO user_info(username, first_name, last_name, email) VALUES(:username, :first, :last, :email);
				";

                $statement = $pdo->prepare($sql);

                $statement->bindParam(":username", $username);
                $statement->bindParam(":password", $password);
                $statement->bindParam(":first", $first);
                $statement->bindParam(":last", $last);
                $statement->bindParam(":email", $email);

                $statement->execute();


                $statement = $pdo->prepare("INSERT INTO calendar(calendar_name) VALUES(:calendarName);");
                $statement->bindParam(":calendarName", $calendarName);
                $statement->execute();

                $id = $pdo->lastInsertId();

                $statement = $pdo->prepare("INSERT INTO calendar_rights(calendar_id, username, permission) VALUES(:id, :username, 1);");
                $statement->bindParam(":username", $username);
                $statement->bindParam(":id", $id);
                $statement->execute();

                $pdo->commit();

                header('Location: ./homepage.php?success=1');
            } catch (PDOException $e) {
                $pdo->rollback();
                echo "Error $e";
            }
        }
    }
}
?>
