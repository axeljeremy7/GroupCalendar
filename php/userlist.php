<?php
  //session_start();
    require_once('../includes/databaseConnection.php'); //Make the connection to the database

//session_start();
$username = $_SESSION['username'];



///// OBTAIN CALENDAR OF TO THE USER GIVEN
$calendarID ;
try {
    $sql = "SELECT calendar_id FROM calendar_rights WHERE username = '" . $username. "'";
    $stmt = $pdo->query($sql);
    $calendarID = $stmt->fetch();
} catch (PDOException $e) {
    echo "Error: $e";
}


$calendarId = $calendarID[0];
$results = array();
try {
    $sql = "SELECT calendar_id FROM calendar_rights WHERE username = '" . $username. "'
    AND calendar_id != '" . $calendarId. "'";
    $stmt = $pdo->query($sql);

    while ($rows = $stmt->fetch()) {
      $sql = "SELECT username FROM user_info WHERE info_id = '" . $rows['calendar_id'] . "'";

      try {
          $rows2 = $pdo->query($sql);
      } catch (PDOException $e) {
          echo "Error (./getCalendarEvents.php [infile]): $e";
      }
      while ($rows3 = $rows2->fetch()) {
        $results[] = $rows3['username'];

      }

    }
} catch (PDOException $e) {
    echo "Error: $e";
}
//echo json_encode($results);
if (!empty($results)) {
  echo '<div class="col s12" >
    <div class="card" style="padding:0;">';//style="font-size:0.9em"


echo '<ul class="collection with-header" id="user-list">';
echo '<li class="collection-header" style="padding:0.4em;">
  <h5 style="font-size:0.9em">';
  echo "Added users' calendar:</h5>
</li>";
  foreach ($results as $value) {

    echo '<li class="collection-item">
          <div id="user-name" style="font-size:0.8em;">';

    echo $value;

    echo  '<a href="#!" class="secondary-content delete" >
              <i class="material-icons">close</i>
            </a>
          </div>
        </li>';

  }
  echo "  </ul>

  </div>
</div>";
}



?>
