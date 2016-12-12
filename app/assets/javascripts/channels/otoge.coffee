App.otoge = App.cable.subscriptions.create "OtogeChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # Called when there's incoming data on the websocket for this channel
    console.log data
    $('#judge').html(data.judge.judge)

  judge: (judge) ->
    @perform 'judge', judge: judge
