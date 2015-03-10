# New campaign setting guide

ready = ->
  $(document).on 'focus', '#campaign_name', (event) ->
    $('#campaign_url-help').hide()
    $('#campaign_commission-help').hide()
    $('#campaign_name-help').fadeIn()

  $(document).on 'focus', '#campaign_url', (event) ->
    $('#campaign_name-help').hide()
    $('#campaign_commission-help').hide()
    $('#campaign_url-help').fadeIn()

  $(document).on 'focus', '#campaign_commission', (event) ->
    $('#campaign_name-help').hide()
    $('#campaign_url-help').hide()
    $('#campaign_commission-help').fadeIn()

$(document).ready(ready)
$(document).on('page:load', ready)