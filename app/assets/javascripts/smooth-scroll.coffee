ready = ->
  $('a[href*=#]').click ->
    $("#js-navigation-menu").slideToggle "fast", ->
      $("#js-navigation-menu").removeClass "show"
    target = $(this.hash)
    if (target.length)
      $('html,body').animate
        scrollTop: target.offset().top
        ,500
      return false

$(document).ready(ready)
$(document).on('page:load', ready)