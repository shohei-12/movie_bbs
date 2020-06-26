$(function () {
  // Change the color of the icon when the input field is focused

  $(".user-signup #user_name").focus(function () {
    $(".user-signup .fa-user").css("color", "#000");
  });
  $(".user-signup #user_name").blur(function () {
    $(".user-signup .fa-user").css("color", "#aaa");
  });

  $(".user-signup #user_email").focus(function () {
    $(".user-signup .fa-envelope").css("color", "#000");
  });
  $(".user-signup #user_email").blur(function () {
    $(".user-signup .fa-envelope").css("color", "#aaa");
  });

  $(".user-signup #user_password").focus(function () {
    $(".user-signup .key").css("color", "#000");
  });
  $(".user-signup #user_password").blur(function () {
    $(".user-signup .key").css("color", "#aaa");
  });

  $(".user-signup #user_password_confirmation").focus(function () {
    $(".user-signup .c-key").css("color", "#000");
  });
  $(".user-signup #user_password_confirmation").blur(function () {
    $(".user-signup .c-key").css("color", "#aaa");
  });
});
