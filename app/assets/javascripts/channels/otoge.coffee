App.otoge = App.cable.subscriptions.create "OtogeChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data
    if data.result
      $('#judge').text(data.result.judge)
      if data.result.continuous_combo
        $('#combo').text(String(Number($('#combo').text()) + 1))
      else
        $('#combo').text("0")
      $('#score').text(String(Number($('#score').text()) + Number(data.result.score)))
    if data.finish
      $('#finish').text(data.finish)

  judge: (judge) ->
    @perform 'judge', judge: judge

  finish: ->
    @perform 'finish', score: Number($('#score').text()), combo: Number($('#combo').text())
