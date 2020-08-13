$(document).on("turbolinks:load", function () {
  var $userMenu = $(".js-userMenu");
  var $userMenuList = $(".js-userMenuList");

  $userMenu.on("click", function () {
    $userMenuList.slideToggle("fast");
  });
});
