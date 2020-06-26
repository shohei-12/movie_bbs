$(function () {
  // Hamburger menu

  $(".menu-btn").click(function () {
    $(this).toggleClass("active");
    $(".menu").slideToggle(200);
  });

  $(window).resize(function () {
    var x = $(window).width();
    var y = 768;
    if (x > y) {
      $(".menu-btn").removeClass("active");
      $(".menu").removeAttr("style");
    }
  });

  // Show current navigation

  $("header nav a").each(function () {
    var $href = $(this).attr("href");
    if (location.pathname == $href) {
      $(this).addClass("current");
    } else {
      $(this).removeClass("current");
    }
  });
});
