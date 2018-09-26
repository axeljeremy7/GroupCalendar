<?php
session_start();

$_SESSION['username'] = '';

echo json_encode(array('success' => 'success'));
exit();
?>