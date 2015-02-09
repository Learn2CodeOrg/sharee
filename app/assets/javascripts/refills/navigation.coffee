ready = ->
  menuToggle = $("#js-mobile-menu").unbind()
  menuToggle.on "touchstart", (e) ->
    e.preventDefault()
    $("#js-navigation-menu").slideToggle "fast", ->
      $("#js-navigation-menu").addClass "show"
      return
    return
  return

$(document).ready(ready)
$(document).on('page:load', ready)