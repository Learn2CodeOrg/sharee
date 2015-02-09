ready = ->
  menuToggle = $("#js-mobile-menu").unbind()
  menuToggle.on "touchstart", (e) ->
    e.preventDefault()
    $("#js-navigation-menu").slideToggle "fast", ->
      $("#js-navigation-menu").addClass "show"
  $(document).on "click", (e) ->
    $("#js-navigation-menu").slideToggle "fast", ->
      $("#js-navigation-menu").removeClass "show"

$(document).ready(ready)
$(document).on('page:load', ready)