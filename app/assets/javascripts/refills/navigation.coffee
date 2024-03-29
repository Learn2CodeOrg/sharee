ready = ->
  menuToggle = $("#js-mobile-menu").unbind()
  menuShown = false
  menuToggle.on "click", (e) ->
    e.preventDefault()
    menuShown = true
    $("#js-navigation-menu").slideToggle "fast", ->
      $("#js-navigation-menu").addClass "show"

  $('section').on "click", (e) ->
    if menuShown
      $("#js-navigation-menu").slideUp "fast", ->
        $("#js-navigation-menu").removeClass "show"
        menuShown = false
    $(".js-dropdown-menu").hide()

  $(".js-nav-link").on "click", (e) ->
    if menuShown
      $("#js-navigation-menu").hide()
      menuShown = false
      return

  $(".js-dropdown-menu-toggle").on "click", (e) ->
    e.preventDefault()
    $(".js-dropdown-menu").toggle()

$(document).ready(ready)
$(document).on('page:load', ready)