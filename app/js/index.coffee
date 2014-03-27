file = require('file.js');

clickInput = (id) ->
  event = document.createEvent 'MouseEvents'
  event.initMouseEvent 'click'
  document.getElementById(id).dispatchEvent event

$(window).bind 'keydown', (event) ->
  if event.ctrlKey or event.metaKey
  then switch String.fromCharCode(event.which).toLowerCase()
    when 's'
      event.preventDefault()
      clickInput 'save'
    when 'o'
      event.preventDefault()
      clickInput 'open'
