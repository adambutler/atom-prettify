RangeFinder = require './range-finder'
beautifier = require('js-beautify')

module.exports =
  activate: ->
    atom.workspaceView.command 'prettify:prettify', '.editor', ->
      editor = atom.workspaceView.getActivePaneItem()
      prettify(editor)

prettify = (editor) ->
  scopeName = editor.getGrammar()?.scopeName
  beautify = switch
    when scopeName is "text.html.basic" then beautifier.html
    when scopeName is "source.js" then beautifier.js_beautify
    when scopeName is "source.json" then beautifier.js_beautify
    when scopeName is "source.css" then beautifier.css
    when scopeName is "source.css.less" then beautifier.css
    when scopeName is "source.scss" then beautifier.css
  sortableRanges = RangeFinder.rangesFor(editor)
  sortableRanges.forEach (range) ->
    text = editor.getTextInBufferRange(range)
    text = beautify text,
      "indent_size": 2
    editor.setTextInBufferRange(range, text)
