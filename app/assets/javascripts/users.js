$(function () {
  // Change the color of the icon when the input field is focused

  $(".form-name-field").focus(function () {
    $(".fa-user").css("color", "#000");
  });
  $(".form-name-field").blur(function () {
    $(".fa-user").css("color", "#aaa");
  });

  $(".form-email-field").focus(function () {
    $(".fa-envelope").css("color", "#000");
  });
  $(".form-email-field").blur(function () {
    $(".fa-envelope").css("color", "#aaa");
  });

  $(".form-password-field").focus(function () {
    $(".key").css("color", "#000");
  });
  $(".form-password-field").blur(function () {
    $(".key").css("color", "#aaa");
  });

  $(".form-confirmation-field").focus(function () {
    $(".c-key").css("color", "#000");
  });
  $(".form-confirmation-field").blur(function () {
    $(".c-key").css("color", "#aaa");
  });
});
