<?php
require_once '../includes/databaseConnection.php';
session_start();
session_destroy();
header('Location: ./homepage.php');
?>