<!DOCTYPE html>
<html>

<head>

  <!-- Style meta data -->
  <?php include "../includes/style-meta-data.inc.php"; ?>
  <!-- End of style meta data -->

  <link rel="stylesheet" type="text/css" href="../css/signup.css">

  <!--JavaScript at end of body for optimized loading-->
  <?php include "../includes/js-meta-data.inc.php"; ?>

  <title>Sign up</title>
</head>

<body id="home" class="scrollspy">
  <!--  Start of Header Section-->
  <header class="main-header">
    <div class="primary-overlay">

      <!-- Navigation Bar -->
      <?php include "../includes/navigation-bar.inc.php"; ?>
      <!-- End of Navigation Bar -->

      <!-- Showcase Panel -->
      <div class="showcase container">
        <div class="row">
          <div class="col s12 main-text">
            <h5>Welcome to Calendar</h5>
            <h1>Create An Account</h1>
            <div class="container transparent ">
              <div class="row transparent">

                <div class="col s12 m6 offset-m3 transparent">
                  <form method="POST" action="./handle-signup.php">
                    <div class="input-field">
                      <input type="text" id="first-name" name="firstName">
                      <label for="first-name" id="first-name-label">First Name</label>
                    </div>
                    <div class="input-field">
                      <input type="text" id="last-name" name="lastName">
                      <label for="last-name" id="last-name-label">Last Name</label>
                    </div>
                    <div class="input-field">
                      <input type="email" id="email" name="email">
                      <label for="email" id="email-label">Email</label>
                    </div>
                    <div class="input-field">
                      <input type="text" id="username" name="username">
                      <label for="username" id="username-label">Username</label>
                    </div>
                    <div class="input-field">
                      <input type="password" id="password" name="password">
                      <label for="password" id="password-label">Password</label>
                    </div>
                    <div class="input-field">
                      <input type="text" id="calendar-name" name="calendarName">
                      <label for="calendar-name" id="calendar-name-label">Calendar Name</label>
                    </div>

                    <input type="submit" value="Sign up" class="btn btn-large purple btn-extend">
                  </form>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </header>
  <!--  End of Header Section -->





  <!-- Footer -->
  <footer class="page-footer blue-grey darken-1">
    <?php include "../includes/footer.inc.php"; ?>
  </footer>
  <!-- End of footer-->

  <script>
    $(document).ready(function () {
      // Init Sidenav
      $('.button-collapse').sideNav();

      // Init Scrollspy
      $('.scrollspy').scrollSpy()

      // ScrollFire
      const options = [
      {
        selector: '.main-text', offset: 0, callback: function (el) {
          M.fadeInImage($(el));
        }
      },
      {
        selector: '.navbar-fixed', offset: 1500, callback: function () {
          $('nav').removeClass('transparent');
          $('nav').addClass('blue-grey darken-4');
        }
      },

      ];

      M.scrollFire(options);

    });

    $(document).ready(function () {
      // First name field
      $("#first-name").focus(function() {
        $("#first-name-label").addClass("active");
      });
      $("#first-name").focusout(function() {
        if ($("#first-name").val() == '') {
          $("#first-name-label").removeClass("active");
        }
      });

      // Last name field
      $("#last-name").focus(function() {
        $("#last-name-label").addClass("active");
      });
      $("#last-name").focusout(function() {
        if ($("#last-name").val() == '') {
          $("#last-name-label").removeClass("active");
        }
      });

      // Email field
      $("#email").focus(function() {
        $("#email-label").addClass("active");
      });
      $("#email").focusout(function() {
        if ($("#email").val() == '') {
          $("#email-label").removeClass("active");
        }
      });

      // Username field
      $("#username").focus(function() {
        $("#username-label").addClass("active");
      });
      $("#username").focusout(function() {
        if ($("#username").val() == '') {
          $("#username-label").removeClass("active");
        }
      });

      // Password field
      $("#password").focus(function() {
        $("#password-label").addClass("active");
      });
      $("#password").focusout(function() {
        if ($("#password").val() == '') {
          $("#password-label").removeClass("active");
        }
      });

      // Calendar Name field
      $("#calendar-name").focus(function() {
        $("#calendar-name-label").addClass("active");
      });
      $("#calendar-name").focusout(function() {
        if ($("#calendar-name").val() == '') {
          $("#calendar-name-label").removeClass("active");
        }
      });
    });
  </script>
</body>


</html>
