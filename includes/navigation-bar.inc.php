<!-- Start of Navigation bar-->
<div class="navbar-fixed" id="navbar-switch">
  <nav class="transparent" id="navbar">
    <div class="container">
      <div class="nav-wrapper">
        <?php if (isset($_SESSION["username"]) && $_SESSION["username"] != "") {
    ?>
<ul class="left hide-on-med-and-down">

  <li>
    <a class="waves-effect waves-teal btn-flat" id="zoom-button"><i class="material-icons">zoom_out_map</i></a>

  </li>
    </ul>
    <?php
}
?>
<a href="../php/calendar.php" class="brand-logo">  Calendar</a>
        <a href="#" data-target="mobile-demo" class="sidenav-trigger"><i class="material-icons">menu</i></a>

        <ul class="right hide-on-med-and-down">

          
          <?php if (isset($_SESSION["username"]) && $_SESSION["username"] != "") {
    echo '<li ><a href="../php/logout.php" id="logOutButton">Log out</a></li>';
    echo '<li><a href="../php/calendar.php" class="btn blue">' . $_SESSION['username'] . '</a></li>';
} else {
  echo '  <li>
      <a href="../index.php">Home</a>
    </li>';
    echo '<li>
      <a href="../index.php#contact">Contact</a>
    </li>';
    echo '<li><a href="../php/signup.php">Sign up</a></li>';
    echo '<li><a href="../php/login.php" class="btn blue">Log In</a></li>';
}
          ?>
        </ul>
      </div>
    </div>
  </nav>
</div>

<!-- Side nav for mobile devices-->
<ul class="sidenav " id="mobile-demo">
  <li>
    <div class="user-view">

      <?php if (isset($_SESSION["username"]) && $_SESSION["username"] != "") {
              ?>
          <div class="background">
            <img src="../img/lion.jpg" alt="">
          </div>
          <a href="#">
            <img src="../img/iron2.jpg" alt="" class="circle">
          </a>

          <a href="#">
          <span class="name white-text"><?php echo $_SESSION['username']; ?></span>
        </a>
        <a href="#">
          <span class="email white-text"><?php echo $_SESSION['email']; ?></span>
        </a>
        <?php
          } else {
              ?>
      <ul>
      <li>
        <a href="../php/homepage.php#about">About</a>
      </li>
      <li>
        <a href="../php/homepage.php#features">Features</a>
      </li>
      </ul>
      <?php
          }
        ?>
    </div>
  </li>

  <li>
    <div class="divider"></div>
  </li>
  <li>
    <a href="../php/homepage.php">Home</a>
  </li>
  <li>
    <a href="../php/homepage.php#contact">Contact</a>
  </li>
  <li>
    <div class="divider"></div>
  </li>
  <?php
  if (isset($_SESSION["username"]) && $_SESSION != "") {
      ?>
    <li>
      <a href="../php/logout.php" class="btn red">Log out</a>
    </li>


    <?php
  } else {
      ?>
    <li>
      <a href="../php/signup.php">Sign up</a>
    </li>
    <li>
      <div class="divider"></div>
    </li>
    <li>
      <a href="../php/login.php" class="btn blue">Login</a>
    </li>
    <?php
  }
  ?>
</ul>
<!-- End of side nav for mobile devies-->

<!-- Log out function -->
<script type='text/javascript'>
  $(document).ready(function(){
    $('.sidenav').sidenav();
  });
</script>
