<?php

function dbConnection()
{
    $servername = "localhost";
    $username = "root";
    $password = "root";// Axel password is root.
    $database = "group_calendar";

    try {
        return new PDO("mysql:host=$servername;dbname=$database", $username, $password);
    } catch (PDOException $e) {
        // handle exceptions accordingly
        echo $e;
    }
}

$pdo = dbConnection();
