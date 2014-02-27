RangeFinder = require './range-finder'
beautifier = require('js-beautify')

module.exports =
  activate: ->
    atom.workspaceView.command 'prettify:prettify', '.editor', ->
      editor = atom.workspaceView.getActivePaneItem()
      prettify(editor)

prettify = (editor) ->
  fileExt = editor.getTitle()?.split('.').pop()
  beautify = switch
    when fileExt == "html" then beautifier.html
    when fileExt == "js" then beautifier.js_beautify
    when fileExt == "json" then beautifier.js_beautify
    when fileExt == "css" then beautifier.css
    when fileExt == "less" then beautifier.css
    when fileExt == "scss" then beautifier.css
  sortableRanges = RangeFinder.rangesFor(editor)
  sortableRanges.forEach (range) ->
    text = editor.getTextInBufferRange(range)
    text = beautify text,
      "indent_size": 2
    editor.setTextInBufferRange(range, text)
