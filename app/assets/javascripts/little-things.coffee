# All the little things

ready = ->
  # get rid of the flash notice after 5 seconds
  $('.js-fadeUp').delay(5000).slideUp(400)

$(document).ready(ready)
$(document).on('page:load', ready)