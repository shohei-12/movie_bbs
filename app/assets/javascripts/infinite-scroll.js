$(function () {
  // infinite scroll

  $(".jscroll").jscroll({
    contentSelector: ".jscroll",
    nextSelector: ".pagination a[rel='next']",
  });
});
