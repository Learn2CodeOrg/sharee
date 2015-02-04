$(document).ready ->
  menuToggle = $("#js-mobile-menu").unbind()
  menuToggle.on "click", (e) ->
    e.preventDefault()
    $("#js-navigation-menu").slideToggle ->
      $("#js-navigation-menu").addClass "show"
      return

    return

  return

