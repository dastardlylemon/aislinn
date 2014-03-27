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

$(document).ready ->
  $('#editor').bind 'paste', (event) ->
    before = $('#editor').html()
    setTimeout (->
      after = $('#editor').html()
      p1 = -1
      p2 = -1
      i = 0
      while i < after.length
        if p1 == -1 and before.substr(i, 1) != after.substr(i, 1) then p1 = i
        if p2 == -1 and before.substr(before.length-i-1, 1) != after.substr(before.length-i-1, 1)
        then p2 = i
        i++
      pasted = after.substr p1-1, after.length-p2-p1+2
      replace = pasted.replace /<[^>]+>/g, ''
      replaced = after.substr(0, p1-1)+replace+after.substr(p1-1+pasted.length)
      $('#editor').html replaced
    ), 100
