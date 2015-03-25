RangeFinder = require './range-finder'
beautify = require('js-beautify').html

module.exports =
  activate: ->
    atom.commands.add 'atom-text-editor', 'prettify:prettify': (event) ->
      editor = @getModel()
      prettify(editor)

prettify = (editor) ->
  sortableRanges = RangeFinder.rangesFor(editor)
  sortableRanges.forEach (range) ->
    text = editor.getTextInBufferRange(range)
    text = beautify text,
      'indent_size': atom.config.get('editor.tabLength')
    editor.setTextInBufferRange(range, text)
