RangeFinder = require './range-finder'
beautifier = require('js-beautify')

module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', 'prettify:prettify': (event) ->
      editor = @getModel()
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
      'indent_size': atom.config.get('editor.tabLength')
    editor.setTextInBufferRange(range, text)
