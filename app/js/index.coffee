file = require 'file.js'
gui = require 'nw.gui'

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
    when 'n'
      event.preventDefault()
      gui.Window.open 'index.html'

$('#open').change -> file.open this.value, document

$('#save').change -> file.save this.value, document

win = gui.Window.get()
menu = new gui.Menu {type: 'menubar'}
file = new gui.Menu()

file.append new gui.MenuItem(
  {
    label: 'New',
    click: -> gui.Window.open 'index.html'
  }
)
file.append new gui.MenuItem {type: 'separator'}
file.append new gui.MenuItem(
  {
    label: 'Close',
    click: -> gui.Window.get().close()
  }
)

win.menu = menu
win.menu.insert new gui.MenuItem({label: 'File', submenu: file}), 1

document.getElementById('editor').addEventListener 'paste', (e) ->
  e.preventDefault()
  text = e.clipboardData.getData 'text/plain'
  document.execCommand 'insertHTML', false, text
