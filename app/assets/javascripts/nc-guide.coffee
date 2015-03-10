# New campaign setting guide

ready = ->
  nameField = $('#campaign_name')
  urlField = $('#campaign_url')
  commissionField = $('#campaign_commission')

  nameHelp = $('#campaign_name-help')
  urlHelp = $('#campaign_url-help')
  commissionHelp = $('#campaign_commission-help')

  nameField.focus ->
    urlHelp.hide()
    commissionHelp.hide()
    nameHelp.fadeIn()

  urlField.focus ->
    nameHelp.hide()
    commissionHelp.hide()
    urlHelp.fadeIn()

  commissionField.focus ->
    nameHelp.hide()
    urlHelp.hide()
    commissionHelp.fadeIn()

$(document).ready(ready)
$(document).on('page:load', ready)