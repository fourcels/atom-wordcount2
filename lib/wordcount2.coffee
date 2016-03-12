Wordcount2View = require './wordcount2-view'
{CompositeDisposable} = require 'atom'

module.exports = Wordcount2 =
  wordcount2View: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @wordcount2View = new Wordcount2View(state.wordcount2ViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @wordcount2View.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'wordcount2:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @wordcount2View.destroy()

  serialize: ->
    wordcount2ViewState: @wordcount2View.serialize()

  toggle: ->
    console.log 'Wordcount2 was toggled!'
    console.log 'Just A Test.'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      editor = atom.workspace.getActiveTextEditor()
      words = editor.getText().split(/\s+/).length
      @wordcount2View.setCount(words)
      @modalPanel.show()
