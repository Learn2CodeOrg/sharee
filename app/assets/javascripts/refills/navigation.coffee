ready = ->
  menuToggle = $("#js-mobile-menu").unbind()
  menuShown = false
  menuToggle.on "click", (e) ->
    e.preventDefault()
    menuShown = true
    $("#js-navigation-menu").slideToggle "fast", ->
      $("#js-navigation-menu").addClass "show"

  ###$(document).on "click", (e) ->
    if menuShown
      $("#js-navigation-menu").slideUp "fast", ->
        $("#js-navigation-menu").removeClass "show"###

  $(".js-nav-link").on "click", (e) ->
    if menuShown
      $("#js-navigation-menu").hide()
      menuShown = false

$(document).ready(ready)
$(document).on('page:load', ready)